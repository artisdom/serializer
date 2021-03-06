require 'rails_helper'

RSpec.describe Techcrunch do
  before(:all) do
    @ts = Techcrunch::TechcrunchScraper.new
  end

  it 'should return items' do
    allow_any_instance_of(Techcrunch::TechcrunchScraper).to receive(:word_count)
      .and_return(0)
    VCR.use_cassette('techcrunch') do
      items = @ts.items
      expect(items).to_not be_nil
      keys = [:title, :url, :word_count, :comment_url, :source, :topped]
      expect(items.sample.keys - keys).to be_empty
    end
  end
end
