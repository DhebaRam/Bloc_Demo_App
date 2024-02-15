part of 'profile_bloc.dart';

@immutable
abstract class ProfileEvent {}

class FetchUserProfileDataEvent extends ProfileEvent{}
