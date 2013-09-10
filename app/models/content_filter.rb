# coding: utf-8
class ContentFilter
  include Mongoid::Document

  field :content, type: Hash, default: {"文章" => "1", "话题" => "1", "问题" => "1", "视频" => "1", "投票" => "1"}
  field :scope, type: String, default: "newest"
  field :phis, type: String

  belongs_to :user	

  def merged_klass
    klass ||= []
  	classes = content.select {|k,v| v == "1"}
  	classes.keys.each do |key|
      case key
        when '文章'
          klass << 'Article'  
        when '投票'  
          klass << 'Poll'
        when '视频'  
          klass << 'Video'
        when '话题'  
          klass << 'Topic'
        when '问题'  
          klass << 'Question'    
        else   
      end
    end
    return klass  
  end

  def merged_keywords
  	keywords ||= []
  	# phrsArray = phrs.select {|k,v| v == "1"}
  	# phrsArray.each do |k, v|
  	#   phr = self.user.phrs.find_by(name: k)
  	#   keywords.concat(phr.merged_keywords)	
  	# end		

    unless phis.split(',').empty?
      keywords.concat(phis.split(','))
    end

  	return keywords.uniq
  end
end