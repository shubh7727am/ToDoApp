import 'package:flutter_riverpod/flutter_riverpod.dart';

class AnimationViewModel extends StateNotifier<bool> {
  AnimationViewModel() : super(false);

  void playAnimation() {
    state = true; // Start playing the animation
  }

  void stopAnimation() {
    state = false; // Stop the animation
  }
}

final animationViewModelProvider = StateNotifierProvider<AnimationViewModel, bool>(
      (ref) => AnimationViewModel(),
);
