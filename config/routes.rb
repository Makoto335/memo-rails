Rails.application.routes.draw do
  constraints format: :json do
    namespace :api do
      namespace :v1 do
        mount_devise_token_auth_for 'User',
                                    at: 'auth',
                                    controllers: {
                                      registrations: 'api/v1/auth/registrations',
                                    }
        resource :user, only: %i[show update]

        resources :memos, only: %i[index show create update destroy]
      end
    end
  end
end
