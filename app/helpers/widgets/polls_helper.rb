module Widgets::PollsHelper
	def line_width(total, answers_count)
		return '3px;' if answers_count == 0
		return "#{100*(answers_count.round(1)/total.round(1))}%;"
	end

	def line_percent(total, answers_count)
		return '0.0%' if total == 0
		percent = 100*(answers_count.round(1)/total.round(1))
		return "#{percent.round(1)}%"
	end
end