# frozen_string_literal: true

class StoriesController < ApplicationController
  before_action :set_story, only: %i[destroy]

  def index
    @stories = Story.all
  end

  def new
    @story = Story.new
  end

  def create
    @new_story = Story.new(new_story_params)
    if @new_story.save
      redirect_to stories_path
    else
      redirect_to stories_path, alert: t('story_failed')
    end
  end

  def destroy
    authorize @story
    redirect_to stories_path, notice: t('story_del_success') if @story.destroy
  end

  private

  def set_story
    @story = Story.find(params[:id])
  end

  def new_story_params
    params.require(:story).permit(:story_text, :user_id, images: [])
  end
end
