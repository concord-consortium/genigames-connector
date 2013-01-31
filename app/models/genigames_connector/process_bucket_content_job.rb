class GenigamesConnector::ProcessBucketContentJob < Struct.new(:bucket_content_class, :bucket_content_id)
  def perform
    bucket_content = bucket_content_class.find(bucket_content_id)
    GenigamesConnector::Learner.process_bucket_content(bucket_content)
  end
end
