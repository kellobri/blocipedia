class WikiPolicy < ApplicationPolicy


	def show?
		record.privatewiki == false || record.collaborators.exists?(user_id: user.id) || (record.user == user && (user.premium? || user.admin?))
	end

	def destroy?
    	user.present? && (record.user == user || user.admin?)
  	end

  	class Scope
  		attr_reader :user, :scope

  		def initialize(user, scope)
  			@user = user
  			@scope = scope
  		end

  		def resolve
  			wikis = []
  			if user.role == 'admin'
  				wikis = scope.all
  			else
  				all_wikis = scope.all
  				all_wikis.each do |wiki|
  					if wiki.privatewiki == false || wiki.user == user && user.premium? || wiki.collaborators.exists?(user_id: user.id)
  						wikis << wiki
  					end
  				end
  			end
  			wikis
  		end
  	end
end