require 'rails_helper'

RSpec.describe "Employee Show" do

# As a user, When I visit the Employee show page, I see the employee's name, department and a list of all of their tickets from oldest to youngest. I also see the oldest ticket assigned to the employee listed separately

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

    visit "/employees/#{flora.id}"
  end

  it 'displays the employee name and department' do
    expect(page).to have_content(flora.name)
    expect(page).to have_content(flora.department.name)
  end

  it 'displays a list of the employee tickets' do
    expect(page).to have_content(surgery.subject)
    expect(page).to have_content(clean.subject)
    expect(page).to_not have_content(do_not.subject)
  end

  it 'tickets are listed oldest to youngest' do
    expect(clean.subject).to appear_before(surgery.subject)
    expect(surgery.subject).to appear_before(run.subject)
    expect(run.subject).to appear_before(defuse.subject)
  end

  it 'has a section to highlight the oldest ticket' do
    within("#priority") do
      expect(page).to have_content(clean.subject)
      expect(page).to_not have_content(surgery.subject)
    end
  end

  # As a user, When I visit the employee show page, I do not see any tickets listed that are not assigned to the employee and I see a form to add a ticket to this movie When I fill in the form with the id of a ticket that already exists in the database and I click submit Then I am redirected back to that employees show page and i see the ticket's subject now listed (you do not have to test for sad path, for example if the id does not match an existing ticket

  describe 'adding a ticket to an employee' do
    it 'does not display tickets that have not been added' do
      expect(page).to_not have_content(add_me.subject)
    end

    it 'has a form to add a ticket by ticket_id' do
      expect(page).to have_field("Ticket Id Number")
    end

    describe 'when i fill out the form' do

      it 'adds the ticket to the employee' do
        expect(page).to_not have_content(add_me.subject)

        fill_in("Ticket Id Number", with: add_me.id)
        click_on("Add")

        expect(current_path).to eq("/employees/#{flora.id}")
        expect(page).to have_content(add_me.subject)
      end

    end

    # As a user, When I visit an employee's show page I see that employees name and level and I see a unique list of all the other employees that this employee shares tickets with

    describe 'best friends' do
      it 'shows a list of other employees this one shares a ticket with' do
        within "#best_friends" do
          expect(page).to have_content(barb.name)
          expect(page).to have_content(james.name)
          expect(page).to_not have_content(sandra.name)
        end
      end
    end
  end
end