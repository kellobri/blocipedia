class Wiki < ActiveRecord::Base
  belongs_to :user


  def evolve_time
		self.update_column(:last_update_at, Time.zone.now)
		#UserMailer.send_evolve_notice_mail(self).deliver
  end

end
