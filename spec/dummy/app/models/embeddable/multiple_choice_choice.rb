class Embeddable::MultipleChoiceChoice < ActiveRecord::Base
  belongs_to :multiple_choice, :class_name => 'Embeddable::MultipleChoice'
end
