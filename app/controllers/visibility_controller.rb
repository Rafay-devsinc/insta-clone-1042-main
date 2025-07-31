# frozen_string_literal: true

class VisibilityController < ApplicationController
  def index
    current_user.is_public = if current_user.is_public
                               false
                             else
                               true
                             end
    if current_user.save
      redirect_to posts_path, notice: t('visibility_success')
    else
      redirect_to posts_path, alert: t('visibility_fail')
    end
  end
end
