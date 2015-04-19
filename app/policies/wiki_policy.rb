class WikiPolicy < ApplicationPolicy


	def show?
		record.privatewiki == false || record.collaborators.where(user_id: user.id).exists? || (record.user == user && (user.premium? || user.admin?))
	end

	def destroy?
    	user.present? && (record.user == user || user.admin?)
  	end

end