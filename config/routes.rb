Rails.application.routes.draw do
  get :example, to: 'main#example'
  post :view, to: 'main#view'
  root 'main#index'
end
