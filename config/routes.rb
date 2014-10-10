Rails.application.routes.draw do
  root 'main#login'
  get 'contacts', to: 'main#index' 
  match 'contacts', to: 'main#create', via: :post
  match 'contacts/:id', to: 'main#update', via: :put
  match 'messages', to: 'main#message', via: :post
  match 'home', to: 'main#home', via: :post, as: :home
end
