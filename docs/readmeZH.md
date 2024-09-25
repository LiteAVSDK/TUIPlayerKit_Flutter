## 组件简介

FTUIPlayerKit Flutter Plugin 是基于原生组件 [TUIPlayerKit](https://cloud.tencent.com/document/product/881/96685) 封装的 flutter 版本 TUI 短视频组件，支持视频极速首帧和流畅滑动，提供优质播放体验的短视频组件。

## 集成步骤

### 环境准备

- Android 系统最低版本要求：Android SDK  >= 21
- IOS 系统最低版本要求：iOS version >= 12
- Flutter SDK 版本：>= 3.3.0

### 播放器高级版License 配置

TUI 短视频属于播放器高级能力，需要使用移动端播放器高级版 License。

播放器高级版 License 申请指引如下：

- 腾讯云中国站客户：

使用 TUIPlayer Kit 组件需要使用移动端播放器高级版 License，您可参见 [移动端播放器 License]() 指引来获取。若您已获取对应 License，可前往 [腾讯云视立方控制台 > License 管理 > 移动端 License](https://console.cloud.tencent.com/vcube/mobile) 获取对应 LicenseURL 和 LicenseKey。如果没有申请移动端播放器高级版 License，将会出现视频播放失败、黑屏等现象。

- 腾讯云国际站客户：

使用 TUIPlayer Kit 组件需要使用移动端播放器高级版 License，您可参见 [移动端播放器 License](https://www.tencentcloud.com/document/product/266/51098#mobilelicense) 指引来获取。若您已获取对应 License，可前往 [云点播控制台 > License 管理 > 移动端 License](https://console.tencentcloud.com/vod/license) 获取对应 LicenseURL 和 LicenseKey。如果没有申请移动端播放器高级版 License，将会出现视频播放失败、黑屏等现象。

获取对应 LicenseURL 和 LicenseKey后，可以通过下面实例代码配置 Liecense：

```dart
FTUIPlayerConfig config = FTUIPlayerConfig(
    licenseUrl: LICENSE_URL,
    licenseKey: LICENSE_KEY);
FTUIPlayerKitPlugin.setTUIPlayerConfig(config);
```

### Native 层依赖 SDK 更新和配置

#### Android 端

Android 端依赖原生 TUIPlayerKit 的本地aar，最新正式版可在 [Android TUIPlayerKit](https://cloud.tencent.com/document/product/881/96685) 进行下载。
于 `./android/libs` 目录中进行替换

#### iOS 端

IOS 端依赖原生 TUIPlayerKit 的本地xcFramework，最新正式版可在 [IOS TUIPlayerKit](https://cloud.tencent.com/document/product/881/96686) 进行下载。
于 `./ios/` 目录中进行替换

*此外还需要在自身 ios 项目中进行本地 podspec 引入*
在自身项目 podfile 中的主要 Target 下，添加如下 pod 依赖

```text
  # :path must replace to your sdk's path
  pod 'TUIPlayerShortVideo/Player_Premium' ,:path => '../../ios/TUIPlayerShortVideoSDK/'
  pod 'TUIPlayerCore/Player_Premium' ,:path => '../../ios/TUIPlayerCoreSDK/'
```

*path路径需要替换为您下载的 TUIPlayerKit IOS SDK 所在的目录*

## 使用指引

1. 创建 TUI 短视频对象

```dart
FTUIPlayerShortController _shortPlayerController = FTUIPlayerShortController();
```

2. 加载数据

```dart
_shortPlayerController.setModels(sources);
```

加载数据之后，sdk 内会对视频资源做预处理操作

3. 根据项目需求设置点播策略

```dart
_shortPlayerController.setVodStrategy(FTUIPlayerVodStrategy());
```

4. 在 PageView 或者其他Page 组件中，集成绑定和预创建操作

页面创建示例代码：
```dart
itemBuilder: (context, index) {
            // Prevent duplicate creation
            WeakReference<ShortVodItemControlView>? cacheView = _playerViews[index];
            ShortVodItemControlView itemControlView;
            if (null == cacheView || null == cacheView.target) {
              FTUIPlayerView playerView = FTUIPlayerView();
              itemControlView = ShortVodItemControlView(playerView, sources[index]);
              _playerViews[index] = WeakReference(itemControlView);
            } else {
              itemControlView = cacheView.target!;
            }
            if (_isSetModeled && index == 0) {
              _isSetModeled = false;
              onPageChanged(index);
            } else {
              _shortPlayerController.preCreateVodPlayer(itemControlView.playerView, index);
            }
            return itemControlView;
          })),
```

页面发生变动示例代码：
```dart
void onPageChanged(int index) async {
    ShortVodItemControlView itemControlView = getFTUIPlayerView(index);
    _currentVodController = await _shortPlayerController.bindVodPlayer(itemControlView.playerView, index);
    itemControlView.playerController = _currentVodController;
    // start play after binding
    await _shortPlayerController.startCurrent();
}
```

## 接口描述

### FTUIPlayerKitPlugin

#### setTUIPlayerConfig

配置当前 TUI 短视频所需要的 license，以及配置是否开启和关闭 TUI 短视频相关的日志打印。

示例：
```dart
FTUIPlayerConfig config = FTUIPlayerConfig(
    licenseUrl: LICENSE_URL,
    licenseKey: LICENSE_KEY);
FTUIPlayerKitPlugin.setTUIPlayerConfig(config);
```

### FTUIPlayerShortController

#### setModels

填充数据接口，使用该接口会清空数据并设置当前传入的数据

示例：
```dart
_playerController.setModels(dataList);
```

返回值：
0 ：无错误
100100 ：鉴权失败

#### appendModels

追加数据接口，用于给当前 TUI 视频列表追加数据

示例：
```dart
 _playerController.appendModels(dataList);
```

返回值：
0 ：无错误
100100 ：鉴权失败

#### setVodStrategy

设置 TUI 短视频点播策略。
目前提供的配置含义如下:

| name         | type | desc                                             |
|--------------|------|--------------------------------------------------|
| preloadCount | int  | 最大预下载并发数量，不建议设置太大，会影响当前视频播放的网速。                  |
| preDownloadSize | double | 预下载大小，不建议设置太大，尽快让完成预下载，单位:MB。                    |
| preloadBufferSizeInMB | double | 最大预播放缓冲大小，大小不能超过preDownloadSize,否则预下载缓存会失效，单位:MB |
| maxBufferSize | double | 播放过程中的最大缓冲大小，单位:MB                               |
| preferredResolution | int  | 视频播放偏好分辨率                                        |
| progressInterval | int  | 视频进度回调间隔，默认 500毫秒，单位:ms                          |
| renderMode | int  | 点播视频平铺模式，0 代表铺满容器，1 代表跟随视频比例调整                   |

示例
```dart
_playerController.setVodStrategy(FTUIPlayerVodStrategy());
```

#### bindVodPlayer

绑定当前页面，绑定当前页面后，将会获得对页面播放器的控制对象，播放器也会处于即将播放状态

示例：
```dart
TUIVodPlayerController vodController = await _shortPlayerController.bindVodPlayer(itemControlView.playerView, index);
```

#### preCreateVodPlayer

预创建播放器，预创建的播放器会提前预加载视频，并在加载成功后将首帧画面渲染到预创建的纹理上，后续在使用bindVodPlayer的时候，会极大提升起播速度

示例：
```dart
_shortPlayerController.preCreateVodPlayer(itemControlView.playerView, index);
```

#### startCurrent

将当前正在绑定的视频启动播放

示例：
```dart
await _shortPlayerController.startCurrent();
```

返回值：
0 ：无错误
100100 ：鉴权失败

#### release

释放当前 TUI 短视频控制对象.

**释放之后的FTUIPlayerShortController将无法继续使用**

示例：
```dart
_shortPlayerController.release();
```

### TUIVodPlayerController

#### startPlay

播放指定视频源

示例：
```dart
_currentVodController.startPlay(souce);
```

#### pause

暂停视频

示例：
```dart
_currentVodController.pause();
```

#### resume

续播视频

示例：
```dart
_currentVodController.resume();
```

#### setRate

设置当前视频播放速率

示例：
```dart
_currentVodController.setRate(1.0);
```

#### setMute

设置当前视频是否静音播放

示例：
```dart
_currentVodController.setMute(true);
```

#### seekTo

将当前视频的播放进度跳跃到指定位置，单位：秒，传递浮点类型参数

示例：
```dart
_currentVodController.seekTo(1.0);
```

#### getDuration

获得当前正在播放视频的总时长，单位：秒

示例：
```dart
double videoDuration = await _currentVodController.getDuration();
```

#### getCurrentPlayTime

获得当前正在播放视频的播放进度，单位：秒

示例：
```dart
double curPlayTime = await _currentVodController.getCurrentPlayTime();
```

#### isPlaying

当前视频是否处于播放状态

示例：
```dart
double curPlayTime = await _currentVodController.isPlaying();
```

#### addListener

添加播放器事件监听

示例：
```dart
playerController?.addListener(FTUIVodControlListener(
    onVodPlayerEvent: (event) {
        // player event callback, for related constants, please refer to TXVodPlayEvent.
        int eventCode = event[TXVodPlayEvent.EVT_EVENT];
    },
    onVodControllerBind: () {
        // slide to the current video
    },
    onVodControllerUnBind: () {
        // the current video has been swiped away; you can perform some resource release operations.
    }
));
```

#### removeListener

移除播放器事件监听

示例：
```dart
widget.playerController?.removeListener(listener);
```

#### clearListener

清空播放器事件监听

示例：
```dart
widget.playerController?.clearListener();
```



