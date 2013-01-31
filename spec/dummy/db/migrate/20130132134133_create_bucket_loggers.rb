class CreateBucketLoggers < ActiveRecord::Migration
  def change
    create_table :dataservice_bucket_loggers do |t|
      t.integer  :learner_id

      t.timestamps
    end
  end
end
