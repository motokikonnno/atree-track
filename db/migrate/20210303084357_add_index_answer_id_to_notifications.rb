class AddIndexAnswerIdToNotifications < ActiveRecord::Migration[5.2]
  def change
    add_index :notifications, :answer_id
  end
end
