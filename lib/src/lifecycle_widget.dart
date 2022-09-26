import 'package:flutter/material.dart';
import 'package:lifecycle_state/src/lifecycle_navigator.dart';

abstract class LifeCycleStatefulWidget extends StatefulWidget {
  const LifeCycleStatefulWidget({Key? key, required this.routeName})
      : super(key: key);

  final String routeName;
}

abstract class LifeCycleState<T extends StatefulWidget> extends State<T>
  with WidgetsBindingObserver, LifeCycleObserver {

  WidgetVisibility visibility = WidgetVisibility.visible;

  @protected
  bool get wantAppLifeCycle;

  @protected
  String get routeName;

  void onAppResume();

  void onAppPause();

  @override
  void initState() {
    super.initState();
    if (wantAppLifeCycle) {
      WidgetsBinding.instance.addObserver(this);
    }
    WidgetsBinding.instance.addPostFrameCallback((_) {
      onWidgetReady();
    });

    LifeCycleNavigator.instance.addObserver(routeName, (widget).toString(), this);
  }

  @override
  void dispose() {
    if (wantAppLifeCycle) {
      WidgetsBinding.instance.removeObserver(this);
    }
    LifeCycleNavigator.instance.removeObserver(this);
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    super.didChangeAppLifecycleState(state);
    if (state == AppLifecycleState.resumed) {
      if (visibility == WidgetVisibility.visible) {
        onAppResume();
      }
    } else if (state == AppLifecycleState.paused) {
      if (visibility == WidgetVisibility.visible) {
        onAppPause();
      }
    }
  }
}