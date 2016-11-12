class User < ActiveRecord::Base
  # before_create :generate_authentication_token
  acts_as_token_authenticatable

  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  has_many :ink_usages
  belongs_to :role

  scope :for_form_selection, lambda {
    joins(:role).where(roles: { name: "operator" })
  }

  def self.assign_all_users_authentication_token(new_token = nil)
    self.all.each { |user| user.update_attributes(authentication_token: Devise.friendly_token) if (new_token || self.authentication_token.blank?) }
  end

  # def generate_authentication_token
  #   self.authentication_token = Devise.friendly_token
  # end

  def superadmin    #all admin roles need to include this method.
    role.name == "admin"
  end

  def io_admin
    superadmin || role.name == "io_admin"
  end
end
