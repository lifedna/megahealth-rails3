source 'https://rubygems.org'
ruby '1.9.3'
gem 'rails', '3.2.13'
group :assets do
  gem 'sass-rails',   '~> 3.2.3'
  gem 'coffee-rails', '~> 3.2.1'
  gem 'uglifier', '>= 1.0.3'
end

gem 'thin', :group => :production
gem 'jquery-rails'
gem 'jquery-ui-rails'
gem 'devise'
gem 'figaro'
gem 'haml-rails'
gem 'mongoid', '~> 3.1.4'
gem 'bson_ext'
gem 'simple_form'
gem 'nested_form'

# The single-file MongoDB admin app
gem 'genghisapp'

# mongoid activity stream
gem 'streama'

# Like, comment, share mongoid documents
gem 'mongoid_socializer_actions'

# mongoid tagging
gem 'mongoid_taggable_with_context'

# mongoid simple full-text search
gem 'mongoid_search'

# AJAX widget framework
gem 'apotomo', '~> 1.2.3'

# authorization
gem 'cancan'

# embeded video thumbnails and videos
gem 'nokogiri'
gem 'getvideo', :git => 'git://github.com/regdog/getvideo.git'

# file upload with carrierwave and GridFS
gem 'mini_magick'
gem 'carrierwave'
gem 'carrierwave-mongoid', :require => "carrierwave/mongoid"

# pagination
gem 'kaminari'

# HTML editor
gem 'redactor-rails'

# Auto incrementing fields for mongoid documents
# gem 'mongoid-autoinc'

# social share feature
gem 'social-share-button'

# tracks impressions and page views
gem 'impressionist'

# translate chinese hanzi to pinyin
gem 'chinese_pinyin'

# state machine
gem 'state_machine'

# tools
gem "tracer_bullets", :group => "development"

group :development do
  gem 'better_errors'
  gem 'binding_of_caller', :platforms=>[:mri_19, :rbx]
  gem 'html2haml'
  gem 'quiet_assets'
end
group :development, :test do
  gem 'factory_girl_rails'
  gem 'rspec-rails'
end
group :test do
  gem 'capybara'
  gem 'cucumber-rails', :require=>false
  gem 'database_cleaner'
  gem 'email_spec'
  gem 'launchy'
  gem 'mongoid-rspec'
end
