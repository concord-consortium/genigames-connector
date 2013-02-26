class CreateSaveableMultipleChoiceRationaleChoices < ActiveRecord::Migration
  def change
    create_table :saveable_multiple_choice_rationale_choices do |t|
      t.integer :answer_id
      t.integer :choice_id
      t.text    :rationale
      t.timestamps
    end
  end
end
