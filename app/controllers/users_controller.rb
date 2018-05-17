class UsersController < ApplicationController
    before_action :set_user, only: [:edit, :update, :show, :destroy]
    before_action :require_same_user, only: [:edit, :update]
    before_action :require_admin, only: [:getadmin, :index, :destroy]
    def new
        @user = User.new
    end
    def create
        @user = User.new(user_params)
        #if /^(?=.*\d)(?=.*([a-z]|[A-Z]))([\x20-\x7E]){8,40}$/ ~= params[:password]
            if @user.save
                session[:user_id] = @user.id
                flash[:success] = "Witamy #{@user.username}!"
                redirect_to root_path
            else
               render 'new' 
            end
    end
   def edit
       
   end
   def destroy
       if @user.opinions.exists?
        @user.opinions.destroy_all
       end
       if !@user.admin?
        @user.destroy
        flash[:danger] = "Użytkownik usunięty"
        redirect_to users_path
       else
        flash[:danger] = "Nie możesz usunąć administratora"
        redirect_to users_path
       end
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
        @users = User.where.not(admin: true)
        @users = @users.paginate(page: params[:page], per_page: 10)
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
    def search
        if params[:search]
            @user = User.where(username: "#{params[:search]}")
        else
           flash[:notice] = "Skorzystaj z formularza" 
        end
    end
   def getJSON
      @users = User.all
      if params[:opinions] && params[:opinions] == "true"
        render json: @users.to_json(:only => [ :username, :email, :created_at ], :include => :opinions)
      else
        render json: @users.to_json(:only => [ :username, :email, :created_at ])
      end
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