import 'dart:async';
import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

import '../../product/reps/product_repo.dart';
import '../models/user_profile_model.dart';

part 'profile_event.dart';
part 'profile_state.dart';

class ProfileBloc extends Bloc<ProfileEvent, ProfileState> {
  ProfileBloc() : super(ProfileInitial()) {
    on<FetchUserProfileDataEvent>(_getProfileData);
  }

  Future<FutureOr<void>> _getProfileData(ProfileEvent event, Emitter<ProfileState> emit) async {
    try {
      UserProfileModel userProfileModel = UserProfileModel();
      emit(FetchUserProfileDataLoader());
      final response = await ProductRepos().fetchUserProfileData();
      userProfileModel = UserProfileModel.fromJson(response.data);
      emit(FetchUserProfileDataSuccessState(userProfileData: userProfileModel));
    }catch(e){
      emit(FetchUserProfileDataErrorLoader(error: e.toString()));
      log(e.toString());
    }
  }
}
