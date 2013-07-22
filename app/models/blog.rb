# coding: utf-8
class Blog < Content

  field :public, type: Boolean, :default => true

  search_in :title, :body

end