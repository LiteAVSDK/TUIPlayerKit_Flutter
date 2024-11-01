// Copyright (c) 2024 Tencent. All rights reserved.
library ftui_player_kit;

import 'dart:io';
import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'dart:developer';
import 'dart:async';

import 'package:provider/provider.dart';

part 'core/ftuiplayer_kit_plugin.dart';
part 'core/player/ftuiplayer_short_controller.dart';
part 'core/model/ftuiplayer_define.dart';
part 'core/ftuiplayer_message.dart';
part 'core/tools/ftui_model_tools.dart';
part 'core/player/tuivodplayer_controller.dart';
part 'core/player/view/ftuiplayer_views.dart';

