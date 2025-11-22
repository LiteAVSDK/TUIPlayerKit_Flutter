
Pod::Spec.new do |s|
  s.name             = 'TUIPlayerShortVideo'
  s.version          = '2.1.3'
  s.summary          = 'TUIPlayer短视频SDK.'
  s.description      = <<-DESC
  TUIPlayer短视频SDK.
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
    ss.resource = 'TUIPlayerShortVideo.bundle'
    ss.vendored_frameworks = 'SDKProduct/TUIPlayerShortVideo.xcframework'
    ss.resource = 'SDKProduct/TUIPlayerShortVideo.xcframework/TUIPlayerShortVideo-Privacy.bundle'
    ss.dependency 'Masonry'
    ss.dependency 'SDWebImage'
    ss.dependency 'TUIPlayerCore/Player'
  end
  s.subspec 'Player_Premium' do |ss|
    ss.resource = 'TUIPlayerShortVideo.bundle'
    ss.vendored_frameworks = 'SDKProduct/TUIPlayerShortVideo.xcframework'
    ss.resource = 'SDKProduct/TUIPlayerShortVideo.xcframework/TUIPlayerShortVideo-Privacy.bundle'
    ss.dependency 'Masonry'
    ss.dependency 'SDWebImage'
    ss.dependency 'TUIPlayerCore/Player_Premium'
  end
  s.subspec 'Professional' do |ss|
    ss.resource = 'TUIPlayerShortVideo.bundle'
    ss.vendored_frameworks = 'SDKProduct/TUIPlayerShortVideo.xcframework'
    ss.resource = 'SDKProduct/TUIPlayerShortVideo.xcframework/TUIPlayerShortVideo-Privacy.bundle'
    ss.dependency 'Masonry'
    ss.dependency 'SDWebImage'
    ss.dependency 'TUIPlayerCore/Professional'
  end
  s.subspec 'Professional_player_premium' do |ss|
    ss.resource = 'TUIPlayerShortVideo.bundle'
    ss.vendored_frameworks = 'SDKProduct/TUIPlayerShortVideo.xcframework'
    ss.resource = 'SDKProduct/TUIPlayerShortVideo.xcframework/TUIPlayerShortVideo-Privacy.bundle'
    ss.dependency 'Masonry'
    ss.dependency 'SDWebImage'
    ss.dependency 'TUIPlayerCore/Professional_player_premium'
  end
end
