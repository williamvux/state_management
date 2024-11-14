import 'dart:async';

import 'package:flutter/material.dart';
import 'package:state_management/modules/state/base_bloc/state_bloc.dart';


final class InheritedProvider<TStateBloc extends StateBloc> extends InheritedWidget {
  const InheritedProvider(this._controller, {super.key, required super.child, required this.state});

  final StreamController<TStateBloc> _controller;
  final TStateBloc state;
  Stream<TStateBloc> get stream => _controller.stream;
  void notify(TStateBloc state) {
    _controller.sink.add(state);
  }

  static InheritedProvider<T> of<T extends StateBloc>(BuildContext context) {
    final provider = context.dependOnInheritedWidgetOfExactType<InheritedProvider<T>>();
    if (provider == null) {
      throw Exception('${T.toString()} is not registered');
    }

    return provider;
  }

  void dispose() {
    state.dispose();
    _controller.close();
  }

  @override
  bool updateShouldNotify(covariant InheritedWidget oldWidget) {
    return false;
  }
}
