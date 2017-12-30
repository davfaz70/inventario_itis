class DashboardController < ApplicationController
  before_action :authenticate_admin!
  def index
    q_param = params[:q]
    page = params[:page]
    per_page = params[:per_page]
    @q = Tool.search(q_param)
    @tools = @q.result(distinct: true).page(page).per(per_page)
  end

end
