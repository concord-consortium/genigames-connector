class Report::Learner < ActiveRecord::Base
  attr_accessible :learner, :learner_id
  belongs_to   :learner, :class_name => "Portal::Learner", :foreign_key => "learner_id"
  def update_fields
    # no-op placeholder
  end
end

