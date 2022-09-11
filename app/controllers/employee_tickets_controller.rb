class EmployeeTicketsController < ApplicationController
  def create
    EmployeeTicket.create(employee_id: params[:employee_id], ticket_id: params[:ticket_id])
    redirect_to "/employees/#{params[:employee_id]}"
  end
end