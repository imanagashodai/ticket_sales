class PagesController < ApplicationController
  def index
    @time = Time.now
    @games = Game.where(datetime: @time.all_day)
  end
end
