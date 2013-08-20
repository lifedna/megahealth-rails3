module Mongoid
  module Taggable
    extend ActiveSupport::Concern

    included do |base|
      base.has_many :model_tags, :class_name => 'ModelTag', :as => :taggable, :dependent => :destroy
    end

  end
end