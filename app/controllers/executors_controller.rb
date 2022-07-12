class ExecutorsController < ApplicationController
  def index
    @executors = Executor.all
  end

  def show
    @executor = Executor.find(params[:id])
  end

  def new
    @executor = Executor.new
  end

  def edit
    @executor = Executor.find(params[:id])
  end

  def update
    @executor = Executor.find(params[:id])

    if @executor.update(executor_params)
      redirect_to @executor
    else
      render :edit
    end
  end

  def create
    @executor = Executor.new(executor_params)

    if @executor.save
      redirect_to executor_path(@executor)
    else
      render :new
    end
  end

  def destroy
    @executor = Executor.find(params[:id])

    if @executor.destroy
      redirect_to executors_path
    end
  end

  private

  def executor_params
    params.require(:executor).permit(:name, :service_id)
  end
end
