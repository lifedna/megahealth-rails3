require 'genghis'

MegahealthRails3::Application.routes.draw do
  # different uploaded versions for avatar
  match '/uploads/grid/community/logo/:id/:filename' => 'gridfs#thumb_logo', constraints: { filename: /thumb.*/ }
  # route configuration for the uploaded image
  match '/uploads/grid/community/logo/:id/:filename' => 'gridfs#logo'

  # different uploaded versions for avatar
  match '/uploads/grid/user/avatar/:id/:filename' => 'gridfs#thumb_avatar', constraints: { filename: /thumb.*/ }
  # route configuration for the uploaded image
  match '/uploads/grid/user/avatar/:id/:filename' => 'gridfs#avatar'

  # different uploaded versions for uploaded pictures
  match '/uploads/grid/redactor_rails/picture/data/:id/:filename' => 'gridfs#thumb_redactor_pitcure', constraints: { filename: /thumb.*/ }
  # route configuration for the uploaded image
  match '/uploads/grid/redactor_rails/picture/data/:id/:filename' => 'gridfs#redactor_pitcure'

  # path for embeded video thumbnail
  match '/uploads/grid/video/thumb/:id/:filename' => 'gridfs#thumb_video'

  mount RedactorRails::Engine => '/redactor_rails'

  match '/experiences' => 'home#experiences', :as => :experiences
  match '/explore' => 'home#explore', :as => :explore
  match '/dashboard' => 'home#dashboard', :as => :dashboard
  match '/profile' => 'home#profile', :as => :profile
  match '/account' => 'home#account', :as => :account
  match '/search' => 'home#search', :as => :search
  match '/guide' => 'home#guide', :as => :guide
  match '/fat' => 'home#fat'

  match '/dashboard/stars' => 'dashboard#stars', :as => :stars
  match '/dashboard/issues' => 'dashboard#issues', :as => :issues


  scope 'communities' do
    match '/:community_id/columns/:id' => 'widgets/columns#show', :as => :show_community_column, :via => :get
    match '/:community_id/articles/:id' => 'widgets/articles#show', :as => :show_community_article, :via => :get
    match '/:community_id/articles/:id/comment' => 'widgets/articles#comment', :as => :comment_community_article, :via => :get  
    match '/:community_id/articles/:id/remove_comment/:comment_id' => 'widgets/articles#remove_comment', :as => :remove_comment_community_article, :via => :get 

    match '/:community_id/forum/:id' => 'widgets/forums#show', :as => :show_community_forum, :via => :get
    match '/:community_id/topics/:id' => 'widgets/topics#show', :as => :show_community_topic, :via => :get
    match '/:community_id/topics/:id/comment' => 'widgets/topics#comment', :as => :comment_community_topic, :via => :get
    match '/:community_id/topics/:id/remove_comment/:comment_id' => 'widgets/topics#remove_comment', :as => :remove_comment_community_topic, :via => :get

    match '/:community_id/qas/:id' => 'widgets/qas#show', :as => :show_community_qa, :via => :get
    match '/:community_id/questions/:id' => 'widgets/questions#show', :as => :show_community_question, :via => :get
    match '/:community_id/questions/:id/answer' => 'widgets/questions#answer', :as => :answer_community_question, :via => :get

    match '/:community_id/poll_sets/:id' => 'widgets/poll_sets#show', :as => :show_community_poll_set, :via => :get
    match '/:community_id/polls/:id' => 'widgets/polls#show', :as => :show_community_poll, :via => :get
    match '/:community_id/polls/:id/answer' => 'widgets/polls#answer', :as => :answer_community_poll, :via => :get
    match '/:community_id/polls/:id/details' => 'widgets/polls#details', :as => :details_community_poll, :via => :get
    match '/:community_id/polls/:id/comment' => 'widgets/polls#comment', :as => :comment_community_poll, :via => :get
    match '/:community_id/polls/:id/remove_comment/:comment_id' => 'widgets/polls#remove_comment', :as => :remove_comment_community_poll, :via => :get

    match '/:community_id/video_lists/:id' => 'widgets/video_lists#show', :as => :show_community_video_list, :via => :get
    match '/:community_id/videos/:id' => 'widgets/videos#show', :as => :show_community_video, :via => :get
    match '/:community_id/videos/:id/comment' => 'widgets/videos#comment', :as => :comment_community_video, :via => :get
  end    

  scope "dashboard" do
    resources :blogs, except: :show do 
      get 'comment', :on => :member
      get 'remove_comment', :on => :member
    end 
  end   

  match '/blogs/:id' => 'blogs#show', :as => :blog, :via => :get

  # resource :feature_filter
  resource :content_filter

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

  scope "dashboard" do
    resources :phrs do    
      scope :module => "phrs" do
        resources :conditions
        resources :symptoms
        # resources :treatments
      end
    end
  end


  authenticated :user do
    root :to => 'home#explore'
  end
  root :to => "home#index"
  devise_for :users, :controllers => { :registrations => "registrations" } do
    get "/users/sign_out" => "devise/sessions#destroy", :as => :destroy_user_session
  end
  resources :users do
    post 'update_password', :on => :member, :as => :upadte_password
  end

  mount Genghis::Server.new, :at => '/genghis'
end