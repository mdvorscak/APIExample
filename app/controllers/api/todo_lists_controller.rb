class Api::TodoListsController < Api::ApiController
  before_action :find_todo_list, only: [:update, :destroy, :show]

  def index
    render json: TodoList.all
  end

  def show
    render json: @list.as_json(include:[:todo_items])
  end

  def create
    list = TodoList.new(list_params)
    if list.save
      render status: 200, json: {
                 message: "Successfully created To-do list",
                 todo_list: list
             }.to_json
    else
      render status: 422, json: {
                 errors: list.errors
             }.to_json
    end
  end

  def update
    if @list.update(item_params)
      render  status: 200, json: {
                             message: "Successfully updated To-do list",
                             todo_list: @list
                         }.to_json
    else
      render status: 422, json: {
                            message: "To-do Item update failed.",
                            errors: @list.errors
                        }.to_json
    end
  end

  def destroy
    @list.destroy
    render status: 200, json: {
               message: "Successfully deleted To-do list",
           }.to_json
  end

  private
  def list_params
    params.require("todo_list").permit("title")
  end

  def find_todo_list
    @list = find_record_or_render_error(TodoList, params[:id])
  end
end