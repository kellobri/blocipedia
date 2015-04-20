class CollaboratorsController < ApplicationController
	
	def new
		@collaborator = Collaborator.new
    	authorize @collaborator
	end

	def create
		collaborator = Collaborator.new(params.require(:collaborator).permit(:email, :wiki_id, :user_id))
		user = User.find_by_email(params[:collaborator][:email])
		@wiki = Wiki.find(params[:collaborator][:wiki_id])
		collaborator.assign_attributes({ :email => params["email"], :wiki_id => @wiki.id, :user_id => user.id })

		authorize collaborator
		if collaborator.save
			#Email the new collaborator
			flash[:notice] = "A new collaborator has been added."
  			redirect_to @wiki
		else
			flash[:error] = "There was an error adding that collaborator. Please try again."
  			render :new
		end
	end

	def destroy
		clb = Collaborator.find(params[:id])
    	authorize clb
		if clb.destroy
			flash[:notice] = "Your collaborator has been removed."
			redirect_to root_url
		else
			flash[:error] = "There was an error removing this collaborator."
			redirect_to root_url
		end
	end

end
