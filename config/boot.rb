require "pathname"
require "fileutils"

ENV["BUNDLE_GEMFILE"] ||= File.expand_path("../Gemfile", __dir__)
require "bundler/setup"

module Rails
  class Boot
    def run
      load_initializer
    end

    private

    def load_initializer
      require "rails/initializer"
      Rails::Initializer.run(:install, self)
    end
  end
end

require "rails/all"
