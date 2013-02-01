require 'spec_helper'

describe GenigamesConnector::Learner do
  before(:all) do
    @valid_empty = %!{"user":{"student":{"reputation":0}}}!
    @valid = %!{"user":{"student":{"reputation":50}},"task":{"Task 1":{"completed":true,"reputationEarned":35}}}!
    @valid_updated_score = %!{"user":{"student":{"reputation":50}},"task":{"Task 1":{"completed":true,"reputationEarned":45}}}!
    @valid_rep_earned_missing = %!{"user":{"student":{"reputation":50}},"task":{"Task 1":{"completed":true}}}!
    @invalid = "This is not json"
  end

  before(:each) do
    @author = User.create!
    # create the shadow activity structure
    @activity = Activity.create!(:name => "Template", :user => @author)
    section = @activity.sections.create(:name => "Town 1", :user => @author)
    page = section.pages.create(:name => "Task 1", :user => @author)

    open_res = Embeddable::OpenResponse.create(:name => "Score", :prompt => "Score", :user => @author)
    page.add_embeddable(open_res)

    mc = Embeddable::MultipleChoice.create(:name => "Completion", :prompt => "Completion", :user => @author)
    mc.choices.create!(:choice => "Completed")
    page.add_embeddable(mc)
    page.save

    # create the external activity
    @external_activity = ExternalActivity.create!(:name => "External Activity", :template => @activity, :user => @author)
    # create the offering, learner
    offering = Portal::Offering.create!(:runnable => @activity)
    @learner = Portal::Learner.create!(:offering => offering)

    @bucket_logger = Dataservice::BucketLogger.create!(:learner => @learner)
  end

  describe 'in normal conditions' do
    it 'should not cause problems to try to extract valid empty' do
      bc = Dataservice::BucketContent.create!(:body => @valid_empty, :bucket_logger => @bucket_logger)
      GenigamesConnector::Learner.process_bucket_content(bc)

      @learner.multiple_choices.size.should == 0
      @learner.open_responses.size.should == 0
    end

    it 'should create a completed saveable for completed activities' do
      bc = Dataservice::BucketContent.create!(:body => @valid, :bucket_logger => @bucket_logger)
      GenigamesConnector::Learner.process_bucket_content(bc)

      @learner.multiple_choices.size.should == 1
      @learner.multiple_choices.first.answer.should == "Completed"
    end

    it 'should create a score saveable for completed activities' do
      bc = Dataservice::BucketContent.create!(:body => @valid, :bucket_logger => @bucket_logger)
      GenigamesConnector::Learner.process_bucket_content(bc)

      @learner.open_responses.size.should == 1
      @learner.open_responses.first.answer.should == "35"
    end

    it 'should update a score saveable for completed activities' do
      bc = Dataservice::BucketContent.create!(:body => @valid, :bucket_logger => @bucket_logger)
      GenigamesConnector::Learner.process_bucket_content(bc)
      bc = Dataservice::BucketContent.create!(:body => @valid_updated_score, :bucket_logger => @bucket_logger)
      GenigamesConnector::Learner.process_bucket_content(bc)

      @learner.open_responses.size.should == 1
      @learner.open_responses.first.answers.size.should == 2
      @learner.open_responses.first.answer.should == "45"
    end
  end

  describe 'in abnormal conditions' do
    it 'should handle task reputation earned being missing on completed activities' do
      bc = Dataservice::BucketContent.create!(:body => @valid_rep_earned_missing, :bucket_logger => @bucket_logger)
      GenigamesConnector::Learner.process_bucket_content(bc)

      @learner.open_responses.size.should == 0
      @learner.multiple_choices.size.should == 1
    end

    it 'should not cause problems to try to extract invalid data' do
      bc = Dataservice::BucketContent.create!(:body => @invalid, :bucket_logger => @bucket_logger)
      GenigamesConnector::Learner.process_bucket_content(bc)

      @learner.multiple_choices.size.should == 0
      @learner.open_responses.size.should == 0
    end
  end
end
