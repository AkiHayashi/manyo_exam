class TasksController < ApplicationController
  before_action :set_task, only: %i[ show edit update destroy]

  def index
    @tasks = current_user.tasks.sorted
    @tasks = @tasks.sort_expired if params[:sort_expired]
    @tasks = @tasks.sort_priority if params[:sort_priority]
    @tasks = @tasks.title_like(params[:title]) if params[:title].present?
    @tasks = @tasks.progress(params[:progress]) if params[:progress].present?
    @tasks = @tasks.page(params[:page])

    # before refatoring <===
    # @tasks = Task.page(params[:page])
    # if params[:title].present? && params[:progress].present?
    #   @tasks = @tasks.title_like(params[:title]).progress(params[:progress])
    # elsif params[:title].present?
    #   @tasks = @tasks.title_like(params[:title]) if params[:title].present?
    # elsif params[:progress].present?
    #   @tasks = @tasks.progress(params[:progress]) if params[:progress].present?
    # end
    # ==>
  end

  def new
    if params[:back]
      @task = current_user.tasks.build(task_params)
    else 
      @task = Task.new
    end
  end

  def create
    @task = current_user.tasks.build(task_params)
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
    params.require(:task).permit(:title, :description, :expired_at, :progress, :priority)
  end

  def set_task
    @task = Task.find(params[:id])
  end
end
