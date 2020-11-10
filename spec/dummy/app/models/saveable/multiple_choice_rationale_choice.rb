class Saveable::MultipleChoiceRationaleChoice < ActiveRecord::Base

  belongs_to :answer, :class_name => "Saveable::MultipleChoiceAnswer"
  belongs_to :choice, :class_name => "Embeddable::MultipleChoiceChoice"

end
