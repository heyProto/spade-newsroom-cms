class FiltersController < ApplicationController
  before_action :permission_seat_ids, only: [:index, :edit]
  respond_to :json

  def index
    @url_hex = params[:url_hex]
    unless Permission.where(passphrase: @url_hex).present?
      render "page_not_found" and return
    end

    if @url_hex === ENV["MASTER_HEX"]
      authenticate_or_request_with_http_basic do |username, password|
        username == ENV["USERNAME"] && password == ENV["PASSWORD"]
      end
    end

    @used_seats = Filter.where.not(seat_id: @seat_ids).pluck(:seat_id)
    @desks = Filter.where(seat_id: @seat_ids)
    @selected_seats = @desks.pluck(:seat_id)
  end

  #API
  def show
    where_query = {}

    where_query[:hub] = desk_params[:hub].split(",") if desk_params[:hub].present?
    where_query[:desk] = desk_params[:desk].split(",") if desk_params[:desk].present?
    where_query[:seniority] = desk_params[:seniority] if desk_params[:seniority].present?
    where_query[:shifts] = desk_params[:shifts] if desk_params[:shifts].present?
    where_query[:availability] = desk_params[:availability] if desk_params[:availability].present?

    result = Filter.where(where_query)
    result = result.where('skills like ?', "%#{desk_params[:skills].split(",").join("%")}%") if desk_params[:skills].present?
    result = result.where('toolset like ?', "%#{desk_params[:toolset].split(",").join("%")}%") if desk_params[:toolset].present?

    if result.present?
      render json: {
          success: true,
          message: result.as_json(only: [:seat_id, :slug, :hub, :desk, :seniority, :shifts, :skills, :toolset, :availability]),
          count: result.count,
        }, status:200
    else
      render json: {
          success: false,
          errors: "No records found."
        }, status: 200
    end
  end

  def edit
    @current_seat_id = params[:seat_id]
    @url_hex = params[:url_hex]

    if @url_hex === ENV["MASTER_HEX"]
      authenticate_or_request_with_http_basic do |username, password|
        username == ENV["USERNAME"] && password == ENV["PASSWORD"]
      end
    end

    @available_seat_ids = Filter.where(seat_id: @seat_ids).pluck(:seat_id)
    @unavailable_seat_ids = Filter.where.not(seat_id: @available_seat_ids).pluck(:seat_id)
    @skills = ReferenceList.skills.pluck(:value)
    @toolset = ReferenceList.toolset.pluck(:value)
    @availability = ReferenceList.availability.pluck(:value)
    @seniority = ReferenceList.seniority.pluck(:value)
    @shifts = ReferenceList.shifts.pluck(:value)
    @desk = Filter.where(seat_id: @current_seat_id).first
  end

  def update
    @desk = Filter.where(seat_id: desk_params[:seat_id]).first
    @url_hex = desk_params[:url_hex]
    options = desk_params
    options.delete(:url_hex)

    if !options[:desk].present?
      options[:slug] = options[:seniority] + " - " + options[:hub] + " Hub"
    else
      options[:slug] = options[:seniority] + " - " + options[:desk] + " Desk"
    end

    if @desk.update_attributes(options)
      redirect_to list_data_path(url_hex: @url_hex), notice: t('u.s')
    else
      redirect_to edit_data_path(url_hex: @url_hex, seat_id: options[:seat_id]), alert: t('u.f')
    end
  end

  def permission_seat_ids
    @seat_ids = Permission.where(passphrase: params[:url_hex]).pluck(:seat_id)
  end

  def desk_params
    params.require(:filter).permit(:url_hex, :seat_id, :slug, :hub, :desk, :seniority, :shifts, :skills, :toolset, :availability)
  end
end
