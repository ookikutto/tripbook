class RelationshipsController < ApplicationController
  def create
    @target = relationship_params[:followable_type].constantize.
      find relationship_params[:followable_id]
    current_user.follow @target
    respond_to do |format|
      format.html { redirect_to @target }
      format.js
    end
  end

  def destroy
    @target = Relationship.find(params[:id]).followable
    current_user.unfollow @target
    respond_to do |format|
      format.html {redirect_to @target}
      format.js
    end
  end

  private

  def relationship_params
    params.require(:relationship).permit(:followable_id, :followable_type)
  end
end
