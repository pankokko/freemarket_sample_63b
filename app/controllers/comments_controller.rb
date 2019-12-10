class CommentsController < ApplicationController
  def create
    @comment = Comment.create(comment: comment_params[:comment], exhibit_id: comment_params[:exhibit_id], user_id: current_user.id)
    redirect_to exhibit_path(comment_params[:exhibit_id])
  end

  private
  def comment_params
    params.require(:comment).permit(:comment, :exhibit_id).merge(user_id: current_user.id)
  end
end