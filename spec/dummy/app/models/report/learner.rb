class Report::Learner < ActiveRecord::Base
  belongs_to   :learner, :class_name => "Portal::Learner", :foreign_key => "learner_id"
  def update_fields
    # no-op placeholder
  end
end

