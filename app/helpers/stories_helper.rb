module StoriesHelper
  def authorize_user?(story, user)
    user && story.user.id == user.id
  end
end
