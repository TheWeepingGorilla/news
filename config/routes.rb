Rails.application.routes.draw do

  root :to => 'links#index'
  resources :links, :except => [:show]
  resources :comments

end
