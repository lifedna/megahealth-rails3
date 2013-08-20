# coding: utf-8
module Mongoid
  module Tagger
    extend ActiveSupport::Concern

    included do |base|
      base.has_many :taggings, :class_name => "Tagging", :inverse_of => :tagger, :dependent => :destroy
    end

    # Tag on a model
    #
    # Example:
    # => @john.tag_on(@article, "science")
    def tag_on(model, text)
      return if (text.length == 0)
      words = text.split(' ')
      taggings = []

      words.each do |word|
        tag = Tag.find_or_create_by(name: word)

        if Tagging.where(tagger: self, taggable: model, tag: tag).first 
          return
        end

        if tagging = self.taggings.create(tag: tag, taggable: model)
          tag.inc(:taggings_count, 1)
        end

        taggings << tagging

        model_tag = model.model_tags.find_or_create_by(name: word)
        model_tag.user_ids << self.id unless model_tag.user_ids.include?(self.id)
        model_tag.inc(:taggings_count, 1)
        model_tag.save   
        model.reload
      end

      taggings

      # return if (text.length == 0)

      # tag = Tag.find_or_create_by(name: text)

      # if Tagging.where(tagger: self, taggable: model, tag: tag).first 
      #   return
      # end

      # if tagging = self.taggings.create(tag: tag, taggable: model)
      #   tag.inc(:taggings_count, 1)
      # end

      # model_tag = model.model_tags.find_or_create_by(name: text)
      # model_tag.user_ids << self.id unless model_tag.user_ids.include?(self.id)
      # model_tag.inc(:taggings_count, 1)
      # model_tag.save   
      # model.reload
      # tagging
    end

    # Delete tag a model
    #
    # Example:
    # => @john.delete_tag(@article, "science")
    def delete_tag(model, text)
      model_tag = model.model_tags.find_by(name: text, user_ids: self.id)
      if model_tag
        model_tag.user_ids.delete(self.id)
        model_tag.inc(:taggings_count, -1)

        model_tag.save
        model.reload
      end
      model.model_tags.destroy_all(taggings_count: 0)

      tag = Tag.find_by(name: text)
      if tag.taggings.destroy_all(tagger: self, taggable: model)
        tag.inc(:taggings_count, -1)
      end

      Tag.destroy_all(taggings_count: 0)
    end

    # return all tag_ids of user
    #
    # Example:
    # => @john.all_tag_ids
    # => ["521300d1f9dffba3e1000001", "521307d2f9dffb13b3000001"] 
    def all_tag_ids
      tag_ids = self.taggings.map(&:tag_id).join(' ').split(' ').uniq
    end

  end
end