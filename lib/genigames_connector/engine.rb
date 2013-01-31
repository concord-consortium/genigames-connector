module GenigamesConnector
  class Engine < ::Rails::Engine
    isolate_namespace GenigamesConnector
    config.active_record.observers = [:"genigames_connector/bucket_content_observer"]
    config.generators do |g|
      g.test_framework :rspec, :view_specs => false
    end
  end
end
