
Pod::Spec.new do |s|
  s.name             = 'TUIPlayerCore'
  s.version          = '2.1.3'
  s.summary          = 'TUIPlayerCore SDK.'
  s.description      = <<-DESC
  TUIPlayerCore SDK.
                       DESC

  s.homepage         = 'https://github.com/LiteAVSDK/Player_iOS'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = 'tencent video cloud'
  s.source           = { :git => '', :tag => s.version.to_s }
  s.ios.deployment_target = '9.0'
  s.static_framework = true
  s.libraries = 'sqlite3', 'z'
  s.pod_target_xcconfig = { 'OTHER_LDFLAGS' => '-lObjC' }
  s.default_subspec = 'Player'
  s.subspec 'Player' do |ss|
    ss.vendored_frameworks = 'SDKProduct/TUIPlayerCore.xcframework'
    ss.resource = 'SDKProduct/TUIPlayerCore.xcframework/TUIPlayerCore-Privacy.bundle'
    ss.dependency 'TXLiteAVSDK_Player','>= 11.4.0'
  end
  s.subspec 'Player_Premium' do |ss|
    ss.vendored_frameworks = 'SDKProduct/TUIPlayerCore.xcframework'
    ss.resource = 'SDKProduct/TUIPlayerCore.xcframework/TUIPlayerCore-Privacy.bundle'
    ss.dependency 'TXLiteAVSDK_Player_Premium','>= 11.4.0'
  end
  s.subspec 'Professional' do |ss|
    ss.vendored_frameworks = 'SDKProduct/TUIPlayerCore.xcframework'
    ss.resource = 'SDKProduct/TUIPlayerCore.xcframework/TUIPlayerCore-Privacy.bundle'
    ss.dependency 'TXLiteAVSDK_Professional','>= 11.4.0'
  end
  s.subspec 'Professional_player_premium' do |ss|
    ss.source_files = 'TUIPlayerCore/Classes/Core/**/*'
    ss.public_header_files = 'TUIPlayerCore/Classes/Core/Public/**/*'
    ss.resource = 'TUIPlayerCore/Assets/TUIPlayerCore-Privacy.bundle'
    ss.dependency 'TXLiteAVSDK_Professional_Player_Premium'
  end
end
