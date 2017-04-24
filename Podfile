source 'https://github.com/CocoaPods/Specs.git'
inhibit_all_warnings!
use_frameworks!

target :Tinderella do
  platform :osx, '10.12'

  pod 'KeepLayout', :git => "https://github.com/iMartinKiss/KeepLayout.git", :branch => 'non-swift'
  pod 'NSDate+Helper'
  pod 'NSDate-TKExtensions'
  pod 'BlocksKit'
  pod 'PromiseKit', :git => "https://github.com/mxcl/PromiseKit.git"
  pod 'AFNetworking'

  pod 'dyci', :git => "https://github.com/aspcartman/dyci-main.git", :branch => 'osx'

  target :TinderellaTests do
    inherit! :search_paths
  end
end

post_install do |installer|
  installer.pods_project.targets.each do |target|
    target.build_configurations.each do |config|
      config.build_settings['SWIFT_VERSION'] = '3.0'
    end
  end
end
