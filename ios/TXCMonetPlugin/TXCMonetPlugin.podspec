
Pod::Spec.new do |s|
  s.name             = 'TXCMonetPlugin'
  s.version          = '1.2.0'
  s.summary          = 'TUI超分SDK.'
  s.description      = <<-DESC
  TUI超分SDK.
                       DESC

  s.homepage         = 'https://github.com/LiteAVSDK/Player_iOS'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = 'tencent video cloud'
  s.source           = { :git => '', :tag => s.version.to_s }
  s.ios.deployment_target = '9.0'
  s.static_framework = true
  s.libraries = 'sqlite3', 'z'
  s.pod_target_xcconfig = { 'OTHER_LDFLAGS' => '-lObjC' }
  s.vendored_frameworks = 'SDKProduct/TXCMonetPlugin.xcframework'
  s.resource = ['SDKProduct/TXCMonetPlugin.xcframework/TXCMonetPlugin-Privacy.bundle', 'SDKProduct/TXCMonetPlugin.xcframework/sr_resource.bundle']

end
