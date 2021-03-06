class Portal::Learner < ActiveRecord::Base
  attr_accessible :offering, :student

  belongs_to :offering
  belongs_to :student, :class_name => "Portal::Student"

  has_many :open_responses, :class_name => "Saveable::OpenResponse"
  has_many :multiple_choices, :class_name => "Saveable::MultipleChoice"

  has_one :report_learner, :class_name => "Report::Learner", :foreign_key => "learner_id"
end
