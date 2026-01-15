require_relative "boot"
require "rails/all"

Bundler.require(*Rails.groups)

module HotelBooking
  class Application < Rails::Application
    config.load_defaults 7.0
    config.api_only = false
    config.middleware.use Rack::Cors do
      allow do
        origins '*'
        resource '*', headers: :any, methods: [:get, :post, :put, :patch, :delete]
      end
    end
  end
end
