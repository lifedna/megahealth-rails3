# coding: utf-8
class ConditionPresenter < BasePresenter
  presents :condition

  def text
  	number = Phr.where('conditions.name' => condition.name).count-1
  	return raw "#{number}人与你有相同疾病"
  end
end	