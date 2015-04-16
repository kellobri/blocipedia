class UserPolicy < ApplicationPolicy

	def wikis?
    	user.present? && (record.id == user.id || user.admin?)
  	end

end