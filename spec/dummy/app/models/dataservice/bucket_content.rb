class Dataservice::BucketContent < ActiveRecord::Base
  attr_accessible :body, :bucket_logger_id, :bucket_logger, :empty, :processed

  belongs_to :bucket_logger, :class_name => "Dataservice::BucketLogger", :foreign_key => "bucket_logger_id"
end
