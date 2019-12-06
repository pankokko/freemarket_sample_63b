class CommentsController < ApplicationController
  def create
    
    @comment = Comment.new(comment_params)
    @comment.save
    redirect_to root_path
    # binding.pry
  end

  private
  def comment_params
    params.require(:comment).permit(:comment, :exhibit_id).merge(user_id: current_user.id, exhibit_id: params[:id])
  end
end
