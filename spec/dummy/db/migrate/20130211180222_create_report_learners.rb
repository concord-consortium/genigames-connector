class CreateReportLearners < ActiveRecord::Migration
  def change
    create_table :report_learners do |t|
      t.integer :learner_id
      t.timestamps
    end
  end
end
