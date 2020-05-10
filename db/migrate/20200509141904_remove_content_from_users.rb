class RemoveContentFromUsers < ActiveRecord::Migration[5.2]
  def change
    remove_column :users, :content, :integer
  end
end
