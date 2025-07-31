# frozen_string_literal: true

class LikesController < ApplicationController
  before_action :authenticate_user!
  before_action :getting_like, only: %i[destroy]
  before_action :set_like, only: %i[create]

  def create
    return unless @like.save

    respond_to :js
  end

  def destroy
    return unless @like.destroy

    respond_to :js
  end

  private

  def getting_like
    @like = Like.find(params[:id])
    @post = @like.post
  end

  def like_params
    params.permit :post_id
  end

  def set_like
    @like = current_user.likes.build(like_params)
    @post = @like.post
  end
end
