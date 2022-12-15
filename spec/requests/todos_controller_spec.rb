require "rails_helper"

RSpec.describe TodosController do
  describe "GET #index" do
    it "renders the current user's todos" do
      user = create(:user)
      todos = create_list(:todo, 3, user: user)
      other_users_todos = create_list(:todo, 3)

      login_user(user)
      get todos_path

      expect(response).to render_template(:index)
      todos.each do |todo|
        expect(response.body).to include(todo.content)
      end
      other_users_todos.each do |todo|
        expect(response.body).not_to include(todo.content)
      end
    end

    it "redirects to login if unauthenticated" do
      get todos_path

      expect(response).to redirect_to(login_path)
    end
  end

  describe "POST #create" do
    it "creates todo and assigns it to user" do
      user = create(:user)
      todo_params = attributes_for(:todo)

      login_user(user)
      post todos_path, params: { todo: todo_params }

      expect(response).to redirect_to(todos_path)
      expect(user.todos.last.content).to eq(todo_params[:content])
    end

    it "redirects to login if unauthenticated" do
      todo_params = attributes_for(:todo)

      post todos_path, params: { todo: todo_params }

      expect(response).to redirect_to(login_path)
    end
  end

  describe "DELETE #destroy" do
    it "deletes todo" do
      user = create(:user)
      todo = create(:todo, user: user)

      login_user(user)
      delete todo_path(todo)

      expect(response).to redirect_to(todos_path)
      expect(user.todos.count).to eq(0)
    end

    it "redirects to login if unauthenticated" do
      todo_params = attributes_for(:todo)

      post todos_path, params: { todo: todo_params }

      expect(response).to redirect_to(login_path)
    end
  end
end
