part of '../../ftuiplayer_kit.dart';

class FTUIModelTools {

  static vodMsgToVodSource(FTUIVodSourceMsg? msg) {
    FTUIVideoSource source = FTUIVideoSource();
    if (null != msg) {
      source
        ..videoURL = msg.videoURL
        ..appId = msg.appId
        ..fileId = msg.fileId
        ..pSign = msg.pSign
        ..isAutoPlay = msg.isAutoPlay ?? true
        ..extInfo = msg.extInfo;
    }
    return source;
  }
}
