class TeamsController < SecuredController

  def create
    @team = Team.new team_params

    if @team.save
      redirect_to team_path(@team), notice: 'This team was created successfully.'
    else
      render 'new'
    end
  end

  def index
    @teams = Team.order :name
  end

  def new
    @team = Team.new
  end

  def reset
    @team = Team.find params[:id]
    @team.reset!

    redirect_to teams_path
  end

  def show
    @team = Team.find params[:id]
  end

  def start
    @team = Team.find params[:id]
    @team.start!

    redirect_to teams_path
  end

  def update
    @team = Team.find params[:id]
    @team.update_attributes team_params

    if @team.save
      redirect_to team_path(@team), notice: 'This team was updated successfully.'
    else
      render 'show'
    end
  end

  private

  def team_params
    params.require(:team).permit(:code, :name, people_attributes: [ :id, :name ])
  end

end

