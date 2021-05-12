class PrototypesController < ApplicationController

  before_action :configure_permitted_parameters, if: :devise_controller?

  #before_action :configure_permitted_parameters, if: :devise_controller?
  before_action :move_to_index,except: [:index, :show, ]

 
  def index
    @prototypes = Prototype.includes(:user).order("created_at DESC")
  end
  

  def new
    @prototype = Prototype.new
  end 


  def create  
    #_tableend
    #Prototype.create(prototype_params)

    @prototype = Prototype.new(prototype_params)
    
    if @prototype.save
      redirect_to root_path
    else
      render partial: "form"
    end

  end

  def show
    @prototype = Prototype.find(params[:id])#.includes(:user)
    @comment = Comment.new
    @comments = @prototype.comment.includes(:user)
  end

  def edit
    @prototype = Prototype.find(params[:id])

    unless user_signed_in?
      redirect_to action: :index
    end

  end

  def update
    @prototype = Prototype.find(params[:id])
    @prototype.update(prototype_params)

    if @prototype.save
      redirect_to prototype_path(@prototype)
    else
      render partial: "form"
    end
  end


  def destroy
    @prototype = Prototype.find(params[:id])
    if @prototype.destroy
      redirect_to root_path
     else
      render partial: "form"
    end
  end

  
  def move_to_index
    unless user_signed_in?
      redirect_to  '/users/sign_in'
    end
  end

  def move_to_index
     user_signed_in?
      redirect_to  action: :index
    end
  
 

  
    private
    def configure_permitted_parameters
      devise_parameter_sanitizer.permit(:sign_up, keys: [:name])
    end

    private
   def prototype_params
   params.require(:prototype).permit(:title, :catch_copy, :concept, :image ).merge(user_id: current_user.id)
   end



end

