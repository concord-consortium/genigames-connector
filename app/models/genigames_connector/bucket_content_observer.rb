class GenigamesConnector::BucketContentObserver < ActiveRecord::Observer
  observe ::Dataservice::BucketContent

  def after_save(bucket_content)
    unless bucket_content.body.empty?
      Delayed::Job.enqueue GenigamesConnector::ProcessBucketContentJob.new(Dataservice::BucketContent, bucket_content.id)
    end
  end
end
