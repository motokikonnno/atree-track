class AddAnswerIdToPosts < ActiveRecord::Migration[5.2]
  def change
    add_column :posts, :answer_id, :integer
  end
end
