class Post < ApplicationRecord
    validates :video, presence: true
    validates :content, presence: true, length: { maximum: 140 }
    mount_uploader :video, VideoUploader
    belongs_to :user
    has_many :answers, dependent: :destroy
    has_many :likes, dependent: :destroy
    has_many :favorites, dependent: :destroy
    has_many :post_tags, dependent: :destroy
    has_many :tags, through: :post_tags
    has_many :notifications, dependent: :destroy

    def create_notification_like!(current_user)
        temp = Notification.where(["visitor_id = ? and visited_id = ? and post_id = ? and action = ?", current_user.id, user_id, id, 'like'])
        if temp.blank?
            notification = current_user.active_notifications.new(
                post_id: id,
                visited_id: user_id,
                action: 'like'
            )
            if notification.visitor_id == notification.visited_id
                notification.checked = true
            end
            notification.save if notification.valid?
        end
    end

    def create_notification_reaction!(current_user, reaction_id)
        temp_ids = Reaction.select(:user_id).where(answer_id: id).where.not(user_id: current_user.id).distinct
        temp_ids.each do |temp_id|
            save_notification_reaction!(current_user, reaction_id, temp_id['user_id'])
        end
        save_notification_reaction!(current_user, reaction_id, user_id) if temp_ids.blank?
    end

    def save_notification_reaction!(current_user, reaction_id, visited_id)
        notification = current_user.active_notifications.new(
            post_id: id,
            reaction_id: reaction_id,
            visited_id: visited_id,
            action: 'reaction'
        )
        if notification.visitor_id == notification.visited_id
            notification.checked = true
        end
        notification.save if notification.valid?
    end

    def create_notification_answer!(current_user, answer_id)
        save_notification_answer!(current_user, answer_id, user_id)
    end
    
    def save_notification_answer!(current_user, answer_id, visited_id)
        notification = current_user.active_notifications.new(
            post_id: id,
            answer_id: answer_id,
            visited_id: user_id,
            action: 'answer'
        )
        notification.save if notification.valid?
    end
end
