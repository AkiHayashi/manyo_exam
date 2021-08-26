class TasksController < ApplicationController
  before_action :set_task, only: %i[ show edit update destroy]

  def index
    @tasks = Task.all
  end

  def new
    if params[:back]
      @task = Task.new(task_params)
    else 
      @task = Task.new
    end
  end

  def create
    @task = Task.new(task_params)
    if @task.save
      redirect_to tasks_path, notice: "タスク作成完了"
    else 
      render :new
    end
  end

  def show
  end

  def edit
  end

  def update
    if @task.update(task_params)
      redirect_to tasks_path, notice: "タスク更新完了"
    else 
      render :edit
    end
  end

  def destroy
    @task.destroy
    redirect_to tasks_path, notice: "タスク削除"
  end

  private
  def task_params
    params.require(:task).permit(:title, :description)
  end

  def set_task
    @task = Task.find(params[:id])
  end
end
