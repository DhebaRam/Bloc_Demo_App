part of 'profile_bloc.dart';

@immutable
abstract class ProfileState {}

class ProfileInitial extends ProfileState {}

class FetchUserProfileDataSuccessState extends ProfileState{
  final UserProfileModel userProfileData;
  FetchUserProfileDataSuccessState({required this.userProfileData});
}

class FetchUserProfileDataLoader extends ProfileState{}
class FetchUserProfileDataErrorLoader extends ProfileState{
  final String error;
  FetchUserProfileDataErrorLoader({required this.error});
}