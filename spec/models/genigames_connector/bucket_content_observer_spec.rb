require 'spec_helper'

describe GenigamesConnector::BucketContentObserver do
  it 'should trigger the observer when bucket contents are created' do
    GenigamesConnector::BucketContentObserver.any_instance.should_receive(:after_save).once

    Dataservice::BucketContent.create!(:body => "foo")
  end

  it 'should trigger the observer when bucket contents are saved' do
    GenigamesConnector::BucketContentObserver.any_instance.should_receive(:after_save).twice

    bc = Dataservice::BucketContent.create!(:body => "foo")
    bc.body = "bar"
    bc.save!
  end

  it 'should create a background job when bucket contents get saved' do
    Delayed::Job.should_receive(:enqueue).once
    Dataservice::BucketContent.create!(:body => "baz", :bucket_logger_id => 1)
  end

  it 'should process the bucket content' do
    Delayed::Job.process = true
    GenigamesConnector::Learner.should_receive(:process_bucket_content).once
    bc = Dataservice::BucketContent.create!(:body => "baz", :bucket_logger_id => 1)
  end
end
