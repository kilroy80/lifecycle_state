import 'package:flutter/material.dart';

enum WidgetVisibility { visible, invisible, }

mixin LifeCycleObserver {
  void onWidgetReady();
  void onWidgetResume();
  void onWidgetPause();
  void onWidgetVisibility(WidgetVisibility visibility);
}

class LifeCycleObserverData {
  String routerName;
  String widgetName;
  LifeCycleObserver observer;

  LifeCycleObserverData({
    required this.routerName,
    required this.widgetName,
    required this.observer
  });
}

abstract class ILifeCycleNavigator {
  void addObserver(String currentName, String widgetName, LifeCycleObserver observer);
  void removeObserver(LifeCycleObserver observer);
  void clearObserver();

  void forceWidgetPause(String widgetName);
  void forceWidgetResume(String widgetName);

  Future<T?> pushNamed<T extends Object?>(
      BuildContext context,
      String routeName, {
        Object? arguments
      });

  Future<T?> pushNamedAndRemoveUntil<T extends Object?>(
      BuildContext context,
      String newRouteName,
      RoutePredicate predicate, {
        Object? arguments,
      });
}

class LifeCycleNavigator implements ILifeCycleNavigator {
  static final LifeCycleNavigator instance = LifeCycleNavigator._internal();
  factory LifeCycleNavigator() {
    return instance;
  }

  LifeCycleNavigator._internal();

  final List<LifeCycleObserverData> _observers = <LifeCycleObserverData>[];

  @override
  void addObserver(String currentName, String widgetName, LifeCycleObserver observer) {
    if (_observers.where((element) => observer == element.observer).isEmpty) {
      _observers.add(LifeCycleObserverData(routerName: currentName, widgetName: widgetName, observer: observer));
    }
  }

  @override
  void removeObserver(LifeCycleObserver observer) =>
      _observers.removeWhere((element) => element.observer == observer);

  @override
  void clearObserver() => _observers.clear();

  @override
  void forceWidgetPause(String widgetName) {
    for (var element in _observers) {
      if (widgetName == element.widgetName) {
        element.observer.onWidgetPause();
        element.observer.onWidgetVisibility(WidgetVisibility.invisible);
      }
    }
  }

  @override
  void forceWidgetResume(String widgetName) {
    for (var element in _observers) {
      if (widgetName == element.widgetName) {
        element.observer.onWidgetVisibility(WidgetVisibility.visible);
        element.observer.onWidgetResume();
      }
    }
  }

  @override
  Future<T?> pushNamed<T extends Object?>(
      BuildContext context, String routeName,
      {String? currentRouteName, Object? arguments}) {

    var currentName = ModalRoute.of(context)?.settings.name ?? currentRouteName;
    for (var element in _observers) {
      if (currentName == element.routerName) {
        element.observer.onWidgetPause();
      }
    }

    return Navigator.of(context)
        .pushNamed<T>(routeName, arguments: arguments)
        .then((value) {

      // for (var element in _observers) {
      //   if (routeName == element.routerName) {
      //     element.observer.onWidgetPause();
      //   }
      // }

      debugPrint('currentName = ${currentName.toString()}');
      for (var element in _observers) {
        if (currentName == element.routerName) {
          element.observer.onWidgetResume();
        }
      }

      return value;
    });
  }

  @override
  Future<T?> pushNamedAndRemoveUntil<T extends Object?>(
      BuildContext context,
      String newRouteName,
      RoutePredicate predicate, {
        String? currentRouteName,
        Object? arguments,
      }) {

    var currentName = ModalRoute.of(context)?.settings.name ?? currentRouteName;
    for (var element in _observers) {
      if (currentName == element.routerName) {
        element.observer.onWidgetPause();
      }
    }

    return Navigator.of(context)
        .pushNamedAndRemoveUntil<T>(newRouteName, predicate, arguments: arguments)
        .then((value) {

      // for (var element in _observers) {
      //   if (routeName == element.routerName) {
      //     element.observer.onWidgetPause();
      //   }
      // }

      for (var element in _observers) {
        if (currentName == element.routerName) {
          element.observer.onWidgetResume();
        }
      }

      return value;
    });
  }
}