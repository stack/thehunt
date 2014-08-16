class DashboardController < SecuredController

  def index
    @teams = Team.order :name
  end

end

