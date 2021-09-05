import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class BlocProvider<T> extends InheritedWidget {
  final T create;

  const BlocProvider({Key key, Widget child, this.create})
      : super(child: child);

  @override
  bool updateShouldNotify(BlocProvider<T> old) {
    return old.create != this.create;
  }

  static BlocProvider of(BuildContext context) {
    return context.dependOnInheritedWidgetOfExactType<BlocProvider>();
  }
}
