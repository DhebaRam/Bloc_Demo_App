part of 'custom_navigation_bar_bloc.dart';

@immutable
abstract class CustomNavigationBarEvent {
}


class TabChange extends CustomNavigationBarEvent {
  final int tabIndex;
  TabChange({required this.tabIndex});
}