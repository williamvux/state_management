import 'package:flutter/material.dart';
import 'package:state_management/modules/state/base_bloc/state_bloc.dart';
import 'package:state_management/modules/state/inherited/index.dart';


extension StateContext on BuildContext {
  TStateBloc persist<TStateBloc extends StateBloc>() {
    final provider = InheritedProvider.of<TStateBloc>(this);
    provider.state.ctx = this;
    return provider.state;
  }
}
