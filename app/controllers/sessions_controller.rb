class SessionsController < ApplicationController
def new 
    if logged_in?
        flash[:danger] = "Jesteś już zalogowany"
        redirect_to root_path
    end
end
def create
    user = User.find_by(email: params[:session][:email].downcase)
    if user && user.authenticate(params[:session][:password])
        session[:user_id] = user.id
        session[:expires_at] = Time.current + 20.minutes
        flash[:success] = "Zostałeś prawidłowo zalogowany"
        redirect_to root_path
    else
        flash.now[:danger] = "Podałeś błędne dane logowania"
        render 'new'
    end
end
def destroy
    session[:user_id] = nil
    flash[:success] = "Zostałeś wylogowany"
    redirect_to root_path
end
end