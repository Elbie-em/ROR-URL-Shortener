class Url < ApplicationRecord
  before_validation :generate_short_url, on: :create
  before_validation :set_visit_count, on: :create

  belongs_to :user, optional: true

  validates :original_url, presence: true, format: URI::regexp(%w[http https])
  validates :short_url, presence: true, uniqueness: true
  validates :visit_count, presence: true, numericality: { greater_than_or_equal_to: 0 }

  private

  def generate_short_url
    loop do
      self.short_url = SecureRandom.urlsafe_base64(6)
      puts "Generated short_url: #{short_url}"
      break if unique_short_url?
    end
  end

  def unique_short_url?
   short_url.present? && Url.find_by(short_url: short_url).nil?
  end

  def set_visit_count
    self.visit_count ||= 0
  end

end
