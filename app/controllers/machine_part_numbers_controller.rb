class MachinePartNumbersController < ApplicationController
   before_action :authenticate_user!

  def index
    @machine = Machine.find(params[:machine_id])
    @machine_part_numbers = @machine.machine_part_numbers

    respond_to do |format|
      format.json
    end
  end
end
