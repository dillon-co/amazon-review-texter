class TestWorker
  include Sidekiq::Worker
  def perform
    puts "Working. :)"  
  end
end    