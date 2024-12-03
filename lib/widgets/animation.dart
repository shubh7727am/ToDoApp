import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:lottie/lottie.dart';
import '../viewmodels/animation_view_model.dart';

// animation widget to play the loading animation
class AnimationWidget extends ConsumerWidget {

  const AnimationWidget({super.key });


  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isPlaying = ref.watch(animationViewModelProvider); // animation controller controlling the start and stop of animation

    return isPlaying
        ? Container(
          color: Colors.black.withOpacity(0.8),
          height: double.infinity,
          child: Lottie.asset(
            "assets/animations/completed.json",
            onLoaded: (composition) {
              // Set animation duration [ in our case is equal to one loop of animation ]
              final duration = composition.duration;
              Future.delayed(duration, () {
                ref.read(animationViewModelProvider.notifier).stopAnimation();
              });
            },
          ),
        ):const  SizedBox();
  }
}
