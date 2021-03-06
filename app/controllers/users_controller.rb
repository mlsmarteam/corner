class UsersController < ApplicationController
  before_action :logged_in_user, only: [:index, :edit, :update, :destroy,
                                        :following, :followers]
  before_action :correct_user,   only: [:edit,:update]
  before_action :admin_user,     only: :destroy
 
  def choose

  end

  def show
  	@user=User.find(params[:id])
    @microposts = @user.microposts.paginate(page: params[:page])
  end

  def new
    flash.now[:info] = "Please insert the basic info about you. We'll contact you inmediatelly."
    if params[:type]=='person'
      @user=User.new
      @user.person_user=true
    elsif params[:type]=='company'
      @user=User.new
      @user.company_user=true
    else
      redirect_to choose_url
    end
  end
      
  

  def create
  @user = User.new(user_params)
  if @user.save
    @user.send_activation_email
    flash[:info] = "Please check your email to activate your account."
    redirect_to root_url
  else
    render 'new'
  end
  end

  def edit
    @user=User.find(params[:id])
  end

  def update
    @user = User.find(params[:id])
    if @user.update_attributes(user_params)
      flash[:success] = "Profile updated"
      redirect_to @user
    else
      render 'edit'
    end
  end

  def index
    @users = User.paginate(page: params[:page])
  end

  def destroy
    User.find(params[:id]).destroy
    flash[:success] = "User deleted"
    redirect_to users_url
  end

  def following
    @title = "Following"
    @user  = User.find(params[:id])
    @users = @user.following.paginate(page: params[:page])
    render 'show_follow'
  end

  def followers
    @title = "Followers"
    @user  = User.find(params[:id])
    @users = @user.followers.paginate(page: params[:page])
    render 'show_follow'
  end

  def fields
    @title  = 'Fields'
    @user   = User.find(params[:id])
    @fields = @user.fields.paginate(page:params[:page]) 
    render 'show_field'
  end



  private
    def user_params
      params.require(:user).permit(:name, :email, :password,
                                   :password_confirmation,
                                   :company_user,
                                   :person_user)
    end

    def logged_in_user
      unless logged_in?
        store_location
        flash[:danger] = "Please log in."
        redirect_to login_url
      end
    end

 # Confirms the correct user.
    def correct_user
      @user = User.find(params[:id])
      unless current_user?(@user)
        redirect_to(root_url) 
        flash[:danger] = 'Access not authorized.'
      end
    end

    # Confirms an admin user.
    def admin_user
      redirect_to(root_url) unless current_user.admin?
    end
end
