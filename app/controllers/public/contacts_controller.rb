class Public::ContactsController < ApplicationController
  def confirm
    @contact = Contact.new(contact_params)
    if @contact.invalid?
      render :"public/homes/top"
    end
  end

  def back
    @contact = Contact.new(contact_params)
    render :"public/homes/top"
  end

  def create
    @contact = Contact.new(contact_params)
    if @contact.save
      ContactMailer.send_mail(@contact).deliver_now
      redirect_to done_path
    else
      render :"public/homes/top"
    end
  end

  def done
  end

  def error
  end

  private
    def contact_params
      params.require(:contact).permit(:email, :name, :phone_number, :message)
    end
end
