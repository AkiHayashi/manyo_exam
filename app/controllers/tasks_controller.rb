class TasksController < ApplicationController
  before_action :set_task, only: %i[ show edit update destroy]
  before_action :get_labels, only: %i[ new show edit update]

  def index
    @tasks = current_user.tasks.sorted
    @tasks = @tasks.sort_expired if params[:sort_expired]
    @tasks = @tasks.sort_priority if params[:sort_priority]
    @tasks = @tasks.joins(:labels).where(labels: { id: params[:label_ids] }) if params[:label_ids].present?
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
    @tasks = current_user.tasks
  end

  def edit
  end

  def update
    unless params[:task][:label_ids]
      @task.labellings.delete_all
    end
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
    params.require(:task).permit(:title, :description, :expired_at, :progress, :priority, { label_ids: [] })
  end

  def set_task
    @task = Task.find(params[:id])
  end
  def get_labels
    @labels = Label.all
  end
end
