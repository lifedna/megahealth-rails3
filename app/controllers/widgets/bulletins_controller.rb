class Widgets::BulletinsController < WidgetsController
  def edit
    @widget = Widget.find params[:id]
  end
end