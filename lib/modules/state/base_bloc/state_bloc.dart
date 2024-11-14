import 'package:flutter/material.dart';
import 'package:state_management/modules/state/inherited/index.dart';


abstract class StateBloc {
  BuildContext? _context;
  StateBloc();

  set ctx(BuildContext ctx) => _context = ctx;

  void notify<TStateBloc extends StateBloc>() {
    if (_context == null) {
      return;
    }
    InheritedProvider.of<TStateBloc>(_context!).notify(this as TStateBloc);
  }

  @mustCallSuper
  void dispose() {
    _context = null;
  }
}
