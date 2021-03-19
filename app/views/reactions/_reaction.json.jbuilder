json.extract! reaction, :id, :user_id, :answer_id, :body, :created_at, :updated_at
json.url reaction_url(reaction, format: :json)
