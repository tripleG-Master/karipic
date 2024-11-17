class CommentsController < ApplicationController
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


end
