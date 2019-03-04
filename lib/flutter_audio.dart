import 'dart:async';

import 'package:flutter/services.dart';
import 'package:flutter/foundation.dart';
import 'package:uuid/uuid.dart';

typedef void PositionChangeListener(Duration position);
typedef void BufferingUpdateListener(double progress);

enum FlutterAudioState {
  STOPPED,
  PLAYING,
  PAUSED,
  COMPLETED,
}

class FlutterAudio {
  static MethodChannel _channel = MethodChannel('flutter_audio')
    ..setMethodCallHandler(platformCallHandler);
  static final _players = new Map<String, FlutterAudio>();
  static Future<void> platformCallHandler(MethodCall call) async {
    print('_platformCallHandler call ${call.method} ${call.arguments}');
  }

  String _playerId;
  String _url;

  FlutterAudioState _state;
  FlutterAudioState get state => _state;

  PositionChangeListener onPositionChangeListener;
  BufferingUpdateListener onBufferingUpdateListener;
  VoidCallback onCompletedListener;

  FlutterAudio({String url}) {
    _playerId = Uuid().v4();
    _players[_playerId] = this;
    this._url = url;
  }

  void _onBufferingUpdate(double progress) {}

  void _onPositionChange(Duration position) {}

  void _onComplete() {
    _state = FlutterAudioState.COMPLETED;
  }

  Future<void> _invokeMethod({
    String method,
    Map<String, dynamic> arguments = const {},
  }) async {
    print('invoke method $method');
    Map<String, dynamic> withPlayerId = Map.of(arguments);
    withPlayerId['playerId'] = _playerId;
    return _channel
        .invokeMethod(method, withPlayerId)
        .then((result) => (result as int));
  }

  void dispose() {}

  Future<bool> load() async {
    return true;
  }

  Future<bool> setVolume() async {
    return true;
  }

  Future<bool> play() async {
    _state = FlutterAudioState.PLAYING;
    return true;
  }

  Future<bool> pause() async {
    _state = FlutterAudioState.PAUSED;
    return true;
  }

  Future<bool> stop() async {
    _state = FlutterAudioState.STOPPED;
    return true;
  }

  Future<bool> seek(Duration position) async {
    return true;
  }
}
