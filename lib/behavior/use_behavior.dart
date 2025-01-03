import 'package:bonfire/base/game_component.dart';
import 'package:bonfire/behavior/behavior.dart';
import 'package:flutter/foundation.dart';
import 'package:vector_math/vector_math_64.dart';

mixin UseBehavior on GameComponent {
  List<Behavior> get behaviors;
  late BehaviorManager _behaviorManager;
  bool _initialized = false;

  @override
  void onMount() {
    super.onMount();
    add(
      _behaviorManager = BehaviorManager(
        behaviors: behaviors,
      ),
    );
    _initialized = true;
  }

  @override
  void onGameResize(Vector2 size) {
    if (kDebugMode && _initialized) {
      _behaviorManager.updateBehaviors(behaviors);
    }
    super.onGameResize(size);
  }

  void updateBehaviors(List<Behavior> behaviors) {
    _behaviorManager.updateBehaviors(behaviors);
  }

  bool get behaviorIsRunning => _behaviorManager.isRunning;

  void toggleBehavior() {
    if (_behaviorManager.isRunning) {
      pauseBehaviors();
    } else {
      resumeBehaviors();
    }
  }

  void pauseBehaviors() {
    _behaviorManager.pause();
  }

  void resumeBehaviors() {
    _behaviorManager.resume();
  }
}
