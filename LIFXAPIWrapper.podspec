Pod::Spec.new do |s|
  s.name             = "LIFXAPIWrapper"
  s.version          = "0.0.4"
  s.summary          = "An Objective-C wrapper around the LIFX HTTP API"
  s.homepage         = "https://github.com/DCMaxxx/LIFXAPIWrapper"
  s.license          = 'MIT'
  s.author           = { "Maxime de Chalendar" => "maxime.dechalendar@me.com" }
  s.source           = { :git => "https://github.com/DCMaxxx/LIFXAPIWrapper.git", :tag => s.version.to_s }
  s.social_media_url = 'https://twitter.com/DCMaxxx'

  s.platform     = :ios, '7.0'
  s.requires_arc = true

  s.source_files = 'Pod/Classes/**/*'
  s.resource_bundles = {
    'LIFXAPIWrapper' => ['Pod/Assets/*.png']
  }

  s.public_header_files = 'Pod/Classes/**/*.h'

  s.frameworks = 'UIKit'
  s.dependency 'AFNetworking', '~> 2.3'
end
