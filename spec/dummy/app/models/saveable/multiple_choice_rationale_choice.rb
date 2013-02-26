class Saveable::MultipleChoiceRationaleChoice < ActiveRecord::Base
  attr_accessible :choice, :answer

  belongs_to :answer, :class_name => "Saveable::MultipleChoiceAnswer"
  belongs_to :choice, :class_name => "Embeddable::MultipleChoiceChoice"

end
