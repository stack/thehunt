class CheckpointsController < SecuredController

  def create
    @checkpoint = Checkpoint.new checkpoint_params

    if @checkpoint.save
      redirect_to checkpoints_path, notice: 'The checkpoint was created successfully.'
    else
      render 'new'
    end
  end

  def index
    @checkpoints = Checkpoint.order(:order)
  end

  def new
    @checkpoint = Checkpoint.new
  end

  def show
    @checkpoint = Checkpoint.find params[:id]
  end

  def sort
    order = 1
    params[:order].each do |id|
      checkpoint = Checkpoint.find id
      checkpoint.update_attribute :order, order
      order += 1
    end

    respond_to do |format|
      format.json { head :ok }
    end
  end

  def update
    @checkpoint = Checkpoint.find params[:id]
    @checkpoint.update_attributes checkpoint_params

    if @checkpoint.save
      redirect_to checkpoints_path, notice: 'The checkpoint was updated successfully.'
    else
      render 'show'
    end
  end

  private

  def checkpoint_params
    params.require(:checkpoint).permit(:message, :success, :response, :points)
  end

end

