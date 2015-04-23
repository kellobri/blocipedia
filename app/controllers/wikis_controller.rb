class WikisController < ApplicationController


  def index
  	#@wikis = Wiki.visible_to(current_user)
    #authorize @wikis
    @wikis = policy_scope(Wiki)
  end

  def show
  	@wiki = Wiki.friendly.find(params[:id])
    @collaborators = @wiki.collaborators :include => [:user_id]
    authorize @wiki
  end

  def new
  	@wiki = Wiki.new
    authorize @wiki
  end

  def create
  	@user = current_user
  	@wiki = Wiki.new(params.require(:wiki).permit(:title, :body, :privatewiki))
    @wiki.assign_attributes({ :created_by => @user.name, :last_update_at => Time.zone.now, :user => @user })
    authorize @wiki
  	if @wiki.save
  		flash[:notice] = "A new wiki is born!"
  		redirect_to @wiki
  	else
  		flash[:error] = "There was an error in saving this wiki. Please try again."
  		render :new
  	end
  end

  def edit
  	@wiki = Wiki.friendly.find(params[:id])
    authorize @wiki
  end

  def update
  	@wiki = Wiki.friendly.find(params[:id])
    authorize @wiki
  	if @wiki.update_attributes(params.require(:wiki).permit(:title, :body, :last_update_at, :privatewiki, :collaborators))
  		@wiki.last_update_at = @wiki.evolve_time
  		flash[:notice] = "You have evolved this wiki."
  		redirect_to @wiki
  	else
  		flash[:error] = "There was an error in saving your changes to this wiki. Please try again."
  		render :edit
  	end
  end

  def destroy
  	@wiki = Wiki.friendly.find(params[:id])
  	title = @wiki.title
    authorize @wiki
		if @wiki.destroy
			flash[:notice] = "\"#{title}\" was removed from the wiki-net."
			redirect_to wikis_path
		else
			flash[:error] = "There was an error deleting this wiki."
			render :show 
		end
	end

end
