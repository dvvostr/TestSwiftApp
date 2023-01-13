source 'https://github.com/CocoaPods/Specs.git'
platform:ios, '15.0'

use_frameworks!
inhibit_all_warnings!

def common_pods
  use_frameworks!
  pod 'Alamofire'
#  pod 'Nuke', '~> 7.6'
  pod 'Nuke'
end


target 'TestSwiftApp' do
  project 'TestSwiftApp.xcodeproj'
  workspace 'TestSwiftApp.xcworkspace'
  common_pods
end

