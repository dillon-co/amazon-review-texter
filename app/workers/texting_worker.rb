class TextWorker
  include Sidekiq::Worker
  def perform(message_id)
    Message.find(message_id).send_message
  end  
end  