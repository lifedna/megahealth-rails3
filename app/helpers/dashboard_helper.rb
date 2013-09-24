# coding: utf-8
module DashboardHelper
  def title(string)
  	case string
  	when "mine"
  	  return "我的分享"
  	when "commented"
  	  return "我回应的分享"	
  	when "bookmarked"
  	  return "我收藏的分享"	
  	else
  	  return "我的分享"	
  	end
  end	
end