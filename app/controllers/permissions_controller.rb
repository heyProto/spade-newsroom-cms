class PermissionsController < ApplicationController
  before_action :authenticate
  respond_to :json

  def index
    permissions = Permission.where.not(passphrase: ENV["MASTER_HEX"]).as_json(only: [:seat_id, :names, :passphrase, :url])
    permissions = permissions.group_by{|d| d["passphrase"]}

    @permissions= {}
    permissions.each do |k,v|
      @permissions[k]= {seat_ids: v.map{|s| s["seat_id"]}, names: v[0]["names"], url: v[0]["url"], passphrase: v[0]["passphrase"]}
    end
  end

  def show
    @url_hex = params[:url_hex]
    permission = Permission.where(passphrase: @url_hex)
    @seat_ids = permission.pluck(:seat_id)
    @names = permission.first.names
  end

  def new
    @permission = Permission.new
    @used_seats = [] # Permission.all.pluck(:seat_id)
    @unused_seat_id = [] #Filter.where.not(seat_id: @used_seats).pluck(:seat_id)
    @seats_added = []
  end

  def create
    options = desk_params
    options[:seat_id] = options[:seat_id].present? ? options[:seat_id].split(",") : []
    @seats_added = options[:seat_id]
    success = Permission.create_permissions(options)
    if success[:success]
      redirect_to permission_path(url_hex: success[:url_hex]), notice: t('c.s')
    else
      flash[:errors] = success[:error]
      redirect_to new_permission_path
    end
  end

  def destroy
    permission = Permission.where(passphrase: params[:url_hex])
    permission.destroy_all
    redirect_to :back, notice: t('d.s')
  end

  def destroy_seat_level
    permission = Permission.where(passphrase: params[:url_hex], seat_id: params[:seat_id]).first
    permission.destroy
    redirect_to :back, notice: t("d.s")
  end

  def desk_params
    params[:permission][:seat_id] ||= []
    params.require(:permission).permit(:names, :seat_id)
  end

  protected
  def authenticate
    authenticate_or_request_with_http_basic do |username, password|
      username == ENV["USERNAME"] && password == ENV["PASSWORD"]
    end
  end
end
