import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hs_river_pod/counter_notifier.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This  widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ProviderScope(
      child: MaterialApp(
          title: 'Flutter Demo',
          theme: ThemeData(
            colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
            useMaterial3: true,
          ),
          home: MainScreen()),
    );
  }
}

class MainScreen extends StatelessWidget {
  const MainScreen({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: ElevatedButton(
          onPressed: () {
            Navigator.push(context, MaterialPageRoute(builder: (_) {
              return Home();
            }));
          },
          child: const Text("Go to Home"),
        ),
      ),
    );
  }
}

//ConsumerWidget
//ConsumerStatefulWidget
class Home extends ConsumerWidget {
  Home({super.key});
  final counterProvider = CounterProvider(() {
    return CounterNotifier();
  });

  // final counterProvider = AutoDisposeNotifierProvider<CounterNotifier, int>(() {
  //   return CounterNotifier();
  // });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    ref.listen(counterProvider, (previous, next) {
      print("Old state is $previous, new state is $next");
    });
    int count = ref.watch(counterProvider);
    CounterNotifier counterNotifier = ref.read(counterProvider.notifier);
    return Scaffold(
      appBar: AppBar(
        title: const Text("Riverpods"),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'The counter is $count',
              style: const TextStyle(fontSize: 32),
            ),
            FilledButton(
                onPressed: () {
                  counterNotifier.increment();
                },
                child: const Text('+')),
            FilledButton(
                onPressed: () {
                  counterNotifier.decrement();
                },
                child: const Text('-')),
            FilledButton(
                onPressed: () {
                  int defaultValue = ref.refresh(counterProvider);
                },
                child: const Text('Refresh')),
          ],
        ),
      ),
    );
  }
}

// final Provider<String> provider = Provider((ref) => "Hello");

