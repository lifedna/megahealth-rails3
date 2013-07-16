class Phr::SymptomWidget < Apotomo::Widget
  responds_to_event :show, :with => :process_show

  helper ApplicationHelper

  def display(*args)
  	options = args.extract_options!
  	@condition = options[:symptom]
    render
  end

  def process_show(evt)
  	phr = Phr.find evt[:phr_id]
  	@symptom = phr.symptoms.find(evt[:id])
  	replace :view => :display
  end

end
