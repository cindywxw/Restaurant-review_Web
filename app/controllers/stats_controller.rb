class StatsController < ApplicationController

  def completed_tasks
    render json: User.group(:admin).count
  end

end