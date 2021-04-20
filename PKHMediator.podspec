#
# Be sure to run `pod lib lint PKHMediator.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see https://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = 'PKHMediator'
  s.version          = '0.1.3'
  s.summary          = '用于解耦模块间通讯'

# This description is used to generate tags and improve search results.
#   * Think: What does it do? Why did you write it? What is the focus?
#   * Try to keep it short, snappy and to the point.
#   * Write the description between the DESC delimiters below.
#   * Finally, don't worry about the indent, CocoaPods strips it!

  s.description      = '用于解耦模块间通讯'

  s.homepage         = 'https://github.com/heavingsand/PKHMediator'
  # s.screenshots     = 'www.example.com/screenshots_1', 'www.example.com/screenshots_2'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'heavingsand' => 'aa943147350@163.com' }
  s.source           = { :git => 'https://github.com/heavingsand/PKHMediator.git', :tag => s.version.to_s }
  # s.social_media_url = 'https://twitter.com/<TWITTER_USERNAME>'

  s.ios.deployment_target = '9.0'

  s.source_files = 'PKHMediator/Classes/**/*'
  s.subspec 'Categary' do |ss|
    ss.source_files = 'PKHMediator/Classes/Categary/*.{h.m}'
  end
  
  # s.resource_bundles = {
  #   'PKHMediator' => ['PKHMediator/Assets/*.png']
  # }

  # s.public_header_files = 'Pod/Classes/**/*.h'
  # s.frameworks = 'UIKit', 'MapKit'
  # s.dependency 'AFNetworking', '~> 2.3'
end
