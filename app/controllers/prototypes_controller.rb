class PrototypesController < ApplicationController
  
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

  before_action :authenticate_user!
  before_action :configure_permitted_parameters, if: :devise_controller?

  before_action :move_to_index,except: [:destroy, :edit, :new, :create]


  def edit
    @prototype = Prototype.find(params[:id])
  end

  def update
    @prototype = Prototype.find(params[:id])
    @prototype.update(prototype_params)

    if @prototype.save
      redirect_to root_path
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

  
    private
    def configure_permitted_parameters
      devise_parameter_sanitizer.permit(:sign_up, keys: [:name])
    end

    private
   def prototype_params
   params.require(:prototype).permit(:title, :catch_copy, :concept, :image ).merge(user_id: current_user.id)
   end

   unless user_signed_in?
    redirect_to action: :index
  end

end

