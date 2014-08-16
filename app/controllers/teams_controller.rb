class TeamsController < ApplicationController

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

  def show
    @team = Team.find params[:id]
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
    params.require(:team).permit(:code, :name)
  end

end

