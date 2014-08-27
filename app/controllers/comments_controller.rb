class CommentsController < ApplicationController
  def index
    @comments = Comment.all
  end

  def new
    @comment = Comment.new
    @link = Link.find(params[:link_id])
  end

  def create
    @comment = Comment.new(comment_params)
    link = Link.find(params[:comment][:commentable_id])
    if @comment.save
      link.comments << @comment
      flash[:notice] = "Comment created."
      redirect_to links_path
    else
      render 'new'
    end
  end

  def show
    @comment = Comment.find(params[:id])
  end

  def edit
    @comment = Comment.find(params[:id])
  end

  def update
    @comment = Comment.find(comment_params)
    if @comment.update(params[:comment])
      flash[:notice] = "Comment updated."
      redirect_to comment_path(@comment)
    else
      render 'edit'
    end
  end

  def destroy
    @comment = Comment.find(params[:id])
    @comment.destroy
    flash[:notice] = "Comment deleted."
    redirect_to comments_path
  end

  private
  def comment_params
    params.require(:comment).permit(:comment, :commentable_id, :commentable_type, :link_id)
  end
end
