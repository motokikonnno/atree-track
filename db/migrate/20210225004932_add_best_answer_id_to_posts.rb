class AddBestAnswerIdToPosts < ActiveRecord::Migration[5.2]
  def change
    add_column :posts, :best_answer_id, :integer, default: nil
  end
end
