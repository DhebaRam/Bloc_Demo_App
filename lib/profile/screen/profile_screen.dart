import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sizer/sizer.dart';
import 'package:untitled/profile/models/user_profile_model.dart';
import 'package:untitled/profile/profile_bloc/profile_bloc.dart';
import 'package:shimmer/shimmer.dart';

import '../../routers/app_routers.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  ProfileScreenState createState() => ProfileScreenState();
}

class ProfileScreenState extends State<ProfileScreen> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    context.read<ProfileBloc>().add(FetchUserProfileDataEvent());
  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;

    return Container(
      child: Stack(
        children: <Widget>[
          Container(
            decoration: const BoxDecoration(
                gradient: LinearGradient(colors: [
              Color(0xFF26CBE6),
              Color(0xFF26CBC0),
            ], begin: Alignment.topCenter, end: Alignment.center)),
          ),
          Scaffold(
            backgroundColor: Colors.transparent,
            body: Stack(
              children: <Widget>[
                Align(
                  alignment: Alignment.center,
                  child: Padding(
                    padding: EdgeInsets.only(top: height / 10),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        CircleAvatar(
                          backgroundImage: const NetworkImage(
                              'https://img.freepik.com/free-photo/portrait-beautiful-woman_144627-7888.jpg?size=626&ext=jpg&ga=GA1.1.1855505643.1692086058&semt=ais'),
                          radius: height / 10,
                        ),
                        SizedBox(
                          height: height / 20,
                        ),
                        Text(
                          'Sadiq Mehdi',
                          style: TextStyle(
                              fontSize: 18.0,
                              color: Colors.white,
                              fontWeight: FontWeight.bold),
                        )
                      ],
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(top: height / 2.55),
                  child: Container(
                    color: Colors.white,
                  ),
                ),
                Padding(
                    padding: EdgeInsets.only(
                        top: height / 2.25,
                        left: width / 20,
                        right: width / 20),
                    child: BlocConsumer<ProfileBloc, ProfileState>(
                      listener: (context, state) {
                        // TODO: implement listener
                      },
                      builder: (context, state) {
                        if (state is FetchUserProfileDataSuccessState) {
                          return Column(children: <Widget>[
                            //       Container(
                            //         decoration: BoxDecoration(
                            //             color: Colors.white,
                            //             boxShadow: [
                            //               BoxShadow(
                            //                   color: Colors.black45,
                            //                   blurRadius: 2.0,
                            //                   offset: Offset(0.0, 2.0))
                            //             ]),
                            //         child: Padding(
                            //           padding: EdgeInsets.all(width / 20),
                            //           child: Row(
                            //               mainAxisAlignment: MainAxisAlignment.center,
                            //               children: <Widget>[
                            //                 headerChild('Photos', 114),
                            //                 headerChild('Followers', 1205),
                            //                 headerChild('Following', 360),
                            //               ]),
                            //         ),
                            //       ),
                            //       Padding(
                            //         padding: EdgeInsets.only(top: height / 20),
                            //         child: Column(
                            //           children: <Widget>[
                            //             infoChild(
                            //                 width, Icons.email, 'zulfiqar108@gmail.com'),
                            //             infoChild(width, Icons.call, '+12-1234567890'),
                            //             infoChild(
                            //                 width, Icons.group_add, 'Add to group'),
                            //             infoChild(width, Icons.chat_bubble,
                            //                 'Show all comments'),
                            //             Padding(
                            //               padding: EdgeInsets.only(top: height / 30),
                            //               child: Container(
                            //                 width: width / 3,
                            //                 height: height / 20,
                            //                 decoration: BoxDecoration(
                            //                     color: const Color(0xFF26CBE6),
                            //                     borderRadius: BorderRadius.all(
                            //                         Radius.circular(height / 40)),
                            //                     boxShadow: [
                            //                       BoxShadow(
                            //                           color: Colors.black87,
                            //                           blurRadius: 2.0,
                            //                           offset: Offset(0.0, 1.0))
                            //                     ]),
                            //                 child: Center(
                            //                   child: Text('FOLLOW ME',
                            //                       style: TextStyle(
                            //                           fontSize: 12.0,
                            //                           color: Colors.white,
                            //                           fontWeight: FontWeight.bold)),
                            //                 ),
                            //               ),
                            //             )
                            //           ],
                            //         ),
                            //       )
                            //     ],
                            //   ),
                            // )
                            buildUserInfoDisplay(
                                '${state.userProfileData.name?.firstname ?? ''} ${state.userProfileData.name?.lastname ?? ''}',
                                'Name' /*EditNameFormPage()*/),
                            buildUserInfoDisplay(
                              '${state.userProfileData.phone}',
                              'Phone', /*EditPhoneFormPage()*/
                            ),
                            buildUserInfoDisplay(
                              '${state.userProfileData.email}',
                              'Email', /*EditEmailFormPage()*/
                            ),
                          ]);
                        }
                        return Column(children: <Widget>[
                          //       Container(
                          //         decoration: BoxDecoration(
                          //             color: Colors.white,
                          //             boxShadow: [
                          //               BoxShadow(
                          //                   color: Colors.black45,
                          //                   blurRadius: 2.0,
                          //                   offset: Offset(0.0, 2.0))
                          //             ]),
                          //         child: Padding(
                          //           padding: EdgeInsets.all(width / 20),
                          //           child: Row(
                          //               mainAxisAlignment: MainAxisAlignment.center,
                          //               children: <Widget>[
                          //                 headerChild('Photos', 114),
                          //                 headerChild('Followers', 1205),
                          //                 headerChild('Following', 360),
                          //               ]),
                          //         ),
                          //       ),
                          //       Padding(
                          //         padding: EdgeInsets.only(top: height / 20),
                          //         child: Column(
                          //           children: <Widget>[
                          //             infoChild(
                          //                 width, Icons.email, 'zulfiqar108@gmail.com'),
                          //             infoChild(width, Icons.call, '+12-1234567890'),
                          //             infoChild(
                          //                 width, Icons.group_add, 'Add to group'),
                          //             infoChild(width, Icons.chat_bubble,
                          //                 'Show all comments'),
                          //             Padding(
                          //               padding: EdgeInsets.only(top: height / 30),
                          //               child: Container(
                          //                 width: width / 3,
                          //                 height: height / 20,
                          //                 decoration: BoxDecoration(
                          //                     color: const Color(0xFF26CBE6),
                          //                     borderRadius: BorderRadius.all(
                          //                         Radius.circular(height / 40)),
                          //                     boxShadow: [
                          //                       BoxShadow(
                          //                           color: Colors.black87,
                          //                           blurRadius: 2.0,
                          //                           offset: Offset(0.0, 1.0))
                          //                     ]),
                          //                 child: Center(
                          //                   child: Text('FOLLOW ME',
                          //                       style: TextStyle(
                          //                           fontSize: 12.0,
                          //                           color: Colors.white,
                          //                           fontWeight: FontWeight.bold)),
                          //                 ),
                          //               ),
                          //             )
                          //           ],
                          //         ),
                          //       )
                          //     ],
                          //   ),
                          // )
                          Shimmer.fromColors(
                              baseColor: Colors.grey.shade300,
                              highlightColor: Colors.grey.shade100,
                              enabled: true,
                              child: SingleChildScrollView(
                                physics: const NeverScrollableScrollPhysics(),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisSize: MainAxisSize.max,
                                  children: [
                                    buildUserInfoDisplay(
                                      '',
                                      'Name', /*EditPhoneFormPage()*/
                                    ),
                                    buildUserInfoDisplay(
                                      '',
                                      'Phone', /*EditPhoneFormPage()*/
                                    ),
                                    buildUserInfoDisplay(
                                      '',
                                      'Email', /*EditEmailFormPage()*/
                                    ),
                                  ],
                                ),
                              )),
                        ]);
                      },
                    )),
                Positioned(right: 10.sp, top: 10.sp,child: InkWell(
                  child: Padding(
                      padding: EdgeInsets.symmetric(
                          vertical: 30.sp, horizontal: 10.sp),
                      child: Icon(
                        Icons.login_outlined,
                        color: Colors.white,
                        size: 25,
                      )),
                  onTap: () async{
                    SharedPreferences sharedPreference = await SharedPreferences.getInstance();
                    sharedPreference.clear();
                    Navigator.of(context).pushNamedAndRemoveUntil(AppRoutes.loginRoute, (Route<dynamic> route) => false);
                  },
                ),)
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget headerChild(String header, int value) => Expanded(
          child: Column(
        children: <Widget>[
          Text(header),
          SizedBox(
            height: 8.0,
          ),
          Text(
            '$value',
            style: TextStyle(
                fontSize: 14.0,
                color: const Color(0xFF26CBE6),
                fontWeight: FontWeight.bold),
          )
        ],
      ));

  Widget infoChild(double width, IconData icon, data) => Padding(
        padding: EdgeInsets.only(bottom: 8.0),
        child: InkWell(
          child: Row(
            children: <Widget>[
              SizedBox(
                width: width / 10,
              ),
              Icon(
                icon,
                color: const Color(0xFF26CBE6),
                size: 36.0,
              ),
              SizedBox(
                width: width / 20,
              ),
              Text(data)
            ],
          ),
          onTap: () {
            print('Info Object selected');
          },
        ),
      );

  // Widget builds the display item with the proper formatting to display the user's info
  Widget buildUserInfoDisplay(
    String getValue,
    String title,
    /*Widget? editPage*/
  ) =>
      Padding(
          padding: const EdgeInsets.only(bottom: 10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                textAlign: TextAlign.start,
                style: const TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.w500,
                  color: Colors.grey,
                ),
              ),
              const SizedBox(
                height: 1,
              ),
              Container(
                  width: 350,
                  height: 40,
                  decoration: const BoxDecoration(
                      border: Border(
                          bottom: BorderSide(
                    color: Colors.grey,
                    width: 1,
                  ))),
                  child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(
                            child: TextButton(
                                style: const ButtonStyle(
                                    alignment: Alignment.centerLeft),
                                onPressed: () {
                                  // navigateSecondPage(editPage);
                                },
                                child: Text(
                                  getValue,
                                  textAlign: TextAlign.start,
                                  style: const TextStyle(
                                      fontSize: 16, height: 1.4),
                                ))),
                        const Icon(
                          Icons.keyboard_arrow_right,
                          color: Colors.grey,
                          size: 40.0,
                        )
                      ]))
            ],
          ));
}
