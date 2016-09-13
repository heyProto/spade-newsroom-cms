class ReferenceListsController < ApplicationController
  before_action :ref_obj, only: [:destroy]
  before_action :authenticate, except: [:show]
  respond_to :json

  def new
    @ref_list = ReferenceList.skills_and_toolsets
    @all_genre = @ref_list.pluck(:genre).uniq
    @ref_obj = ReferenceList.new
  end

  def create
    @ref_obj = ReferenceList.new(ref_list_params)
    if @ref_obj.save
      redirect_to new_reference_list_path, notice: t('c.s')
    else
      redirect_to new_reference_list_path, alert: t('c.f')
    end
  end

  #API
  def show
    ref_list = ReferenceList.all.as_json(only: [:genre, :value])
    ref_list = ref_list.group_by{|d| d["genre"]}
    ref_list_new = {}
    ref_list.each do |k, v|
      ref_list_new[k] = v.map {|i| i["value"]}
    end
    render json: {success: true, data: ref_list_new}, status: 200
  end

  def destroy
    ReferenceList.clean_column(@ref_obj.genre, @ref_obj.value)
    @ref_obj.destroy
    redirect_to new_reference_list_path, notice: t('d.s')
  end

  def ref_obj
    @ref_obj = ReferenceList.where(id: params[:id]).first
  end

  def ref_list_params
    params.require(:reference_list).permit(:genre, :value)
  end

  protected
  def authenticate
    authenticate_or_request_with_http_basic do |username, password|
      username == ENV["USERNAME"] && password == ENV["PASSWORD"]
    end
  end
end
