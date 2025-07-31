# frozen_string_literal: true

class ApprovesController < ApplicationController
  before_action :set_request, only: %i[update destroy]
  def index
    @requests = Request.where(requestee_id: current_user.id)
  end

  def update
    Relationship.find_or_create_by(follower_id: @request.requester_id, followee_id: current_user.id)
    if @request.destroy
      redirect_to approves_path, notice: t('request_appr_success')
    else
      redirect_to approves_path, alert: t('request_appr_failed')
    end
  end

  def destroy
    if @request.destroy
      redirect_to approves_path, notice: t('request_del_success')
    else
      redirect_to approves_path, alert: t('request_del_fail')
    end
  end

  private

  def set_request
    @request = Request.find(params[:id])
  end
end
