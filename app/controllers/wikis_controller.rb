class WikisController < ApplicationController


  def index
  	@wikis = Wiki.all
    authorize @wikis
  end

  def show
  	@wiki = Wiki.find(params[:id])
  end

  def new
  	@wiki = Wiki.new
    authorize @wiki
  end

  def create
  	@user = current_user
  	@wiki = Wiki.new(params.require(:wiki).permit(:title, :body, :last_update_at))
    authorize @wiki
  	if @wiki.save
      @wiki.user = @user
      @wiki.last_update_at = Time.zone.now
  		flash[:notice] = "A new wiki is born!"
  		redirect_to @wiki
  	else
  		flash[:error] = "There was an error in saving this wiki. Please try again."
  		render :new
  	end
  end

  def edit
  	@wiki = Wiki.find(params[:id])
  end

  def update
  	@wiki = Wiki.find(params[:id])
  	if @wiki.update_attributes(params.require(:wiki).permit(:title, :body, :last_update_at))
  		@wiki.last_update_at = @wiki.evolve_time
  		flash[:notice] = "You have evolved this wiki."
  		redirect_to @wiki
  	else
  		flash[:error] = "There was an error in saving your changes to this wiki. Please try again."
  		render :edit
  	end
  end

  def destroy
  	@wiki = Wiki.find(params[:id])
  	title = @wiki.title
		if @wiki.destroy
			flash[:notice] = "\"#{title}\" was removed from the wiki-net."
			redirect_to wikis_path
		else
			flash[:error] = "There was an error deleting this wiki."
			render :show 
		end
	end

end
