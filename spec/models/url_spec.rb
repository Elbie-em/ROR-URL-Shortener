require 'rails_helper'

RSpec.describe Url, type: :model do
  subject { build(:url) }

  it { should belong_to(:user).optional }
  it { should validate_presence_of(:original_url) }
  it { should validate_numericality_of(:visit_count).is_greater_than_or_equal_to(0) }
  it do
    should allow_values(
      'http://example.com',
      'https://example.com'
    ).for(:original_url)
  end
  it { should_not allow_value('example.com').for(:original_url) }

  # Replace the presence validation tests for short_url and visit_count with the following tests
  describe "short_url and visit_count" do
    it "sets short_url and visit_count after validation" do
      url = build(:url, short_url: nil, visit_count: nil)
      expect(url).to be_valid
      expect(url.short_url).not_to be_nil
      expect(url.visit_count).not_to be_nil
    end
  end
end
