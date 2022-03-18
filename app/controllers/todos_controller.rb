class TodosController < ApplicationController
  def index
    @todos = current_user.todos
  end

  def create
    current_user.todos.create(todo_params)

    redirect_to todos_path
  end

  def destroy
    current_user.todos.delete(params[:id])

    redirect_to todos_path
  end

  private

  def todo_params
    params.require(:todo).permit(:content)
  end
end
