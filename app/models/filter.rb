# == Schema Information
#
# Table name: filter_data
#
#  id           :integer          not null, primary key
#  seat_id      :string
#  slug         :string
#  hub          :string
#  desk         :string
#  seniority    :string
#  shifts       :string
#  skills       :text             default("{}")
#  toolset      :text             default("{}")
#  availability :string
#  updated_by   :integer
#  created_by   :integer
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#

class Filter < ActiveRecord::Base
  #GEMS
  self.table_name = "filter_data"

  #VALIDATION
  validates :seat_id, presence: true, uniqueness: true

  # extend FriendlyId
  # friendly_id :seat_id, use: :slugged, slug_column: :seat_id
end
