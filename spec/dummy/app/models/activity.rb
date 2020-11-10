class Activity < ActiveRecord::Base
  belongs_to :user
  belongs_to :investigation
  has_many :sections
  has_many :pages, :through => :sections
  has_many :external_activities, :as => :template
end
