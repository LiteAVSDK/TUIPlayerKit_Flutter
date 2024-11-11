// Copyright (c) 2024 Tencent. All rights reserved.
import 'dart:async';

import 'package:flutter/material.dart';
import 'package:ftuiplayer_kit/ftuiplayer_kit.dart';

import 'demo/short_video_demo.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

// The obtained license URL
const LICENSE_URL = "";
// The obtained license key
const LICENSE_KEY = "";

class _MyAppState extends State<MyApp> {


  @override
  void initState() {
    super.initState();
    initPlatformState();
  }

  // Platform messages are asynchronous, so we initialize in an async method.
  Future<void> initPlatformState() async {
    FTUIPlayerConfig config = FTUIPlayerConfig(
        licenseUrl: LICENSE_URL,
        licenseKey: LICENSE_KEY);
    config.enableLog = true;
    FTUIPlayerKitPlugin.setTUIPlayerConfig(config);
    FTUIPlayerKitPlugin.setMonetAppInfo(${appId}, ${authId}, FTXMonetConstant.SR_ALGORITHM_TYPE_STANDARD);
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
            title: Builder(
          builder: (context) => const Text(
            "FTUIPlayerKit",
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.w400),
          ),
        )),
        body: Builder(builder: (context) {
          return TextButton(
            onPressed: () {
              Navigator.push(context, MaterialPageRoute(builder: (context) {
                return const ShortVideoDemo();
              }));
            },
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 5.0),
              child: const Text(
                "TUIShortVideo",
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.w400),
              ),
            ),
          );
        }),
      ),
    );
  }
}
