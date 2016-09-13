# == Schema Information
#
# Table name: description_data
#
#  id                  :integer          not null, primary key
#  seat_id             :string
#  hub_description     :text
#  desk_description    :text
#  role_description    :text
#  persona_description :text
#  updated_by          :integer
#  created_by          :integer
#  created_at          :datetime         not null
#  updated_at          :datetime         not null
#

class Description < ActiveRecord::Base
  #GEMS
  self.table_name = "description_data"

  #VALIDATION
  validates :seat_id, presence: true, uniqueness: true

  # extend FriendlyId
  # friendly_id :seat_id, use: :slugged, slug_column: :seat_id
end
