class StoryCommentsController < ApplicationController
  before_action :set_story_comment, only: [:show, :edit, :update, :destroy]

  # GET /story_comments
  # GET /story_comments.json
  def index
    @story_comments = StoryComment.all
  end

  # GET /story_comments/1
  # GET /story_comments/1.json
  def show
  end

  # GET /story_comments/new
  def new
    @story_comment = StoryComment.new
  end

  # GET /story_comments/1/edit
  def edit
  end

  # POST /story_comments
  # POST /story_comments.json
  def create
    @story_comment = StoryComment.new(story_comment_params)
    @story_comment.user_id = current_user.id

    respond_to do |format|
      if @story_comment.save
        # url = "/stories/" + @story_comment.story_id.to_s
        # format.html { redirect_to @story_comment, notice: 'Story comment was successfully created.' }
        # format.json { render :show, status: :created, location: @story_comment }
        format.html { redirect_to :back}
      else
        format.html { render :new }
        format.json { render json: @story_comment.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /story_comments/1
  # PATCH/PUT /story_comments/1.json
  def update
    respond_to do |format|
      if @story_comment.update(story_comment_params)
        format.html { redirect_to @story_comment, notice: 'Story comment was successfully updated.' }
        format.json { render :show, status: :ok, location: @story_comment }
      else
        format.html { render :edit }
        format.json { render json: @story_comment.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /story_comments/1
  # DELETE /story_comments/1.json
  def destroy
    @story_comment.destroy
    respond_to do |format|
      format.html { redirect_to story_comments_url, notice: 'Story comment was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_story_comment
      @story_comment = StoryComment.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def story_comment_params
      params.require(:story_comment).permit(:user_id, :story_id, :comment)
    end
end
