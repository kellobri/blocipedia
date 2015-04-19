class Wiki < ActiveRecord::Base
  belongs_to :user
  has_many :collaborators

  scope :visible_to, -> (user) { user.nil? ? where(privatewiki: false) :  where(["privatewiki = ? OR user_id = ?", false, user.id]) }

  after_initialize :init

  def evolve_time
		self.update_column(:last_update_at, Time.zone.now)
		#UserMailer.send_evolve_notice_mail(self).deliver
  end

  def init
		self.privatewiki ||= false
  end

  def public_wiki?
  		privatewiki == false
  end

end
