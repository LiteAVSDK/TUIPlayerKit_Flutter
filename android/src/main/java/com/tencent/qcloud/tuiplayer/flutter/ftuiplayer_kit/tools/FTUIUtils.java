package com.tencent.qcloud.tuiplayer.flutter.ftuiplayer_kit.tools;

import android.os.Bundle;

import java.util.HashMap;
import java.util.Map;
import java.util.Set;

public class FTUIUtils {
    /**
     * 将秒数转换为hh:mm:ss的格式
     * @param second 秒
     */
    public static String formattedTime(long second) {
        String formatTime;
        long h, m, s;
        h = second / 3600;
        m = (second % 3600) / 60;
        s = (second % 3600) % 60;
        if (h == 0) {
            formatTime = asTwoDigit(m) + ":" + asTwoDigit(s);
        } else {
            formatTime = asTwoDigit(h) + ":" + asTwoDigit(m) + ":" + asTwoDigit(s);
        }
        return formatTime;
    }

    public static String asTwoDigit(long digit) {
        String value = "";
        if (digit < 10) {
            value = "0";
        }
        value += String.valueOf(digit);
        return value;
    }

    public static Map<String, Object> getParams(int event, Bundle bundle) {
        Map<String, Object> param = new HashMap<>();
        if (event != 0) {
            param.put("event", event);
        }

        if (bundle != null && !bundle.isEmpty()) {
            Set<String> keySet = bundle.keySet();
            for (String key : keySet) {
                Object val = bundle.get(key);
                param.put(key, val);
            }
        }

        return param;
    }

}
