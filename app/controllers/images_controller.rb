class ImagesController < ApplicationController
  def create
    @images = Image.new
  end
end
