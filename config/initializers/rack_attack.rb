class Rack::Attack
  Rack::Attack.cache.store = ActiveSupport::Cache::MemoryStore.new

  throttle('requests by ip', limit: 100, period: 60) do |request|
    Rails.logger.error("Rack::Attack Too many requests from IP: #{request.ip}")
    request.ip
  end
end
