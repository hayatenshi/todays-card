class ImagesController < ApplicationController
  def index
    @image = Image.find(params[:image_id])
  end
end
