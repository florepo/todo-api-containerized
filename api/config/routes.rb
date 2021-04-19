Rails.application.routes.draw do

  namespace :api do
    namespace :v1 do
      resources :profiles,  only: [:show]
    end
  end

  

end
