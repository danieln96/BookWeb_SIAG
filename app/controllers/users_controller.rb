class UsersController < ApplicationController
    before_action :set_user, only: [:edit, :update, :show, :destroy]
    before_action :require_same_user, only: [:edit, :update]
    before_action :require_admin, only: [:getadmin, :index, :destroy]
    def new
        @user = User.new
    end
    def create
        @user = User.new(user_params)
        if /^(?=.*\d)(?=.*([a-z]|[A-Z]))([\x20-\x7E]){8,40}$/.match(params[:password])
            if @user.save
                session[:user_id] = @user.id
                flash[:success] = "Witamy #{@user.username}!"
                redirect_to root_path
            else
               render 'new' 
            end
        else
           flash[:info] = "Hasło musi mieć minimum 8 znaków, jedną dużą literę i jedną cyfrę"
           redirect_to new_user_path
        end
    end
   def edit
       
   end
   def destroy
        @user.destroy
        flash[:danger] = "Użytkownik usunięty"
        redirect_to users_path
   end
   def update
       if @user.update(user_params)
        flash[:success] = "Konto #{@user.username} edytowane!"
        redirect_to root_path
        else
           render 'edit' 
       end
   end
    def index
        @users = User.paginate(page: params[:page], per_page: 20)
    end
    def getadmin
        @user = User.find(params[:id])
        @user.admin = true
        @user.save
        flash[:success] = "Udało się"
        redirect_to users_path
    end
    def show
       @opinions = @user.opinions
    end
   private
   def user_params
      params.require(:user).permit(:username, :email, :password) 
   end
   def set_user
       begin
        @user = User.find(params[:id])
       rescue
        flash[:danger] = "Coś sknociłeś"
        redirect_to root_path
       end
   end
   def require_same_user
    if current_user != @user
        flash[:danger] = "Możesz edytować tylko swoje konto"
        redirect_to root_path
    end
   end
    def require_admin
        if logged_in? and !current_user.admin?
            flash[:danger] = "Tylko admin może zrobić coś takiego"
            redirect_to root_path
        end
    end
end