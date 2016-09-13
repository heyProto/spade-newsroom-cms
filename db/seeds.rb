# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

require "csv"
############################## LOADING DESCRIPTION DATA ##########################################
path = "ref/description_data.csv"

csv_data = CSV.read(path)

csv_data.each_with_index do |line, index|
  next if index == 0
  seat_id = line[0].strip if line[0].present?
  hub_description = line[1].present? ? line[1].strip : "hub_description_#{index}"
  desk_description = line[2].present? ? line[2].strip : "desk_description_#{index}"
  role_description = line[3].present? ? line[3].strip : "role_description_#{index}"
  persona_description = line[4].present? ? line[4].strip : "persona_description_#{index}"

  Description.create({
    seat_id: seat_id,
    hub_description: hub_description,
    desk_description: desk_description,
    role_description: role_description,
    persona_description: persona_description
  })

  puts "Description DATA row #{index+1}"
end


##############################    LOADING FILTER DATA   ##########################################
path = "ref/filter_data.csv"

csv_data = CSV.read(path)

csv_data.each_with_index do |line, index|
  next if index == 0

  seat_id = line[0].strip if line[0].present?
  hub = line[2].strip if line[2].present?
  desk = line[3].strip if line[3].present?
  seniority = line[4].strip if line[4].present?
  shifts = line[5].strip if line[5].present?
  skills = line[6].strip if line[6].present?
  toolset = line[7].strip if line[7].present?
  availability = line[8].strip if line[8].present?

  if !desk.present?
    slug = seniority + " — " + hub + " Hub"
  else
    slug = seniority + " — " + desk + " Desk"
  end

  Filter.create({
    seat_id: seat_id,
    slug: slug,
    hub: hub,
    desk: desk,
    seniority: seniority,
    shifts: shifts,
    skills: skills,
    toolset: toolset,
    availability: availability
  })

  puts "Filter DATA row #{index+1}"
end


################################## REFERENCE LIST ###############################################

skills = ["Anchor", "Copy Editor", "Developer", "Graphic Designer  TV", "Graphic Designer - Digital", "Graphic Designer - Print", "Journalist", "Reporter - Digital", "Reporter - Print", "Reporter - TV"]
skills.each do |x|
  ReferenceList.create({genre: "skills", value: x})
end

toolset = ["CSS", "HTML", "Illustrator", "InDesign", "JavaScript", "Photoshop"]
toolset.each do |x|
  ReferenceList.create({genre: "toolset", value: x})
end

availability = ["Hired", "Hiring"]
availability.each do |x|
  ReferenceList.create({genre: "availability", value: x})
end

seniority = ["Assistant Producer", "Associate Producer", "Chief Producer", "Executive Producer", "Managing Producer", "Producer", "Senior Producer", "Trainee Producer"]
seniority.each do |x|
  ReferenceList.create({genre: "seniority", value: x})
end

hub = ["Assembling", "Distribution", "Production", "Sourcing"]
hub.each do |x|
  ReferenceList.create({genre: "hub", value: x})
end

shifts = ["Evening", "Graveyard", "Morning"]
shifts.each do |x|
  ReferenceList.create({genre: "shifts", value: x})
end

desk = ["Ads", "Alerts", "Assignment", "Campaigns", "Control", "Copy", "Culture", "Design", "Engagement", "Events", "Growth", "Home Bureau", "Interactives", "Mobile", "Multimedia", "NA", "Radio", "Research", "Seeding", "Shows", "Studio", "Support", "TV", "Web", "ePrint"]
desk.each do |x|
  ReferenceList.create({genre: "desk", value: x})
end


###################################### Creating master link ##########################################

seat_ids = Filter.all.pluck(:seat_id)
url_hex = ENV['MASTER_HEX']
seat_ids.each do |s|
  Permission.create({
    seat_id: s,
    names: "Nasr",
    url: BASE_URL + Rails.application.routes.url_helpers.list_data_path(url_hex: url_hex),
    passphrase: url_hex
  });
end