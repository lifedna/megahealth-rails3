module ApplicationHelper
  # Method used to "present" an object with its associated presenter.
  def present(object, klass = nil)
    klass ||= "#{object.class}Presenter".constantize
    presenter = klass.new(object, self)
    yield presenter if block_given?
    presenter
  end	

  def first_image_url(html_string)
  	image = Nokogiri::HTML.parse(html_string).css("img").first
  	image['src'] unless image.nil?
  end
end
