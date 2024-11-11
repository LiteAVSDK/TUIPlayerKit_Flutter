#
# To learn more about a Podspec see http://guides.cocoapods.org/syntax/podspec.html.
# Run `pod lib lint ftuiplayer_kit.podspec` to validate before publishing.
#
Pod::Spec.new do |s|
  s.name             = 'ftuiplayer_kit'
  s.version          = '1.0.1'
  s.summary          = 'TUIPlayerKit For Flutter'
  s.description      = <<-DESC
TUIPlayerKit For Flutter
                       DESC
  s.homepage         = 'http://example.com'
  s.license          = { :file => '../LICENSE' }
  s.author           = { 'Your Company' => 'email@example.com' }
  s.source           = { :path => '.' }
  s.source_files = 'Classes/**/*'
  s.dependency 'Flutter'
  s.platform = :ios, '12.0'
  s.static_framework = true

  s.dependency 'TXLiteAVSDK_Player_Premium'
#  s.dependency 'TUIPlayerCoreSDK', :path => './TUIPlayerCoreSDK/TUIPlayerCore'
#  s.dependency 'TUIPlayerShortVideoSDK', :path => './TUIPlayerCoreSDK/TUIPlayerShortVideo'

  s.dependency 'TUIPlayerCore/Player_Premium'
  s.dependency 'TUIPlayerShortVideo/Player_Premium'
  s.dependency 'TXCMonetPlugin'
  s.dependency 'tsrClient'

#  s.vendored_frameworks = './TUIPlayerCoreSDK/SDKProduct/TUIPlayerCore.xcframework'
#  s.vendored_frameworks = './TUIPlayerShortVideoSDK/SDKProduct/TUIPlayerShortVideo.xcframework'
  
  # Flutter.framework does not contain a i386 slice.
  s.pod_target_xcconfig = { 'DEFINES_MODULE' => 'YES', 'EXCLUDED_ARCHS[sdk=iphonesimulator*]' => 'i386' }
  s.swift_version = '5.0'
end
