Rails.application.routes.draw do
  root "application#index"
  namespace 'api' do
    namespace 'v1' do
      resources :organizacion
      resources :user
      resources :firebase
    end
  end
end
