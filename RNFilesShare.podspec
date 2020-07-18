require 'json'

Pod::Spec.new do |s|
  package = JSON.parse(File.read(File.join(__dir__, 'package.json')))

  s.name          = "RNFilesShare"
  s.version       = package['version']
  s.summary       = package['description']
  s.authors       = { "BetterMe" => "CodeBetterMe" }
  s.homepage      = "https://github.com/codebetterme/react-native-share#readme"
  s.license       = "MIT"
  s.platforms     = { :ios => "8.0", :tvos => "9.0" }
  s.framework     = 'UIKit'
  s.requires_arc  = true
  s.source        = { :git => "https://github.com/codebetterme/react-native-share.git", :tag => "v#{s.version}" }
  s.source_files  = "ios/**/*.{h,m}"

  s.dependency 'React'
end
