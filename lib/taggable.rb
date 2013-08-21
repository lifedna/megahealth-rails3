module Mongoid
  module Taggable
    extend ActiveSupport::Concern

    included do |base|
      base.has_many :taggings, :class_name => 'Tagging', :as => :taggable, :dependent => :destroy
    end

  end
end