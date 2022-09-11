require 'rails_helper'

RSpec.describe 'Department Index' do
# As a user, When I visit the Department index page, I see each department's name and floor And underneath each department, I can see the names of all of its employees

  let!(:medical) { Department.create!(name: "Medical", floor: 7) }
  let!(:engineering) { Department.create!(name: "Engineering", floor: 5) }

  let!(:flora) { medical.employees.create!(name: "Flora Gardez", level: 4) }
  let!(:jason) { medical.employees.create!(name: "Jason Sinclair", level: 1) }
  let!(:roger) { medical.employees.create!(name: "Roger Fedz", level: 9) }
  let!(:tom) { medical.employees.create!(name: "Tomasz Piffles", level: 3) }

  let!(:gordon) { engineering.employees.create!(name: "Gordon Butt", level: 2) }
  let!(:chowder) { engineering.employees.create!(name: "Chowder Rogers", level: 3) }
  let!(:bunsworth) { engineering.employees.create!(name: "Bunsworth George", level: 7) }
  let!(:cramer) { engineering.employees.create!(name: "Cramer Framer", level: 8) }
  let!(:timmy) { engineering.employees.create!(name: "Timmy Two-Tone", level: 9) }

  it 'displays the department name and floor' do
    visit '/departments'
    expect(page).to have_content medical.name
    expect(page).to have_content medical.floor

    expect(page).to have_content engineering.name
    expect(page).to have_content engineering.floor
  end

  it 'lists all employees who belong to the department' do
    visit '/departments'
    within("#dept_#{medical.id}") do
      expect(page).to have_content(flora.name)
      expect(page).to have_content(jason.name)
      expect(page).to_not have_content(gordon.name)
    end

    within("#dept_#{engineering.id}") do
      expect(page).to have_content(gordon.name)
      expect(page).to have_content(chowder.name)
      expect(page).to_not have_content(flora.name)
    end
  end
end