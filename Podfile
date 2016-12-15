source 'https://github.com/CocoaPods/Specs.git'
platform :ios, '10.0'
use_frameworks!

target 'iMovie' do
    pod 'Alamofire', '~>4.0.0'
    pod 'SnapKit', '~>3.0.1'
    pod 'Moya/RxSwift', git: 'https://github.com/Moya/Moya.git', tag: '8.0.0-beta.1'
    pod 'MonkeyKing', '~> 1.1.0'
    pod 'YYWebImage'
    pod 'GRMustache.swift'
end

post_install do |installer|
    installer.pods_project.targets.each do |target|
        target.build_configurations.each do |config|
            config.build_settings['SWIFT_VERSION'] = ‘3.0’
        end
    end
end
