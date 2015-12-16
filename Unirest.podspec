Pod::Spec.new do |s|
  s.name         = "Unirest"
  s.version      = "1.1.4"
  s.summary      = "Simplified, lightweight HTTP client library"
  s.homepage     = "http://github.com/mashape/unirest-obj-c"
  s.license      = { :type => 'MIT', :file => 'LICENSE' }
  s.author       = { "Mashape" => "opensource@mashape.com" }
  s.platform     = :ios, '5.0'
  s.source       = { :git => "https://github.com/Mashape/unirest-obj-c.git", :tag => "1.1.4" }
  s.source_files  = 'Unirest/*.{h,m}'
  s.header_mappings_dir = 'Unirest'
  s.requires_arc = true
end
