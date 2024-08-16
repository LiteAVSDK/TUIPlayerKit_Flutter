## Component Introduction

FTUIPlayerKit Flutter Plugin is a Flutter version of the TUI short video component, based on the native component [TUIPlayerKit](https://cloud.tencent.com/document/product/881/96685). It supports ultra-fast first frame display and smooth scrolling, providing a high-quality playback experience for short videos.

## Integration Steps

### Environment Preparation

- Minimum Android system version: Android SDK >= 21
- Minimum iOS system version: iOS version >= 12
- Flutter SDK version: >= 3.3.0

### Player Advanced License Configuration

The TUI short video requires the advanced player license for mobile endpoints.

Here’s how to apply for the advanced player license:

- For Tencent Cloud China customers:

Using the TUIPlayer Kit component requires the advanced player license for mobile endpoints. Please refer to the [mobile player license](#) guide to obtain it. If you have already obtained the corresponding license, you can go to [Tencent Cloud Vcube Console > License Management > Mobile License](https://console.cloud.tencent.com/vcube/mobile) to get the LicenseURL and LicenseKey. If the advanced mobile player license is not applied for, video playback failures and black screens may occur.

- For Tencent Cloud International customers:

Using the TUIPlayer Kit component requires the advanced player license for mobile endpoints. Please refer to the [mobile player license](https://www.tencentcloud.com/document/product/266/51098#mobilelicense) guide to obtain it. If you have already obtained the corresponding license, you can go to [Cloud Video Console > License Management > Mobile License](https://console.tencentcloud.com/vod/license) to get the LicenseURL and LicenseKey. If the advanced mobile player license is not applied for, video playback failures and black screens may occur.

After obtaining the LicenseURL and LicenseKey, you can configure the license using the following example code:

```dart
FTUIPlayerConfig config = FTUIPlayerConfig(
    licenseUrl: LICENSE_URL,
    licenseKey: LICENSE_KEY);
FTUIPlayerKitPlugin.setTUIPlayerConfig(config);
```

### Native Layer SDK Updates and Configuration

#### Android

The Android side depends on the local AAR of the native TUIPlayerKit, and the latest official version can be downloaded from [Android TUIPlayerKit](https://cloud.tencent.com/document/product/881/96685).
Replace it in the `./android/libs` directory.

#### iOS

The iOS side depends on the local XCFramework of the native TUIPlayerKit, and the latest official version can be downloaded from [IOS TUIPlayerKit](https://cloud.tencent.com/document/product/881/96686).
Replace it in the `./ios/` directory.

*In addition, you need to introduce the local podspec in your own iOS project*
Add the following pod dependency under the main target in your project's Podfile:

```text
  # :path must replace to your sdk's path
  pod 'TUIPlayerShortVideo/Player_Premium' ,:path => '../../ios/TUIPlayerShortVideoSDK/'
  pod 'TUIPlayerCore/Player_Premium' ,:path => '../../ios/TUIPlayerCoreSDK/'
```

*The path needs to be replaced with the directory where you downloaded the TUIPlayerKit iOS SDK*

## Usage

1. Create a TUI short video object

```dart
FTUIPlayerShortController _shortPlayerController = FTUIPlayerShortController();
```

2. Load data

```dart
_shortPlayerController.setModels(sources);
```

After loading data, the SDK will preprocess the video resources.

3. Set VOD strategy according to project requirements

```dart
_shortPlayerController.setVodStrategy(FTUIPlayerVodStrategy());
```

4. Integrate binding and pre-creation operations in PageView or other Page components

Example code for page creation:
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
          }),
```

Example code for page change:
```dart
onPageChanged: (index) {
                ShortVodItemControlView itemControlView = getFTUIPlayerView(index);
                _currentVodController = await _shortPlayerController.bindVodPlayer(itemControlView.playerView, index);
                itemControlView.playerController = _currentVodController;
                // start play after binding
                await _shortPlayerController.startCurrent();
              },
```

## Interface Description

### FTUIPlayerKitPlugin

#### setTUIPlayerConfig

Configure the license required for the current TUI short video, as well as whether to enable or disable the printing of logs related to TUI short videos.

Example：
```dart
FTUIPlayerConfig config = FTUIPlayerConfig(
    licenseUrl: LICENSE_URL,
    licenseKey: LICENSE_KEY);
FTUIPlayerKitPlugin.setTUIPlayerConfig(config);
```

### FTUIPlayerController

#### setModels

The interface of filling data, using this interface will clear the data and set the currently passed data.

Example：
```dart
_playerController.setModels(dataList);
```

#### appendModels

Append data interface, used to append data to the current TUI video list.

Example：
```dart
 _playerController.appendModels(dataList);
```

#### setVodStrategy

Set the TUI short video on-demand strategy.
The currently provided configuration meanings are as follows:

| name         | type | desc                                             |
|--------------|------|--------------------------------------------------|
| preloadCount | int  | Maximum number of concurrent pre-downloads, not recommended to set too high, it will affect the network speed of the current video playback.                  |
| preDownloadSize | double | Pre-download size, not recommended to set too high, to quickly complete pre-download, unit:MB.                    |
| preloadBufferSizeInMB | double | Maximum pre-play buffer size, the size cannot exceed preDownloadSize, otherwise, the pre-download cache will become invalid, unit:MB |
| maxBufferSize | double | Maximum buffer size during playback, unit:MB                               |
| preferredResolution | int  | Preferred video playback resolution                                        |
| progressInterval | int  | Video progress callback interval, default 500ms, unit:ms                          |
| renderMode | int  | On-demand video tiling mode, 0 represents filling the container, 1 represents adjusting according to the video ratio                   |

Example:
```dart
_playerController.setVodStrategy(FTUIPlayerVodStrategy());
```

