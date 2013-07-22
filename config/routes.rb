require 'genghis'

MegahealthRails3::Application.routes.draw do
  match '/update' => 'home#update', :as => :update
  match '/features' => 'home#features', :as => :features
  match '/mine' => 'home#mine', :as => :mine

   scope 'communities' do
    match '/:community_id/columns/:id' => 'widgets/columns#show', :as => :show_community_column, :via => :get
    match '/:community_id/articles/:id' => 'widgets/articles#show', :as => :show_community_article, :via => :get
    match '/:community_id/articles/:id/comment' => 'widgets/articles#comment', :as => :comment_community_article, :via => :get  

    match '/:community_id/forum/:id' => 'widgets/forums#show', :as => :show_community_forum, :via => :get
    match '/:community_id/topics/:id' => 'widgets/topics#show', :as => :show_community_topic, :via => :get
    match '/:community_id/topics/:id/comment' => 'widgets/topics#comment', :as => :comment_community_topic, :via => :get

    match '/:community_id/qas/:id' => 'widgets/qas#show', :as => :show_community_qa, :via => :get
    match '/:community_id/questions/:id' => 'widgets/questions#show', :as => :show_community_question, :via => :get
    match '/:community_id/questions/:id/answer' => 'widgets/questions#answer', :as => :answer_community_question, :via => :get

    match '/:community_id/poll_sets/:id' => 'widgets/poll_sets#show', :as => :show_community_poll_set, :via => :get
    match '/:community_id/polls/:id' => 'widgets/polls#show', :as => :show_community_poll, :via => :get
    match '/:community_id/polls/:id/comment' => 'widgets/polls#comment', :as => :comment_community_poll, :via => :get
  end    

  resources :blogs do 
    get 'comment', :on => :member
  end  

  resource :feature_filter

  resources :communities do
    resources :sections

    scope :module => "widgets" do
      resources :bulletins, only: [:edit, :update]
      resources :forums, :only => :update do
        resources :topics, except: :show
      end  
      resources :poll_sets, :only => :update do
        resources :polls, except: :show
      end 
      resources :qas, :only => :update do
        resources :questions, except: :show 
      end  
      resources :columns, :only => :update do
        resources :articles, except: :show
      end

      resources :video_lists, :only => :update do
        resources :videos, except: :show
      end
    end

    get 'admin', :on => :member
    get 'join', :on => :member
    get 'leave', :on => :member
  end

  resources :phrs do
    scope :module => "phrs" do
      resources :conditions
      resources :symptoms
      resources :treatments
    end
  end

  authenticated :user do
    root :to => 'home#update'
  end
  root :to => "home#index"
  devise_for :users do
    get "/users/sign_out" => "devise/sessions#destroy", :as => :destroy_user_session
  end
  resources :users

  mount Genghis::Server.new, :at => '/genghis'
end