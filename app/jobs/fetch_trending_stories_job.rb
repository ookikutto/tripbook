class FetchTrendingStoriesJob < ApplicationJob
  queue_as :default

  def perform
    TrendingStory.fetch_to_db
  end
end
