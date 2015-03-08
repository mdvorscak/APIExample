class Api::TodoItemsController < Api::ApiController
  before_action :find_todo_item, only: [:update, :destroy]
  before_action :find_todo_list, only: [:create, :update]

  def create
    item = @list.todo_items.new(item_params)
    if item.save
      render status: 200, json: {
                            message: "Successfully created To-do Item.",
                            todo_list: @list,
                            todo_item: item
                        }.to_json
    else
      render status: 422, json: {
                            message: "To-do Item creation failed.",
                            errors: item.errors
                        }.to_json
    end
  end

  def update
    if @item.update(item_params)
      render  status: 200, json: {
                             message: "Successfully updated To-do item",
                             todo_list: @list,
                             todo_item: @item
                         }.to_json
    else
      render status: 422, json: {
                            message: "To-do Item update failed.",
                            errors: @item.errors
                        }.to_json
    end
  end

  def destroy
    @item.destroy
    render status: 200, json: {
                          message: "Successfully deleted To-do item",
                      }.to_json
  end

  private

  def item_params
    params.require("todo_item").permit("content")
  end

  def find_todo_list
    @list = find_record_or_render_error(TodoList, params[:todo_list_id])
  end

  def find_todo_item
    @item = find_record_or_render_error(TodoItem, params[:id])
  end
end