# frozen_string_literal: true

class RequestsController < ApplicationController
  before_action :set_request, only: %i[destroy]

  def index
    @requests = Request.where(requester_id: current_user.id)
  end

  def create
    if User.exists?(params[:user_id])
      @request = Request.new(requestee_id: params[:user_id],
                             requester_id: current_user.id)
    end
    return unless @request.save

    redirect_to user_requests_path, notice: t('request_success')
  end

  def destroy
    if @request.destroy
      redirect_to user_requests_path, notice: t('request_del_success')
    else
      redirect_to user_requests_path, notice: t('request_del_fail')
    end
  end

  private

  def set_request
    @request = Request.find(params[:id])
  end
end
