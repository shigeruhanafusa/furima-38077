class CommentsController < ApplicationController
  def create
    @comment = Comment.new(comment_params)
    @item = Item.find(params[:item_id])
    CommentChannel.broadcast_to @item, { comment: @comment, user: @comment.user } if @comment.save
  end

  private

  def comment_params
    params.require(:comment).permit(:text).merge(user_id: current_user.id, item_id: params[:item_id])
  end
end
