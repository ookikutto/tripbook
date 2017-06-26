json.extract! story_comment, :id, :user_id, :story_id, :comment, :created_at, :updated_at
json.url story_comment_url(story_comment, format: :json)
