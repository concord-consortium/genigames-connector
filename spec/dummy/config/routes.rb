Rails.application.routes.draw do

  mount GenigamesConnector::Engine => "/genigames_connector"

  match '/home' => 'home#index', :as => :home
  root :to => 'home#index'
end
