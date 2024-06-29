class Public::HomesController < ApplicationController
  def top
    @contact = Contact.new
  end

  def privacy
  end
end
