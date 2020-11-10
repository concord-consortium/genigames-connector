class Portal::Offering < ActiveRecord::Base
  belongs_to :runnable, :polymorphic => true
end
