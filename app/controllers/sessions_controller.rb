class SessionsController < ApplicationController
  layout 'signin'

  def new
  end

  def create
    @page_title = t('session.login')
    user = User.find_by(email: params[:session][:email].downcase)
    if user && user.authenticate(params[:session][:password])
      sign_in user
      user.update_attribute(:last_ip, request.remote_ip)
      redirect_back_or index_path
    else
      flash.now[:error] = t('session.email_or_password_incorrect')
      render 'new'
    end
  end

  def destroy
    sign_out
    redirect_to root_path
  end
end
