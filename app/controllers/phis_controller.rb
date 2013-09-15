class PhisController < ApplicationController
  before_filter :authenticate_user!

  def initial
    if params[:issues]
      filter = current_user.content_filter
      filter.phis = params[:issues]
      filter.save

      strs = params[:issues].split(',')
      strs.each do |s|
        issue = Issue.find_or_create_by(name: s.to_s.gsub(/\s+/, ""))
        phi = Phi.find_or_create_by(name: s.to_s.gsub(/\s+/, ""), issue_id: issue.id, user_id: current_user.id)
      end
    end

    redirect_to explore_path
  end
end
