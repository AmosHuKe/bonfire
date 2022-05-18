import 'package:bonfire/base/bonfire_game_interface.dart';
import 'package:bonfire/bonfire.dart';
import 'package:flutter/widgets.dart' as widget;

///
/// Created by
///
/// ─▄▀─▄▀
/// ──▀──▀
/// █▀▀▀▀▀█▄
/// █░░░░░█─█
/// ▀▄▄▄▄▄▀▀
///
/// Rafaelbarbosatec
/// on 04/03/22
class CameraSceneAction extends SceneAction {
  final Vector2? position;
  final GameComponent? target;
  final Duration duration;
  final double? zoom;
  final double? angle;
  final widget.Curve curve;

  bool _running = false;
  bool _done = false;

  CameraSceneAction({
    this.position,
    this.target,
    this.zoom,
    this.angle,
    this.curve = widget.Curves.decelerate,
    required this.duration,
  });
  CameraSceneAction.position(
    this.position, {
    this.duration = const Duration(seconds: 1),
    this.zoom,
    this.angle,
    this.curve = widget.Curves.decelerate,
  }) : this.target = null;

  CameraSceneAction.target(
    this.target, {
    this.duration = const Duration(seconds: 1),
    this.zoom,
    this.angle,
    this.curve = widget.Curves.decelerate,
  }) : this.position = null;

  @override
  bool runAction(double dt, BonfireGameInterface game) {
    if (!_running) {
      _running = true;
      if (position != null) {
        game.camera.moveToPositionAnimated(
          position!,
          duration: duration,
          finish: _actionDone,
          curve: curve,
          angle: angle,
          zoom: zoom,
        );
      } else if (target != null) {
        game.camera.moveToTargetAnimated(
          target!,
          duration: duration,
          finish: _actionDone,
          curve: curve,
          angle: angle,
          zoom: zoom,
        );
      } else {
        return true;
      }
    }
    if (_done) {
      return true;
    }
    return false;
  }

  void _actionDone() {
    _done = true;
  }
}
