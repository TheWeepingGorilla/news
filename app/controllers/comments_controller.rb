class CommentsController < ApplicationController
  def index
    @comments = Comment.all
  end

  def new
    @comment = Comment.new
    @referring_link_id = params[:referring_link_id]
    @referring_comment_id = params[:referring_comment_id]
    if @referring_link_id != nil
      @commentable_id = @referring_link_id
      @commentable_type = "Link"
    end
    if @referring_comment_id != nil
      @commentable_id = @referring_comment_id
      @commentable_type = "Comment"
    end
  end

  def create

    @comment = Comment.new(comment_params)
    link = Link.find(params[:referring_link_id]) if params[:referring_link_id] != nil
    referring_comment = Comment.find(params[:referring_comment_id]) if params[:referring_comment_id] != nil
    if @comment.save
      link.comments << @comment if params[:referring_link_id]
      @comment.comments << referring_comment if params[:referring_comment_id]
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
      redirect_to links_path
    else
      render 'edit'
    end
  end

  def destroy
    @comment = Comment.find(params[:id])
    @comment.destroy
    flash[:notice] = "Comment deleted."
    redirect_to links_path
  end

  private
  def comment_params
    params.require(:comment).permit(:comment, :commentable_id,
                                    :commentable_type)
  end
end
