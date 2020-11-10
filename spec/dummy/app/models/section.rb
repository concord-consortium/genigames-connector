class Section < ActiveRecord::Base
  belongs_to :user
  belongs_to :activity
  has_many :pages
end
