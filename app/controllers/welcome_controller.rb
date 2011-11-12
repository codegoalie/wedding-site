class WelcomeController < ApplicationController
  def index
    @title = "What's Going On?"
  end

  def pics
    @title = "Picture Gallery"

    @images = Dir.entries("#{Rails.public_path}/images/image_gallery").delete_if{ |f| f =~ /^\.+$/ }
  end

end
