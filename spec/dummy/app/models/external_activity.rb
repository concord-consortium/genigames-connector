class ExternalActivity < ActiveRecord::Base
  belongs_to :user
  belongs_to :template, :polymorphic => true
end
