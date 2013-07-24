# coding: utf-8
class ActivityPresenter < BasePresenter
  include ActionView::Helpers

  presents :activity

  def metadata(*args)
    return '' unless user_signed_in?
    options = args.extract_options!
    options[:date]        ||= true
    # options[:comment]     ||= true
    # options[:like]        ||= true
    # options[:like_count]  ||= false

    if activity.verb == :join
      options[:target]      ||= false
    else
      options[:target]      ||= true
    end  

    out = []
    out << "#{time_ago_in_words(activity.created_at).capitalize}前"                                 if options[:date]        && activity.respond_to?(:created_at)
    # out << link_to('Comment', '#')                                                                  if options[:comment]     && activity.respond_to?(:comments)
    # out << link_to('Like', activity_likes_path(activity),    :method => 'post')                     if options[:like]        && activity.respond_to?(:vote)       && !current_user.voted?(activity)
    # out << link_to('Unlike', activity_likes_path(activity),  :method => 'destroy')                  if options[:like]        && activity.respond_to?(:vote)       && current_user.voted?(activity)
    # out << link_to(content_tag(:i, '', :class => 'icon-heart') + " #{activity.up_votes_count}", '#') if options[:like_count]  && activity.respond_to?(:vote)       && activity.up_votes_count > 0
    out << link_to(activity.the_target.name, activity.the_target)                        if options[:target]  && activity.respond_to?(:the_target)

    return raw out.join(" &middot; ")
  end

  def text
  	case activity.verb
  	when :new_article
  	  out = %(#{raw link_to(activity.the_actor.name, activity.the_actor)} 写了新文章 #{raw link_to(activity.the_object.title, show_community_article_path(activity.the_object.community, activity.the_object))})
  	when :new_question
  	  out = %(#{raw link_to(activity.the_actor.name, activity.the_actor)} 发起了新问题 #{raw link_to(activity.the_object.title, show_community_question_path(activity.the_object.community, activity.the_object))})
  	when :new_topic
      out = %(#{raw link_to(activity.the_actor.name, activity.the_actor)} 写了新帖子 #{raw link_to(activity.the_object.title, show_community_topic_path(activity.the_object.community, activity.the_object))})  
    when :new_poll
      out = %(#{raw link_to(activity.the_actor.name, activity.the_actor)} 发起了新投票 #{raw link_to(activity.the_object.name, show_community_poll_path(activity.the_object.community, activity.the_object))})
    when :new_comment
      out = %(#{raw link_to(activity.the_actor.name, activity.the_actor)} 评论了帖子 #{raw link_to(activity.the_object.commentable.title, show_community_topic_path(activity.the_object.commentable.community, activity.the_object.commentable))})
    when :join
      out = %(#{raw link_to(activity.the_actor.name, activity.the_actor)} 加入了社群 #{raw link_to(activity.the_object.name, activity.the_object)})   
    else
      out = ""
  	end	
  	return raw out
  end	

  def content?
    case activity.verb
    when :new_article
      return true
    when :new_question
      return true
    when :new_topic
      return true
    when :new_comment
      return true
    else
      return false
    end  
  end  

  def icon
    case activity.verb
    when :new_article
      out = "<span class='icon icon-file color-grey no-margin' style='font-size: 24px;'></span>"
    when :new_question
      out = "<span class='icon icon-question-sign color-grey no-margin' style='font-size: 24px;'></span>" 
    when :new_topic
      out = "<span class='icon icon-comment-alt color-grey no-margin' style='font-size: 24px;'></span>" 
    when :new_comment
      out = "<span class='icon icon-comments color-grey no-margin' style='font-size: 24px;'></span>" 
    when :join
      out = "<span class='icon icon-user color-grey no-margin' style='font-size: 24px;'></span>" 
    else
      out = ""
    end 

    return raw out
  end
end  