class AddPostToAnswers < ActiveRecord::Migration[5.2]
  def change
    add_reference :answers, :post, foreign_key: true
  end
end
