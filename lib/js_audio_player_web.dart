import 'dart:async';
// In order to *not* need this ignore, consider extracting the "web" version
// of your plugin as a separate package, instead of inlining it in the same
// package as the core of your plugin.
// ignore: avoid_web_libraries_in_flutter
import 'dart:html' as html show window;
import 'dart:js' as js;
import 'package:flutter/services.dart';
import 'package:flutter_web_plugins/flutter_web_plugins.dart';
import 'package:rxdart/rxdart.dart';

/// A web implementation of the JsAudioPlayer plugin.
class JsAudioPlayerWeb {
  static void registerWith(Registrar registrar) {
    final MethodChannel channel = MethodChannel(
      'js_audio_player',
      const StandardMethodCodec(),
      registrar,
    );

    final pluginInstance = JsAudioPlayerWeb();
    channel.setMethodCallHandler(pluginInstance.handleMethodCall);
  }

  /// Handles method calls over the MethodChannel of this plugin.
  /// Note: Check the "federated" architecture for a new way of doing this:
  /// https://flutter.dev/go/federated-plugins
  Future<dynamic> handleMethodCall(MethodCall call) async {
    switch (call.method) {
      case 'getPlatformVersion':
        return getPlatformVersion();
        break;
      case 'setPath':
        return setPath(call.arguments);
        break;
      case 'play':
        return play();
        break;
      case 'pause':
        return pause();
        break;
      case 'getDuration':
        return getDuration();
        break;
      case 'getPosition':
        return getPosition();
        break;
      case 'seek':
        return seek(call.arguments);
        break;
      case 'mute':
        return mute(call.arguments);
        break;
      case 'duration':
        return duration;
        break;

      default:
        throw PlatformException(
          code: 'Unimplemented',
          details: 'js_audio_player for web doesn\'t implement \'${call.method}\'',
        );
    }
  }

  /// Returns a [String] containing the version of the platform.
  Future<String> getPlatformVersion() {
    final version = html.window.navigator.userAgent;
    return Future.value(version);
  }

  BehaviorSubject<double> _duration;
  Stream<double> get duration => _duration.stream;

  JsAudioPlayerWeb(){
    _duration=BehaviorSubject<double>();
    _duration.add(0);

  }
  void setPath(String path) {
    js.context.callMethod('setAudioPath', [path,getDuration]);

  }

  void play() {

    js.context.callMethod('play');

  }

  void pause() {

    js.context.callMethod('pause');

  }

  void getDuration() {
    _duration.add( js.context.callMethod('getDuration'));
  }

  double getPosition() {
    return
      js.context.callMethod('getPosition');
    // js.JsFunction.withThis(f)
  }

  void seek(int newPosition) {
    js.context.callMethod('seek',[newPosition]);
  }

  void mute(bool muted) {
    if(muted)
      js.context.callMethod('mute');
    else
      js.context.callMethod('unmute');
  }
}

