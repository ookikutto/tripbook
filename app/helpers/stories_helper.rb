module StoriesHelper
  def authorize_user?(story, user)
    story.user.id == user.id
  end
end
