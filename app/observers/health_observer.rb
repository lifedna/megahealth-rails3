class HealthObserver < Mongoid::Observer
  observe :condition, :symptom, :treatment

  def after_create(record)
    filterInstance = record.phr.user.feature_filter
    case record.class.to_s
    when 'Condition'
        unless filterInstance.conditions.include?(record.name)
          filterInstance.conditions.merge!({record.name => "1"})
          filterInstance.save
        end	
	when 'Symptom'
		unless filterInstance.symptoms.include?(record.name)
        filterInstance.symptoms.merge!({record.name => "1"})
        filterInstance.save
      end	
	when 'Treatment'
		unless filterInstance.treatments.include?(record.name)
        filterInstance.treatments.merge!({record.name => "1"})
        filterInstance.save
      end	
	else
	end    
  end

  def before_destroy(record)
    # filter = record.phr.feature_filter
    # filter.conditions.delete record.name
    # filter.save
  end
end