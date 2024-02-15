import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'custom_navigation_bar_event.dart';

part 'custom_navigation_bar_state.dart';

class CustomNavigationBarBloc
    extends Bloc<CustomNavigationBarEvent, CustomNavigationBarState> {
  CustomNavigationBarBloc()
      : super(const CustomNavigationBarInitial(tabIndex: 0)) {
    on<CustomNavigationBarEvent>((event, emit) {
      if (event is TabChange) {
        print(event.tabIndex);
        emit(CustomNavigationBarInitial(tabIndex: event.tabIndex));
      }
    });
  }
}
