class UsersController < ApplicationController
  def show
    @user = User.find params[:id]
    @lastest = @user.stories.order(created_at: :desc)
    @hostest = @user.stories.sort_by {|story| -story.unique_impression_count}
    @favorites = @user.loved_stories.order created_at: :desc
  end
end
