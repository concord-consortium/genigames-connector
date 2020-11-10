class PageElement < ActiveRecord::Base
  belongs_to :user
  belongs_to :page
  belongs_to :embeddable, :polymorphic => true
end
