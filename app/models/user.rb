class User < ActiveRecord::Base
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  has_many :boards

  def name
    self.email.split("@")[0]
  end

  def is_admin?
    self.id == 1
  end

end
