part of 'custom_navigation_bar_bloc.dart';

@immutable
abstract class CustomNavigationBarState {
  final int tabIndex;

  const CustomNavigationBarState({required this.tabIndex});
  // int get selectedIndex => 0;
}

class CustomNavigationBarInitial extends CustomNavigationBarState {
  const CustomNavigationBarInitial({required super.tabIndex});
}
