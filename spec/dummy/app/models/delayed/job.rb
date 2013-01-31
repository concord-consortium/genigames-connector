class Delayed::Job
  class << self
    attr_accessor :process

    def enqueue(job)
      # don't really enqueue this.
      # process it if the test sets it up that way.
      if process
        job.perform
      end
    end
  end
end
