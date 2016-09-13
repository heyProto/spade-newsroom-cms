class DescriptionsController < ApplicationController
  before_action :set_description, only: [:edit, :update, :details]
  before_action :authenticate, except: [:show]
  respond_to :json

  def index
    @descriptions = Description.all.as_json(only: [:seat_id])
  end

  #API
  def show
    desc = Description.where(seat_id: params[:seat_id]).first
    filter = Filter.where(seat_id: params[:seat_id]).first
    if desc.present? or filter.present?
      render json: {
        success: true,
        description: desc.as_json(only: [:seat_id, :hub_description,:desk_description, :role_description, :persona_description]),
        filter: filter.as_json(only: [:seat_id, :slug, :hub, :desk, :seniority, :shifts, :skills, :toolset, :availability])
      },status: 200
    else
      render json: {
        success: false,
        errors: "Description not found."
      }, status: 422
    end
  end

  def details
    @filter_data = Filter.where(seat_id: params[:seat_id]).first
  end

  def edit
    @filter_data = Filter.where(seat_id: params[:seat_id]).first
  end

  def update
    if @desc.update_attributes(desc_params)
      redirect_to descriptions_path, notice: t('u.s')
    else
      redirect_to edit_description_path(@desc), alert: t('u.f')
    end
  end

  def set_description
    @seat_id = params[:seat_id]
    @desc = Description.where(seat_id: @seat_id).first
  end

  def desc_params
    params.require(:description).permit(:seat_id, :hub_description,:desk_description, :role_description, :persona_description)
  end

  protected
  def authenticate
    authenticate_or_request_with_http_basic do |username, password|
      username == ENV["USERNAME"] && password == ENV["PASSWORD"]
    end
  end
end
