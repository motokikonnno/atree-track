class RemoveAnswerIdFromPosts < ActiveRecord::Migration[5.2]
  def change
    remove_column :posts, :answer_id, :integer
  end
end
