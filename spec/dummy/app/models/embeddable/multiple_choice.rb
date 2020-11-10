class Embeddable::MultipleChoice < ActiveRecord::Base
  belongs_to :user
  has_many :choices, :class_name => 'Embeddable::MultipleChoiceChoice'
end
