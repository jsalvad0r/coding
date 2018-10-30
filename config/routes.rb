Rails.application.routes.draw do
  devise_scope :user do
  	unauthenticated :user do
      root to: 'sessions#new'
  	end
    authenticated :user do
      root to: 'dashboard#index'
    end
  end

  devise_for :users, controllers: { sessions: 'sessions', omniauth_callbacks: "users/omniauth_callbacks" }
end
