import 'package:flutter_riverpod/flutter_riverpod.dart';

typedef CounterProvider = AutoDisposeNotifierProvider<CounterNotifier, int>;

class CounterNotifier extends AutoDisposeNotifier<int> {
  @override
  int build() {
    ref.onDispose(() {
      print('notifier is disposed');
    });
    return 0;
  }

  void increment() => state++;
  void decrement() => state--;
}
