class Board < ActiveRecord::Base

  belongs_to :user
  has_many :sitefiles, dependent: :destroy

  validates :stub, uniqueness: true

  before_validation :set_stub

  def to_param
    self.stub
  end

protected

  def set_stub
    self.stub ||= SecureRandom.hex[0..6].downcase
  end

end
