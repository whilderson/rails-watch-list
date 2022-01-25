class ListsController < ApplicationController
  before_action :set_list, only: %i[show edit update]
  def index
    @lists = List.all
    @movies = Movie.all
  end

  def show; end

  def new
    @list = List.new
  end

  def create
    @list = List.create(list_params)

    redirect_to lists_path
  end

  def edit; end

  def update
    @list.update(list_params)

    redirect_to lists_path
  end

  private

  def set_list
    @list = List.find(params[:id])
  end

  def list_params
    params.require(:list).permit(:name, :image_url)
  end
end
