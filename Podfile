source 'https://github.com/CocoaPods/Specs.git'

platform :ios, '9.0'
use_frameworks!
inhibit_all_warnings!

target 'RxMoyaHandyJSONDemo'

pod 'Alamofire'
pod 'Moya/RxSwift'
pod 'HandyJSON'
pod 'RxCocoa'
pod 'Whisper'
pod 'PKHUD'
pod 'PopupDialog'

post_install do |installer|
  installer.pods_project.targets.each do |target|
    target.build_configurations.each do |config|
      config.build_settings['SWIFT_VERSION'] = '3.0'
    end
  end

end
