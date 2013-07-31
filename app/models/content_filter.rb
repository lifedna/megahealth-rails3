# coding: utf-8
class ContentFilter
  include Mongoid::Document

  field :content, type: Hash, default: {"文章" => "1", "日记" => "1", "视频" => "0", "话题" => "0", "问答" => "0"}
  field :phrs, type: Hash

  belongs_to :user	

  def merged_klass
    klass ||= []
  	classes = content.select {|k,v| v == "1"}
  	classes.keys.each do |key|
      case key
        when '文章'
          klass << 'Article'
        when '日记'  
          klass << 'Blog'
        when '视频'  
          klass << 'Video'
        when '话题'  
          klass << 'Topic'
        when '问答'  
          klass << 'Question'    
        else   
      end
    end
    return klass  
  end

  def merged_keywords
  	keywords ||= []
  	phrsArray = phrs.select {|k,v| v == "1"}
  	phrsArray.each do |k, v|
  	  phr = self.user.phrs.find_by(name: k)
  	  keywords.concat(phr.merged_keywords)	
  	end		
  	return keywords.uniq
  end
end