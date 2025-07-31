# frozen_string_literal: true

class CommentsController < ApplicationController
  before_action :set_comment, only: [:destroy]
  before_action :set_post, only: %i[index create]
  before_action :new_comment_params, only: %i[create]

  def index
    @comments = @post.comment
  end

  def create
    @comment = new_comment_params
    authorize @comment
    return unless @comment.save

    redirect_to post_comments_path(@post.id), notice: t('comment_success')
  end

  def destroy
    authorize @comment
    return unless @comment.destroy

    redirect_to post_comments_path(@comment.post_id),
                notice: t('comment_del_success')
  end

  private

  def set_post
    @post = Post.find(params[:post_id])
  end

  def set_comment
    @comment = Comment.find(params[:id])
  end

  def new_comment_params
    params.permit(:com_text, :user_id, :post_id)
    @comment = Comment.new(user_name: current_user.name, comment_text: params[:com_text],
                           post_id: @post.id, user_id: current_user.id)
  end
end
