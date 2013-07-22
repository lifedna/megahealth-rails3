# encoding: utf-8
module Mongoid
  module Search
    module Util  
      
      def self.normalize_keywords(text)
        include ActionView::Helpers::SanitizeHelper

        ligatures     = Mongoid::Search.ligatures
        ignore_list   = Mongoid::Search.ignore_list
        stem_keywords = Mongoid::Search.stem_keywords
        stem_proc     = Mongoid::Search.stem_proc

        return [] if text.blank?
        text =  ActionView::Base.new.strip_tags(text).to_s.
          mb_chars.
          normalize(:kd).
          downcase.
          to_s.
          gsub(/[._:;'"`,?|+={}()!@#%^&*<>~\$\-\\\/\[\]]/, ' '). # strip punctuation
          gsub(/[^\s\p{Alnum}]/,'').   # strip accents
          gsub(/[#{ligatures.keys.join("")}]/) {|c| ligatures[c]}.
          split(' ').
          reject { |word| word.size < Mongoid::Search.minimum_word_size }
        text = text.reject { |word| ignore_list.include?(word) } unless ignore_list.blank?
        text = text.map(&stem_proc) if stem_keywords
        text
      end

    end
  end 
end   