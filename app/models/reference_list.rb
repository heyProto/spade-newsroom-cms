# == Schema Information
#
# Table name: reference_list
#
#  id         :integer          not null, primary key
#  genre      :string
#  value      :string
#  updated_by :integer
#  created_by :integer
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class ReferenceList < ActiveRecord::Base
  #GEMS
  self.table_name = "reference_list"

  #VALIDATION
  scope :skills_and_toolsets, -> {where(genre: ["skills", "toolset"])}
  scope :skills, -> {where(genre: "skills")}
  scope :toolset, -> {where(genre: "toolset")}
  scope :availability, -> {where(genre: "availability")}
  scope :seniority, -> {where(genre: "seniority")}
  scope :shifts, -> {where(genre: "shifts")}


  class << self
    def clean_column(genre, value)
      if genre === "skills"
        columns = Filter.where('skills like ?', "%#{value}%")
        columns.each do |x|
          current_skills = x.skills
          new_skills = current_skills.split(",")
          new_skills.delete(value)
          new_skills = new_skills.join(",")
          x.update_column(:skills, new_skills)
        end
      else
        columns = Filter.where('toolset like ?', "%#{value}%")
        columns.each do |x|
          current_toolset = x.toolset
          new_toolset = current_toolset.split(",")
          new_toolset.delete(value)
          new_toolset = new_toolset.join(",")
          x.update_column(:toolset, new_toolset)
        end
      end
    end
  end

end
