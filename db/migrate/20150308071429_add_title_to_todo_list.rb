class AddTitleToTodoList < ActiveRecord::Migration
  def change
    add_column :todo_lists, :title, :string
  end
end
