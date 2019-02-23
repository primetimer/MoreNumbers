#
# Be sure to run `pod lib lint MoreNumbers.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see https://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = 'MoreNumbers'
  s.version          = '0.1.0'
  s.summary          = 'A short description of MoreNumbers.'

# This description is used to generate tags and improve search results.
#   * Think: What does it do? Why did you write it? What is the focus?
#   * Try to keep it short, snappy and to the point.
#   * Write the description between the DESC delimiters below.
#   * Finally, don't worry about the indent, CocoaPods strips it!

  s.description      = <<-DESC
TODO: Add long description of the pod here.
                       DESC
                       s.homepage         = 'https://github.com/primetimer/MoreNumbers'
                       # s.screenshots     = 'www.example.com/screenshots_1', 'www.example.com/screenshots_2'
                       s.license          = { :type => 'MIT', :file => 'LICENSE' }
                       s.author           = { 'primetimer' => 'primetimertime@gmail.com' }
                       s.source           = { :git => 'https://github.com/primetimer/MoreNumbers.git', :tag => s.version.to_s }
                       # s.social_media_url = 'https://twitter.com/<TWITTER_USERNAME>'
                       
                       s.platforms = { :ios => "8.0", :osx => "10.7", :watchos => "2.0", :tvos => "9.0" }
                       #s.ios.deployment_target = '8.0'
                       
                       s.dependency 'BigInt'
                       s.dependency 'PrimeFactors'
                       
                       s.source_files = "MoreNumbers/**/*.{swift}"
                       
                       # 9
                       s.resources = "MoreNumbers/**/*.{png,jpeg,jpg,storyboard,xib,xcassets}"

  # s.resource_bundles = {
  #   'MoreNumbers' => ['MoreNumbers/Assets/*.png']
  # }

  # s.public_header_files = 'Pod/Classes/**/*.h'
  # s.frameworks = 'UIKit', 'MapKit'
  # s.dependency 'AFNetworking', '~> 2.3'
end
