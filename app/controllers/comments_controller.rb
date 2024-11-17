class CommentsController < ApplicationController
  before_action :authenticate_user!

  def create

    @post = Post.find(params[:post_id])
    @comment = @post.comments.new(comments_params)
    @comment.user = current_user

    if @comment.save!
      redirect_to post_path(@post)
      flash[:notice] = "Comment created successfully"
    else
      redirect_to post_path(@post), 
      alert: "Failed to create comment. Please try again."
    end
  end

  def destroy
    
  end

  private
  def comments_params
    params.require(:comment).permit(:description)
  end

  def authenticate_user!
    unless user_signed_in?
      redirect_to root_path, alert: 'Debes iniciar sesión para comentar.'
    end
  end

end
