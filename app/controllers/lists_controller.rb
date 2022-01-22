class ListsController < ApplicationController
  before_action :set_list, only: %i[show]
  def index
    @lists = List.all
    @movies = Movie.all
  end

  def show; end

  def edit
  end

  private

  def set_list
    @list = List.find(params[:id])
  end
end
