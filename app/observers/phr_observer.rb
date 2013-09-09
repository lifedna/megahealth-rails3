class PhrObserver < Mongoid::Observer
  # def after_create(record)
  # 	filterInstance = record.user.content_filter
  # 	filterInstance.phrs.merge!({record.name => "0"})
  # 	filterInstance.save
  # end
end	