class SessionsController < ApplicationController
  def new
  end

  def create
    customer = Customer.find_by(username: params[:username])
    if customer&.authenticate(params[:password])
      session[:user_id] = customer.id
      redirect_to root_path, notice: 'Logged in successfully!'
    else
      flash.now[:alert] = 'Invalid email or password'
      render :new
    end
  end

  def destroy
    session[:user_id] = nil
    reset_session
    redirect_to root_path, notice: 'Logged out successfully!'
  end
end
