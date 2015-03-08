class CreateTodoItems < ActiveRecord::Migration
  def change
    create_table :todo_items do |t|
      t.text :content
      t.references :todo_list, index: true

      t.timestamps
    end
  end
end
