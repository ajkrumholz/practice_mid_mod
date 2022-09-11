require 'rails_helper'

RSpec.describe Employee, type: :model do
  describe 'relationships' do
    it { should belong_to :department }
    it { should have_many(:tickets).through(:employee_tickets) }
  end

  let!(:medical) { Department.create!(name: "Medical", floor: 7) }

  let!(:flora) { medical.employees.create!(name: "Flora Gardez", level: 4) }
  let!(:james) { medical.employees.create!(name: "James Kochalka", level: 1) }
  let!(:barb) { medical.employees.create!(name: "Barb Laugher", level: 2) }
  let!(:sandra) { medical.employees.create!(name: "Sandra Lime", level: 3) }

  let!(:defuse) { Ticket.create!(subject: "Defuse the bomb", age: 1)}
  let!(:run) { Ticket.create!(subject: "Run from tentacles", age: 2)}
  let!(:surgery) { Ticket.create!(subject: "Do some surgery", age: 5)}
  let!(:clean) { Ticket.create!(subject: "Clean your hands", age: 9)}
  let!(:do_not) { Ticket.create!(subject: "Don't do this one", age: 8)}
  let!(:add_me) { Ticket.create!(subject: "Add this ticket", age: 4) }

  before :each do
    flora.tickets << defuse
    flora.tickets << run
    flora.tickets << surgery
    flora.tickets << clean
    james.tickets << run
    barb.tickets << defuse
    sandra.tickets << do_not
  end

  describe "#friends" do
    it 'returns an array of names of employees who share a ticket' do
      expect(flora.friends).to include(james.name)
      expect(flora.friends).to include(barb.name)
      expect(flora.friends).to_not include(sandra.name)
    end
  end
end