class WelcomeController < ApplicationController
  layout 'welcome'

  def index
  end

  def pics
    @title = "Picture Gallery"

    @images = Dir.entries("#{Rails.root}/app/assets/images/image_gallery").delete_if{ |f| f =~ /^\.+$/ }
  end

  def game
    @title = 'Match Game'
  end

  def info
    @title = 'Specific Information'

    @api_key = 'AIzaSyA49RbPoQKpfXOSKFVUQOFvadjXk8o43xo'
  end

  def news
    @title = "What's Going On?"
  end

  def registry
    @title = 'Registry'

    @macys_url = 'http://www1.macys.com/registry/wedding/guest/?registryId=770479'
    @bed_bath_url = 'http://www.bedbathandbeyond.com/regGiftRegistry.asp?wrn=-1220232619&'
  end

end
