class WelcomeController < ApplicationController
  def index
    @title = "What's Going On?"
  end

  def pics
    @title = "Picture Gallery"

    @images = Dir.entries("#{Rails.public_path}/images/image_gallery").delete_if{ |f| f =~ /^\.+$/ }
  end

  def game
    @title = 'Match Game'
  end

  def info
    @title = 'Specific Information'

    @api_key = 'AIzaSyA49RbPoQKpfXOSKFVUQOFvadjXk8o43xo'
  end

end
