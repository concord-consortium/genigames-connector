class Saveable::MultipleChoiceAnswer < ActiveRecord::Base

  belongs_to :multiple_choice, :class_name => 'Saveable::MultipleChoice', :counter_cache => :response_count

  has_many :rationale_choices, :order => :choice_id, :class_name => 'Saveable::MultipleChoiceRationaleChoice', :foreign_key => :answer_id, :dependent => :destroy

  def answer
    if rationale_choices.size > 0
      rationale_choices.compact.select{|rc| rc.choice }.map{|rc| data = {:answer => rc.choice.choice, :correct => rc.choice.is_correct}; data[:rationale] = rc.rationale if rc.rationale; data }
    else
      [{:answer => "not answered"}]
    end
  end

  def answered_correctly?
    if rationale_choices.size > 0
      choices = rationale_choices.compact.select{|rc| rc.choice }.map{|rc| rc.choice.is_correct }
      !(choices.size == 0 || choices.include?(false))
    else
      false
    end
  end
end
