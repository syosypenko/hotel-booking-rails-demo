#!/usr/bin/env ruby
# Generate resized room images from a single source image.
# Usage:
#   ruby bin/generate_room_images.rb [path/to/source.jpg]
# Defaults to: app/assets/images/rooms/source.jpg

begin
  require 'mini_magick'
  require 'fileutils'
rescue LoadError => e
  warn "Missing gem: #{e.message}. Install with: gem install mini_magick"
  exit 1
end

source = ARGV[0] || File.join('app','assets','images','rooms','source.jpg')
dest_dir = File.join('app','assets','images','rooms')

unless File.exist?(source)
  warn "Source image not found: #{source}\nPlace your image at that path and re-run the script."
  exit 1
end

FileUtils.mkdir_p(dest_dir)

sizes = [
  ['room-1.jpg', 1600, 900],
  ['room-2.jpg', 1200, 800],
  ['room-3.jpg', 1024, 768],
  ['room-4.jpg', 800, 600]
]

sizes.each do |name, w, h|
  out = File.join(dest_dir, name)
  img = MiniMagick::Image.open(source)
  img.auto_orient
  img.resize "#{w}x#{h}^"
  img.combine_options do |c|
    c.gravity 'center'
    c.extent "#{w}x#{h}"
  end
  img.quality 85
  img.write out
  puts "Generated #{out} (#{w}x#{h})"
end

puts "Done. Generated #{sizes.size} images in #{dest_dir}"
