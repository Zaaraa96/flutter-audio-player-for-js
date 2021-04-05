
import 'dart:async';

import 'package:flutter/services.dart';

class JsAudioPlayer {
  static const MethodChannel _channel =
      const MethodChannel('js_audio_player');

  static Future<String> get platformVersion async {
    final String version = await _channel.invokeMethod('getPlatformVersion');
    return version;
  }

  void setPath(String path) async{
    await _channel.invokeMethod('setPath');

  }

  void play() async{
    await _channel.invokeMethod('play');
  }

  void pause() async{
    await _channel.invokeMethod('pause');
  }

  void getDuration()async {
    await _channel.invokeMethod('getDuration');
  }

  Future<double> getPosition() async{
    return await _channel.invokeMethod('getPosition');
  }

  void seek(int newPosition) async{
    await _channel.invokeMethod('seek');
  }

  void mute(bool muted) async{
    await _channel.invokeMethod('mute');
  }

}
