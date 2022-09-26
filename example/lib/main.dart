import 'package:flutter/material.dart';

import 'package:lifecycle_state/lifecycle_state.dart';

void main() => runApp(
  MaterialApp(
    initialRoute: '/',
    routes: {
      '/': (context) => const MyApp(),
      '/second': (context) => const SecondPage(),
    },
  ),
);

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends LifeCycleState<MyApp> {

  @override
  void onAppPause() {
    debugPrint('${widget.toString()} - onAppPause');
  }

  @override
  void onAppResume() {
    debugPrint('${widget.toString()} - onAppResume');
  }

  @override
  void onWidgetPause() {
    debugPrint('${widget.toString()} - onWidgetPause');
  }

  @override
  void onWidgetReady() {
    debugPrint('${widget.toString()} - onWidgetReady');
  }

  @override
  void onWidgetResume() {
    debugPrint('${widget.toString()} - onWidgetResume');
  }

  @override
  void onWidgetVisibility(WidgetVisibility visibility) {
  }

  @override
  String get routeName => '/';

  @override
  bool get wantAppLifeCycle => true;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Main Page'),
      ),
      body: Center(
        child: MaterialButton(
          onPressed: () {
            LifeCycleNavigator.instance.pushNamed(context, '/second');
          },
          child: const Text('Go! Second Page'),
        ),
      ),
    );
  }
}

class SecondPage extends StatefulWidget {
  const SecondPage({Key? key}) : super(key: key);

  @override
  State<SecondPage> createState() => _SecondPageState();
}

class _SecondPageState extends LifeCycleState<SecondPage> {

  @override
  void onAppPause() {
    debugPrint('${widget.toString()} - onAppPause');
  }

  @override
  void onAppResume() {
    debugPrint('${widget.toString()} - onAppResume');
  }

  @override
  void onWidgetPause() {
    debugPrint('${widget.toString()} - onWidgetPause');
  }

  @override
  void onWidgetReady() {
    debugPrint('${widget.toString()} - onWidgetReady');
  }

  @override
  void onWidgetResume() {
    debugPrint('${widget.toString()} - onWidgetResume');
  }

  @override
  void onWidgetVisibility(WidgetVisibility visibility) {
  }

  @override
  String get routeName => '/second';

  @override
  bool get wantAppLifeCycle => true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Second Page'),
      ),
    );
  }
}


