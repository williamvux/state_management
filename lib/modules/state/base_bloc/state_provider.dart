import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:state_management/modules/state/base_bloc/state_bloc.dart';
import 'package:state_management/modules/state/inherited/index.dart';

final class StateProvider<TStateBloc extends StateBloc> extends StatefulWidget {
  final TStateBloc Function(BuildContext context) create;
  final Widget child;

  const StateProvider({super.key, required this.create, required this.child});

  @override
  State<StateProvider<TStateBloc>> createState() => _StateProviderState<TStateBloc>();
}

class _StateProviderState<TStateBloc extends StateBloc> extends State<StateProvider<TStateBloc>> {
  @override
  void dispose() {
    if (kDebugMode) {
      print('Must call to clear memory in state provider');
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final state = widget.create(context);
    return InheritedProvider<TStateBloc>(
      StreamController<TStateBloc>.broadcast(),
      state: state,
      child: widget.child,
    );
  }
}
