desc "Fetch the most recent trending stories to the database"
task :fetch_trending_stories => :environment do
  puts "Fetching trending stories..."
  FetchTrendingStoriesJob.new.perform
  puts "done."
end
