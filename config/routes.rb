Easyblog::Application.routes.draw do

  authenticated :user do
    root :to => 'home#index'
  end
  root :to => "home#index"
  devise_for :users
  resources :users
  resources :posts do
    member do
      post :mark_archived
    end
    resources :comments
  end

  get "/posts/:post_id/comments/:comment_id/up", to: "comments#up", as: "w_gore"
  get "/posts/:post_id/comments/:comment_id/down", to: "comments#down", as: "do_piekla"
  get "/posts/:post_id/comments/:comment_id/not_abusive", to: "comments#not_abusive", as: "not_abusive"
end
