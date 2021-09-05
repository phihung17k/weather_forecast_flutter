
import 'package:rxdart/rxdart.dart';

abstract class MainBloc<T extends dynamic> {

  BehaviorSubject<T> controller;
  BehaviorSubject<dynamic> _listenerController = BehaviorSubject<dynamic>();

  MainBloc({T state}){
    controller = BehaviorSubject.seeded(state);
  }

  Sink<dynamic> get listener => _listenerController.sink;

  Stream<T> get stateStream => controller.stream;
  Stream<dynamic> get listenerStream => _listenerController.stream;

  T get state => controller.value;

  void emit(T state){
    controller.sink.add(state);
  }

  void dispose(){
    controller.close();
    _listenerController.close();
  }
}