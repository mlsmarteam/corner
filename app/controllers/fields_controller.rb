class FieldsController < ApplicationController
  before_action :logged_in_user, only:[:index]
  before_action :company_user?, only:[:new,:create,:update,:edit,:destroy]
#  before_action :correct_user,   only: [:edit,:update]
  
  def new
  	@field=Field.new
  	@field.user_id = current_user.id
  end

  def create
  	@field=Field.new(field_params)
  	if @field.save
  		flash[:info] = "Field create successfully."
  		redirect_to root_url
  	else
  		render 'new'
  	end
  end

  def edit
    @field=Field.find(params[:id])
  end

  def update
    @field=Field.find(params[:id])
    if @field.update_attributes(field_params)
      flash[:success] = "Field data updated"
      redirect_to @field
    else
      render 'edit'
    end
  end

  def show
    
    @field=Field.find(params[:id])
    
  end

  def destroy
    Field.find(params[:id]).destroy
    flash[:success] = "Field deleted"
    redirect_to fields_url
  end

  def index
    @fields = Field.paginate(page: params[:page])
  end

  private
  	def field_params
    	params.require(:field).permit(:name,:team_player,:description,
    								  :user_id)
    end

  	def logged_in_user
      unless logged_in?
        store_location
        flash[:danger] = "Please log in."
        redirect_to login_url
      end
    end

    def correct_user
      @user = User.find(params[:id])
      unless current_user?(@user)
        redirect_to(root_url) 
        flash[:danger] = 'Access not authorized.'
      end
    end

  	def company_user
      redirect_to(root_url) unless company_user? || admin_user?
    end
end
