class AddAnswerIdToNotifications < ActiveRecord::Migration[5.2]
  def change
    add_column :notifications, :answer_id, :integer
  end
end
