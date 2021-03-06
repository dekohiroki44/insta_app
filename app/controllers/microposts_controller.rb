class MicropostsController < ApplicationController
  before_action :logged_in_user, only: [:new, :create, :destroy]
  before_action :correct_user,   only: :destroy

  def new
    @micropost = Micropost.new
  end

  def show
    @micropost = Micropost.find(params[:id])
    @user = User.find(@micropost.user_id)
    @comments = @micropost.comments
    @comment = Comment.new
    respond_to do |format|
      format.html { render 'microposts/_show' }
      format.js
    end
  end

  def create
    @micropost = current_user.microposts.build(micropost_params)
    if @micropost.save
      flash[:success] = "投稿しました！"
      redirect_to root_url
    else
      @feed_items = []
      render new_micropost_path
    end
  end

  def destroy
    @micropost.destroy
    flash[:success] = "投稿を削除しました"
    redirect_to request.referrer || root_url
  end

  def search
    @microposts = Micropost.search(params[:search])
  end

  private

    def micropost_params
      params.require(:micropost).permit(:content, :picture)
    end

    def correct_user
      @micropost = current_user.microposts.find_by(id: params[:id])
      redirect_to root_url if @micropost.nil?
    end
end
