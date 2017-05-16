class TrendingStory < ApplicationRecord
  belongs_to :story

  class << self
    def fetch_from_stories(n)
      trendings = Story.all.sort_by{ |story| -story.unique_impression_count }
      trendings = trendings[0..n-1]
    end

    def fetch_to_db
      trendings = TrendingStory.fetch_from_stories 6

      # this batch is the last batch and increase by 1
      batch = TrendingStory.last ? TrendingStory.last.batch + 1 : 0

      # Save to db
      trendings.each do |story|
        TrendingStory.create(batch: batch, story_id: story.id)
      end
    end

    def get
      batch = TrendingStory.last ? TrendingStory.last.batch : 0
      TrendingStory.where(batch: batch).map { |st| Story.find st.story_id }
    end

    def get_ids
      batch = TrendingStory.last ? TrendingStory.last.batch : 0
      TrendingStory.where(batch: batch).map(&:story_id)
    end
  end
end
