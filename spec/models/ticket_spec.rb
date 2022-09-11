require 'rails_helper'

RSpec.describe Ticket do
  describe 'relationships' do
    it { should have_many(:employees).through(:employee_tickets) }
  end
end