
Pod::Spec.new do |s|
  s.name             = 'tsrClient'
  s.version          = '1.2.0'
  s.summary          = 'TUI超分SDK client.'
  s.description      = <<-DESC
  TUI超分SDK client.
                       DESC

  s.homepage         = 'https://github.com/LiteAVSDK/Player_iOS'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = 'tencent video cloud'
  s.source           = { :git => '', :tag => s.version.to_s }
  s.ios.deployment_target = '9.0'
  s.static_framework = true
  s.libraries = 'sqlite3', 'z'
  s.pod_target_xcconfig = { 'OTHER_LDFLAGS' => '-lObjC' }
  s.vendored_frameworks = 'SDKProduct/tsr_client.framework'

end
