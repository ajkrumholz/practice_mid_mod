class Employee < ApplicationRecord
  belongs_to :department
  has_many :employee_tickets
  has_many :tickets, through: :employee_tickets

  def tickets_age_desc
    tickets.order(age: :desc)
  end

  def priority_ticket
    tickets_age_desc.first
  end

  def friends
    Employee.joins(:tickets).where(tickets: {id: self.tickets.pluck(:id)}).where.not(name: self.name).distinct.pluck(:name)
    require 'pry'; binding.pry
  end
end