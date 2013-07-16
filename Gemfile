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
gem 'mongoid'
gem 'streama'
gem 'mongoid_socializer_actions'
gem 'mongoid_taggable_with_context'
gem 'apotomo', '~> 1.2.3'
gem 'simple_form'
gem 'nested_form'
gem 'cancan'
gem 'mongoid_search'
# gem 'streamio-ffmpeg'
gem 'nokogiri'
gem 'getvideo', :git => 'git://github.com/yeeli/getvideo.git'
# gem 'impressionist', '~> 1.4.4'


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
