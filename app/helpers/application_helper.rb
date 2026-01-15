module ApplicationHelper
  # Return either the local asset path for +relative_path+ if it exists,
  # otherwise return the provided +fallback_url+.
  # Usage: asset_or_remote("rooms/room-1.jpg", "https://.../fallback.jpg")
  def asset_or_remote(relative_path, fallback_url)
    # Check public folder first
    if File.exist?(Rails.root.join('public', relative_path))
      return "/#{relative_path}"
    end

    # Try sprockets manifest (production compiled assets)
    if defined?(Rails) && Rails.application.respond_to?(:assets_manifest)
      manifest = Rails.application.assets_manifest
      if manifest && manifest.assets && manifest.assets[relative_path]
        return asset_path(relative_path)
      end
    end

    # Try runtime Sprockets (development)
    if defined?(Rails) && Rails.application.respond_to?(:assets) && Rails.application.assets
      return asset_path(relative_path) if Rails.application.assets.find_asset(relative_path)
    end

    # Fallback to remote URL
    fallback_url
  rescue => _e
    fallback_url
  end
  
  # Prefer jpg (actual photos), then .png.svg (professional UI), then svg, otherwise return fallback remote URL for a room image
  def room_image_path(room)
    png_svg = "room-#{room.id}.png.svg"
    jpg = "room-#{room.id}.jpg"
    svg = "room-#{room.id}.svg"
    
    # Check for jpg first (actual photos from assets)
    if File.exist?(Rails.root.join('public','rooms', jpg)) || File.exist?(Rails.root.join('public','assets', "rooms/#{jpg}"))
      return "/rooms/#{jpg}" if File.exist?(Rails.root.join('public','rooms', jpg))
      return asset_path("rooms/#{jpg}")
    end

    # Check for .png.svg (professional UI images)
    if File.exist?(Rails.root.join('public','rooms', png_svg))
      return "/rooms/#{png_svg}"
    end

    # Check for svg
    if File.exist?(Rails.root.join('public','rooms', svg)) || File.exist?(Rails.root.join('app','assets','images','rooms', svg)) || File.exist?(Rails.root.join('public','assets', "rooms/#{svg}"))
      return "/rooms/#{svg}" if File.exist?(Rails.root.join('public','rooms', svg))
      return asset_path("rooms/#{svg}")
    end

    # Try asset pipeline
    if Rails.respond_to?(:application) && Rails.application.respond_to?(:assets) && Rails.application.assets
      return asset_path("rooms/#{jpg}") if Rails.application.assets.find_asset("rooms/#{jpg}")
      return asset_path("rooms/#{svg}") if Rails.application.assets.find_asset("rooms/#{svg}")
    end

    # Fallback to unsplash
    "https://source.unsplash.com/featured/?hotel,room,#{room.id}"
  rescue => _e
    "https://source.unsplash.com/featured/?hotel,room,#{room.id}"
  end
end
