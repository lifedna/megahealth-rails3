class Condition
  include Mongoid::Document	

  field :name, type: String
  field :status, type: String
  field :started_at, type: Time
  field :ended_at, type: Time  

  embedded_in :phr

  def relevant_items
  	items ||= []

  	blogs = Blog.all.full_text_search(self.name)
    articles = Article.all.full_text_search(self.name)
    topics = Topic.all.full_text_search(self.name)

    items.concat(blogs)
    items.concat(articles)
    items.concat(topics)
  end
end