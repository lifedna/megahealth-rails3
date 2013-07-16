# coding: utf-8
class SymptomPresenter < BasePresenter
  presents :symptom

  def text
  	number = Phr.where('symptoms.name' => symptom.name).count-1
  	return raw "#{number}人与你有相同病症"
  end
end	