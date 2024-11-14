import 'package:flutter/material.dart';
import 'package:state_management/modules/state/base_bloc/state_bloc.dart';
import 'package:state_management/modules/state/inherited/index.dart';

final class StateBuilder<TStateBloc extends StateBloc> extends StatelessWidget {
  final Widget Function(BuildContext context, TStateBloc state) builder;

  const StateBuilder({super.key, required this.builder});

  @override
  Widget build(BuildContext context) {
    final bloc = InheritedProvider.of<TStateBloc>(context);
    return StreamBuilder<TStateBloc>(
      stream: bloc.stream,
      initialData: bloc.state..ctx = context,
      builder: (context, snapshot) {
        return builder(context, snapshot.data as TStateBloc);
      },
    );
  }
}
