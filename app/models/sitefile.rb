class Sitefile < ActiveRecord::Base

  belongs_to :board
  belongs_to :user

  mount_uploader :sitefile, SitefileUploader

  validates :stub, uniqueness: true

  before_validation :set_stub

  def as_json
    {
      id: self.stub,
      url: self.sitefile.url,
      url640: self.sitefile.url,
      url1024: self.sitefile.url,
      createdAt: self.created_at,
    }
  end

protected

  def set_stub
    self.stub ||= SecureRandom.hex.downcase
  end

end
