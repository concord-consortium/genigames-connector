class Investigation < ActiveRecord::Base
  belongs_to :user
  has_many :activities
  has_many :external_activities, :as => :template
end
