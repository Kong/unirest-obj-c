Pod::Spec.new do |s|
  s.name         = "Unirest-APIMATIC"
  s.version      = "1.1.4"
  s.summary      = "Unirest is a set of lightweight HTTP libraries available in multiple languages."
  s.homepage     = "https://github.com/zeeshanejaz/unirest-obj-c"
  s.license      = { :type => 'MIT', :file => 'LICENSE' }
  s.author       = { "Zeeshan Ejaz" => "zeeshan@apimatic.io" }
  s.platform     = :ios, '5.0'
  s.source       = { :git => "https://github.com/zeeshanejaz/unirest-obj-c", :tag => "1.1.4" }
  s.source_files  = 'Unirest/*.{h,m}', 'Unirest/**/*.{h,m}'
  s.header_mappings_dir = 'Unirest'
  s.requires_arc = true
end
