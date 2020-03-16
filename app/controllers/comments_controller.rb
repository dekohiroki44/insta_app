class CommentsController < ApplicationController
  before_action :logged_in_user

  def create
    micropost = Micropost.find(params[:micropost_id])
    @comment = micropost.comments.build(comment_params)
    @comment.user_id = current_user.id
    if @comment.save
      flash[:success] = "コメントしました"
      redirect_back(fallback_location: root_path)
    else
      flash[:success] = "コメントできませんでした"
      redirect_back(fallback_location: root_path)
    end
  end

  def destroy
    # p ############
    # p params[:comment_id]
    # p #################
    Comment.find_by(id: params[:id], micropost_id: params[:micropost_id]).destroy
    redirect_back(fallback_location: root_path)
  end

  private

  def comment_params
    params.require(:comment).permit(:content)
  end
end