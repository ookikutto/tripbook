class StoryLovesController < ApplicationController
  before_action :authenticate_user!
  before_action :find_story, only: [ :create ]

  def create
    current_user.love @story
    respond_to do |format|
      format.html { render @story }
      format.js
    end
  end

  def destroy
    @story = StoryLove.find(params[:id]).story
    current_user.unlove @story
    respond_to do |format|
      format.html { render @story }
      format.js
    end
  end

  private

  def find_story
    @story = Story.find_by id: params[:story_love][:story_id]
    if @story.nil?
      redirect_to home_path
    end
  end
end
