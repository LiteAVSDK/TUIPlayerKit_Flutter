// Copyright (c) 2024 Tencent. All rights reserved.
part of '../../ftuiplayer_kit.dart';

abstract class TXVodPlayEvent {
  // Invalid license, call failed.
  // license 不合法，调用失败
  static const PLAY_EVT_ERROR_INVALID_LICENSE = -5;

  // Connected to server.
  // 已经连接服务器
  static const PLAY_EVT_CONNECT_SUCC = 2001;

  // Connected to server, start pulling stream (only for playing RTMP address).
  // 已经连接服务器，开始拉流（仅播放 RTMP 地址时会抛送）
  static const PLAY_EVT_RTMP_STREAM_BEGIN = 2002;

  // Received the first frame of data, the faster you receive this message, the better the link quality.
  // 收到首帧数据，越快收到此消息说明链路质量越好
  static const PLAY_EVT_RCV_FIRST_I_FRAME = 2003;

  // Video playback starts, if you make your own loading, you will need it.
  // 视频播放开始，如果您自己做 loading，会需要它
  static const PLAY_EVT_PLAY_BEGIN = 2004;

  // Video playback progress.
  // 视频播放进度
  static const PLAY_EVT_PLAY_PROGRESS = 2005;

  // Video playback ends.
  // 视频播放结束
  static const PLAY_EVT_PLAY_END = 2006;

  // Video playback enters buffering state, and there will be a PLAY_BEGIN event after buffering ends.
  // 视频播放进入缓冲状态，缓冲结束之后会有 PLAY_BEGIN 事件
  static const PLAY_EVT_PLAY_LOADING = 2007;

  // Video decoder starts to work (added after version 2.0).
  // 视频解码器开始启动（2.0 版本以后新增)
  static const PLAY_EVT_START_VIDEO_DECODER = 2008;

  // Video resolution changes (resolution is in the EVT_PARAM parameter).
  // 视频分辨率发生变化（分辨率在 EVT_PARAM 参数中）
  static const PLAY_EVT_CHANGE_RESOLUTION = 2009;

  // Successfully obtained on-demand file information.
  // 获取点播文件信息成功
  static const PLAY_EVT_GET_PLAYINFO_SUCC = 2010;

  // Get custom SEI message embedded in video stream, message sending needs to use TXLivePusher.
  // 如果您在直播中收到此消息，说明错用成了 TXVodPlayer
  static const PLAY_EVT_CHANGE_ROTATION = 2011;

  // Get custom SEI message embedded in video stream, message sending needs to use TXLivePusher.
  // 如果您在直播中收到此消息，说明错用成了 TXVodPlayer
  static const PLAY_EVT_GET_MESSAGE = 2012;

  // Video loading completed (VOD).
  // 视频加载完毕（点播）
  static const PLAY_EVT_VOD_PLAY_PREPARED = 2013;

  // Loading ends (VOD).
  // loading结束（点播）
  static const PLAY_EVT_VOD_LOADING_END = 2014;

  // Live streaming switch completed.
  // 直播流切换完成
  static const PLAY_EVT_STREAM_SWITCH_SUCC = 2015;

  // View rendering first frame time.
  // View渲染首帧时间
  static const PLAY_EVT_RENDER_FIRST_FRAME_ON_VIEW = 2033;

  // Network disconnected and cannot be restored after multiple reconnections.
  // Please restart the playback by yourself if you want to try again.
  // 网络断连，且经多次重连亦不能恢复，更多重试请自行重启播放
  static const PLAY_ERR_NET_DISCONNECT = -2301;

  // Failed to get accelerated streaming address.
  // 获取加速拉流地址失败
  static const PLAY_ERR_GET_RTMP_ACC_URL_FAIL = -2302;

  // File does not exist.
  // 文件不存在
  static const PLAY_ERR_FILE_NOT_FOUND = -2303;

  // H.265 decoding failed.
  // h265解码失败
  static const PLAY_ERR_HEVC_DECODE_FAIL = -2304;

  // Failed to obtain HLS decryption key.
  // HLS解密key获取失败
  static const PLAY_ERR_HLS_KEY = -2305;

  // Failed to get VOD file information.
  // 获取点播文件信息失败
  static const PLAY_ERR_GET_PLAYINFO_FAIL = -2306;

  // Live streaming quality switch failed.
  // 直播清晰度切换失败
  static const PLAY_ERR_STREAM_SWITCH_FAIL = -2307;

  // Current video frame decoding failed.
  // 当前视频帧解码失败
  static const PLAY_WARNING_VIDEO_DECODE_FAIL = 2101;

  // Current audio frame decoding failed.
  // 当前音频帧解码失败
  static const PLAY_WARNING_AUDIO_DECODE_FAIL = 2102;

  // Network disconnected, and automatic reconnection has been started
  // (if reconnection exceeds three times, PLAY_ERR_NET_DISCONNECT will be thrown directly).
  // 网络断连，已启动自动重连（重连超过三次就直接抛送 PLAY_ERR_NET_DISCONNECT）
  static const PLAY_WARNING_RECONNECT = 2103;

  // Network packet is unstable: it may be due to insufficient downstream bandwidth, or uneven flow from the anchor end.
  // 网络来包不稳：可能是下行带宽不足，或由于主播端出流不均匀
  static const PLAY_WARNING_RECV_DATA_LAG = 2104;

  // Current video playback is stuck.
  // 当前视频播放出现卡顿
  static const PLAY_WARNING_VIDEO_PLAY_LAG = 2105;

  // Hardware decoding failed, using software decoding.
  // 硬解启动失败，采用软解
  static const PLAY_WARNING_HW_ACCELERATION_FAIL = 2106;

  // Current video frame is not continuous, may have dropped frames.
  // 当前视频帧不连续，可能丢帧
  static const PLAY_WARNING_VIDEO_DISCONTINUITY = 2107;

  // RTMP-DNS resolution failed (only for playing RTMP address).
  // RTMP-DNS 解析失败（仅播放 RTMP 地址时会抛送）
  static const PLAY_WARNING_DNS_FAIL = 3001;

  // RTMP server connection failed (only for playing RTMP address).
  // RTMP 服务器连接失败（仅播放 RTMP 地址时会抛送）
  static const PLAY_WARNING_SEVER_CONN_FAIL = 3002;

  // RTMP server handshake failed (only for playing RTMP address).
  // RTMP 服务器握手失败（仅播放 RTMP 地址时会抛送）
  static const PLAY_WARNING_SHAKE_FAIL = 3003;

  // RTMP read/write failed.
  // RTMP 读/写失败
  static const PLAY_WARNING_READ_WRITE_FAIL = 3005;

  // Playback device exception.
  // 播放设备异常
  static const PLAY_WARNING_SPEAKER_DEVICE_ABNORMAL = 1205;

  // Seek completed.
  // Seek 完成
  static const VOD_PLAY_EVT_SEEK_COMPLETE = 2019;

  // Video SEI frame information, Player Premium version 11.6 starts to support
  // 视频 SEI 帧信息, 播放器高级版 11.6 版本开始支持
  static const VOD_PLAY_EVT_VIDEO_SEI = 2030;

  // HEVC downgrade playback， Player Premium version 12.0 starts to support
  // HEVC 降级播放，播放器高级版 12.0 版本开始支持
  static const VOD_PLAY_EVT_HEVC_DOWNGRADE_PLAYBACK = 2031;

  // video loop once complete
  static const VOD_PLAY_EVT_LOOP_ONCE_COMPLETE = 6001;
  // first frame rendered on texture
  static const PLAY_EVT_FIRST_FRAME_RENDERED = 50001;



  static const EVT_EVENT = "event";
  // UTC time
  // UTC时间
  static const EVT_UTC_TIME = "EVT_UTC_TIME";
  // Stuttering time.
  // 卡顿时间
  static const EVT_BLOCK_DURATION = "EVT_BLOCK_DURATION";
  // Event occurrence time.
  // 事件发生时间
  static const EVT_TIME = "EVT_TIME";
  // Event description.
  // 事件说明
  static const EVT_DESCRIPTION = "EVT_MSG";
  // Event parameter 1.
  // 事件参数1
  static const EVT_PARAM1 = "EVT_PARAM1";
  // Event parameter 2.
  // 事件参数2
  static const EVT_PARAM2 = "EVT_PARAM2";
  // Width of resolution.
  // 分辨率之width
  static const EVT_VIDEO_WIDTH = "EVT_WIDTH";
  // Height of resolution.
  // 分辨率之height
  static const EVT_VIDEO_HEIGHT = "EVT_HEIGHT";
  // Message content, use this field to get the message content when receiving PLAY_EVT_GET_MESSAGE event.
  // 消息内容，收到PLAY_EVT_GET_MESSAGE事件时，通过该字段获取消息内容s
  static const EVT_GET_MSG = "EVT_GET_MSG";
  // Video cover
  // 视频封面
  static const EVT_PLAY_COVER_URL = "EVT_PLAY_COVER_URL";
  // Video address.
  // 视频地址
  static const EVT_PLAY_URL = "EVT_PLAY_URL";
  // Video name.
  // 视频名称
  static const EVT_PLAY_NAME = "EVT_PLAY_NAME";
  // Video introduction.
  // 视频简介
  static const EVT_PLAY_DESCRIPTION = "EVT_PLAY_DESCRIPTION";
  // Playback progress (in milliseconds).
  // 播放进度（毫秒）
  static const EVT_PLAY_PROGRESS_MS = "EVT_PLAY_PROGRESS_MS";
  // Total playback time (in milliseconds).
  // 播放总长（毫秒）
  static const EVT_PLAY_DURATION_MS = "EVT_PLAY_DURATION_MS";
  // Playback progress.
  // 播放进度
  static const EVT_PLAY_PROGRESS = "EVT_PLAY_PROGRESS";
  // Total playback time
  // 播放总长
  static const EVT_PLAY_DURATION = "EVT_PLAY_DURATION";
  // Playable duration of VOD (in milliseconds).
  // 点播可播放时长（毫秒）
  static const EVT_PLAYABLE_DURATION_MS = "EVT_PLAYABLE_DURATION_MS";
  // Playable duration of VOD (in milliseconds).
  // 点播可播放时长
  static const EVT_PLAYABLE_DURATION = "EVT_PLAYABLE_DURATION";
  // Playback rate.
  // 播放速率
  static const EVT_PLAYABLE_RATE = "EVT_PLAYABLE_RATE";
  // Web VTT description file download URL of sprite map.
  // 雪碧图web vtt描述文件下载URL
  static const EVT_IMAGESPRIT_WEBVTTURL = "EVT_IMAGESPRIT_WEBVTTURL";
  // Download URL of sprite map image.
  // 雪碧图图片下载URL
  static const EVT_IMAGESPRIT_IMAGEURL_LIST = "EVT_IMAGESPRIT_IMAGEURL_LIST";
  // Encryption type.
  // 加密类型
  static const EVT_DRM_TYPE = "EVT_DRM_TYPE";
  // Ghost watermark text (supported since version 11.5)
  //  幽灵水印文本（11.5版本开始支持）
  static const EVT_KEY_WATER_MARK_TEXT = "EVT_KEY_WATER_MARK_TEXT";
  // SEI data type
  static const EVT_KEY_SEI_TYPE = "EVT_KEY_SEI_TYPE";
  // SEI data size
  static const EVT_KEY_SEI_SIZE = "EVT_KEY_SEI_SIZE";
  // SEI data
  static const EVT_KEY_SEI_DATA = "EVT_KEY_SEI_DATA";
  // Play PDT time, Player Premium version 11.6 starts to support
  // 播放PDT时间, 播放器高级版 11.6 版本开始支持
  static const EVT_PLAY_PDT_TIME_MS = "EVT_PLAY_PDT_TIME_MS";
  // superResolution key
  // 超分键值
  static const SUPER_RESOLUTION_OPTION_KEY = "PARAM_SUPER_RESOLUTION_TYPE";
}

abstract class FTXMonetConstant {
  /// 标准模式：提供快速的超分辨率处理速度，适用于高实时性要求的场景。在这种模式下，可以实现显著的图像质量改善。
  static const SR_ALGORITHM_TYPE_STANDARD = 1;
  /// 专业版-高质量模式：确保了高图像质量，同时需要更高的设备性能。它适合于有高图像质量要求的场景，并推荐在中高端智能手机上使用。
  static const SR_ALGORITHM_TYPE_PROFESSIONAL_HIGH_QUALITY = 2;
  /// 专业版-快速模式：在牺牲一些图像质量的同时，确保了更快的处理速度。它适合于有高实时性要求的场景，并推荐在中档智能手机上使用。
  static const SR_ALGORITHM_TYPE_PROFESSIONAL_FAST = 3;
}

enum TUIPlayerState {
  INIT,       // Initial state
  PLAYING,    // Playing
  PAUSE,      // Paused
  LOADING,    // Buffering
  END,         // Playback finished
}

class FTUIPlayerConfig {
  String licenseUrl;
  String licenseKey;
  bool enableLog = true;

  FTUIPlayerConfig({required this.licenseUrl, required this.licenseKey, this.enableLog = true});

  FTUIPlayerConfigMsg toMsg() {
    FTUIPlayerConfigMsg msg = FTUIPlayerConfigMsg();
    msg.licenseUrl = licenseUrl;
    msg.licenseKey = licenseKey;
    msg.enableLog = enableLog;
    return msg;
  }
}

/// The playback methods for videoUrl and fileId cannot be active at the same time;
/// you only need to assign one of them. If both are provided, the fileId method will take precedence.
///
/// videoUrl播放方式 和 fileId 播放方式同时只有一个生效，赋值其中一种即可，如果都传入，fileId方式优先
class FTUIVideoSource {
  String? videoURL;

  /// the coverPictureUrl will appear before video start
  String? coverPictureUrl;

  int? appId;

  String? fileId;

  String? pSign;

  /// just valid for android now
  bool isAutoPlay = true;

  Object? extInfo;

  FTUIVodSourceMsg toMsg() {
    FTUIVodSourceMsg msg = FTUIVodSourceMsg()
      ..videoURL = videoURL
      ..coverPictureUrl = coverPictureUrl
      ..appId = appId
      ..pSign = pSign
      ..fileId = fileId
      ..isAutoPlay = isAutoPlay
      ..extInfo = extInfo;
    return msg;
  }
}


class FTUIVodControlListener {

  FTUIOnVodControllerBind? onVodControllerBind;
  FTUIOnVodControllerUnBind? onVodControllerUnBind;
  FTUIOnVodPlayerEvent? onVodPlayerEvent;

  FTUIVodControlListener({this.onVodControllerBind, this.onVodControllerUnBind, this.onVodPlayerEvent});
}

class FTUIPlayerVodStrategy {
  /// Maximum concurrent pre-downloads are not recommended to be set too high,
  /// as it will affect the network speed transmission of the current video playback.
  /// 最大预下载数量，不建议设置太大，会影响当前视频播放的网速
  int preloadCount = 3;
  double preDownloadSize = 1;

  /// preload buffer size when video prePlay.unit:MB
  /// preloadBufferSizeInMB must be less than preDownloadSize, otherwise the pre-download cache will become ineffective.
  /// 视频预播放时候的预加载缓存
  /// 必须小于 preDownloadSize ,否则预下载缓存会失效
  double preloadBufferSizeInMB = 0.5;

  /// max load buffer size when video play,unit:MB
  /// 视频正在播放时候的最大缓冲大小，单位 MB
  double maxBufferSize = 10;
  int preferredResolution = 720 * 1280;

  /// unit:ms
  int progressInterval = 500;

  /// 0 : fill view container
  /// 1 : adjust video resolution
  int renderMode = 1;

  /// enable SuperResolution
  bool enableSuperResolution = false;

  FTUIPlayerVodStrategyMsg toMsg() {
    FTUIPlayerVodStrategyMsg msg = FTUIPlayerVodStrategyMsg()
      ..preloadCount = preloadCount
      ..preDownloadSize = preDownloadSize
      ..preloadBufferSizeInMB = preloadBufferSizeInMB
      ..maxBufferSize = maxBufferSize
      ..preferredResolution = preferredResolution
      ..progressInterval = progressInterval
      ..renderMode = renderMode
      ..enableSuperResolution = enableSuperResolution;
    return msg;
  }
}

typedef FTUIOnVodControllerBind = void Function();
typedef FTUIOnVodControllerUnBind = void Function();
typedef FTUIOnVodPlayerEvent = void Function(Map<dynamic, dynamic> event);
