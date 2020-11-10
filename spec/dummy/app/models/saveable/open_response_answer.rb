class Saveable::OpenResponseAnswer < ActiveRecord::Base
  belongs_to :open_response, :class_name => 'Saveable::OpenResponse', :counter_cache => :response_count
end
