# coding: utf-8
class Article < Content

  field :sticky, type: Boolean, :default => false

  belongs_to :column
  belongs_to :community
 
end