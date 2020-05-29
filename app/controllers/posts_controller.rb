class PostsController < ApplicationController
  before_action :authenticate_user
  before_action :ensure_correct_user, {only: [:edit, :update, :destroy]}
  
  def show
    @post = Post.find_by(id: params[:id])
    @user = @post.user
  end
  
  def new
    @post = Post.new
    @user = User.find_by(instaid: params[:user_id]) 
    @id = @user.id
  end
  
  def create
    
    @post = Post.new(
      content: params[:content],
      user_id: @current_user.id,
      rate: params[:rate],
      post_id: params[:a]
      )
   if @post.post_id != @current_user.id
      if @post.save
        flash[:notice] = "投稿を作成しました"
        redirect_to("/users/index")
      else
        render("posts/new")
      end
   else
     flash[:notice] = "自分を評価できません"
     redirect_to("/users/index")
   end
    
  end
  
  def edit
    @post = Post.find_by(id: params[:id])
  end
  
  def update
    @post = Post.find_by(id: params[:id])
    @post.content = params[:content]
    if @post.save
      flash[:notice] = "投稿を編集しました"
      redirect_to("/users/index")
    else
      render("posts/edit")
    end
  end
  
  def destroy
    @post = Post.find_by(id: params[:id])
    @post.destroy
    flash[:notice] = "投稿を削除しました"
    redirect_to("/posts/index")
  end
  
  def ensure_correct_user
    @post = Post.find_by(id: params[:id])
    if @post.user_id != @current_user.id
      flash[:notice] = "権限がありません"
      redirect_to("/posts/index")
    end
  end
  
end
