import 'package:flutter_test/flutter_test.dart';
import 'package:plugin_platform_interface/plugin_platform_interface.dart';

class MockFtuiplayerKitPlatform
    with MockPlatformInterfaceMixin {

  @override
  Future<String?> getPlatformVersion() => Future.value('42');
}

void main() {
  // final FtuiplayerKitPlatform initialPlatform = FtuiplayerKitPlatform.instance;
  //
  // test('$MethodChannelFtuiplayerKit is the default instance', () {
  //   expect(initialPlatform, isInstanceOf<MethodChannelFtuiplayerKit>());
  // });
  //
  // test('getPlatformVersion', () async {
  //   FTUIPlayerKitPlugin ftuiplayerKitPlugin = FTUIPlayerKitPlugin();
  //   MockFtuiplayerKitPlatform fakePlatform = MockFtuiplayerKitPlatform();
  //   FtuiplayerKitPlatform.instance = fakePlatform;
  //
  //   expect(await ftuiplayerKitPlugin.getPlatformVersion(), '42');
  // });
}
