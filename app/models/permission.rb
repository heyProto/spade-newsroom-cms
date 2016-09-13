# == Schema Information
#
# Table name: permissions
#
#  id         :integer          not null, primary key
#  seat_id    :string
#  names      :text
#  passphrase :string
#  url        :text
#  updated_by :integer
#  created_by :integer
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class Permission < ActiveRecord::Base
  #GEMS
  self.table_name = "permissions"

  ROUTES = Rails.application.routes.url_helpers

  #VALIDATION
  # validates :seat_id, presence: true, uniqueness: true

  class << self
    def validate_seat_ids(list)
      if list.present?
        used_id = Permission.all.pluck(:seat_id)
        diff = list & used_id
        if (diff).present?
          return {success: false, error: diff.join(", ") + " seats are already assigned.", diff: diff }
        else
          return {success: true}
        end
      else
        return {success: false, error: "Seat Ids cannot be blank."}
      end
    end

    def validate_names(names)
      unless names.present?
        return {success: false, error: "Names cannot be blank."}
      else
        return {success: true}
      end
    end

    def create_permissions(params)
      seat_ids = params[:seat_id]
      # valid_seat = {success: true} #validate_seat_ids(seat_ids)
      valid_name = validate_names(params[:names])

      if seat_ids.present? and valid_name[:success]
        url_hex = SecureRandom.hex(10)
        url = ROUTES.list_data_path(url_hex: url_hex)
        seat_ids.each do |s|
          Permission.create({
            seat_id: s,
            names: params[:names],
            url: BASE_URL + url,
            passphrase: url_hex
          });
        end
        return {success: true, url_hex: url_hex, url: BASE_URL + url}
      else
        errors = []
        errors << "Select atleat one seat." if !seat_ids.present?
        # errors << valid_seat[:error] if valid_seat[:error].present?
        errors << valid_name[:error] if valid_name[:error].present?
        err_obj = { success: false, error: errors }
        # err_obj[:diff] = valid_seat[:diff] if valid_seat[:diff].present?
        return err_obj
      end
    end

  end

end
