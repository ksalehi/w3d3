class ShortenedUrl < ActiveRecord::Base

  validates :long_url, presence: true
  validates :short_url, uniqueness: true
  validates :user_id, presence: true

  has_many :visits,
    primary_key: :id,
    foreign_key: :shortened_url_id,
    class_name: 'Visit'

  has_many :visitors,
    -> { distinct }, # Proc.new { dictinct }
    through: :visits,
    source: :visitor

  has_one :submitter,
    primary_key: :user_id,
    foreign_key: :id,
    class_name: 'User'

  def self.random_code
    code = nil
    until code
      maybe_code = SecureRandom.urlsafe_base64
      code = maybe_code unless ShortenedUrl.exists?(short_url: maybe_code)
    end
    code
  end

  def self.create_for_user_and_long_url!(user, long_url)
    short_url = ShortenedUrl.random_code
    ShortenedUrl.create!(short_url: short_url, long_url: long_url, user_id: user.id)
  end

  def num_clicks
    self.visits.length
  end

  def num_uniques
    self.visitors.length
  end

  def num_recent_uniques
    Visit.where("created_at >= ? and shortened_url_id = ?", 10.minutes.ago, self.id).
      distinct.
        length
  end
end
