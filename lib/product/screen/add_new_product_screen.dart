// ignore_for_file: use_build_context_synchronously

import 'dart:developer';
import 'dart:io';

import 'package:device_info_plus/device_info_plus.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:sizer/sizer.dart';

import '../../common/base_card.dart';
import '../../mongo_db/dbHelper/mongo_db_connect.dart';
import '../../mongo_db_screen/widget/text_form_field_widget.dart';
import '../../utis/color_config.dart';
import '../../utis/custom_dialog.dart';
import '../../utis/utils.dart';
import '../models/product_list_model.dart';
import 'package:mongo_dart/mongo_dart.dart' as objectVar;
import 'package:path/path.dart' as path;



class AddNewProductScreen extends StatefulWidget {
  const AddNewProductScreen({super.key});

  @override
  State<AddNewProductScreen> createState() => _AddNewProductScreenState();
}

class _AddNewProductScreenState extends State<AddNewProductScreen> {
  final _formKey = GlobalKey<FormState>();
  File? selectFile;
  String? fileName;
  List<int>? productImage;

  // Faker faker = Faker();
  // School school = School();
  final productNameController = TextEditingController(),
      productImageController = TextEditingController(),
      productDescriptionController = TextEditingController(),
      productCategoryController = TextEditingController(),
      productPriceController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
            automaticallyImplyLeading: false,
            flexibleSpace: Container(
              decoration: const BoxDecoration(
                  gradient: LinearGradient(colors: [
                Color(0xFF26CBE6),
                Color(0xFF26CBE0),
                Color(0xFF26CBD6),
                Color(0xFF26CBD0),
                Color(0xFF26CBC0),
              ], begin: Alignment.topCenter, end: Alignment.center)),
            ),
            actions: const [
              // IconButton(
              //   key: cartKey,
              //   icon: const Icon(Icons.add_shopping_cart,
              //       size: 26, weight: 0.01, color: Colors.white),
              //   onPressed: () {
              //     Navigator.of(context).push(MaterialPageRoute(
              //         builder: (context) => const ProductCartScreen()));
              //     // showBottomSheetWidget(context: context);
              //   },
              // ),
              SizedBox(width: 10)
            ],
            title: Text('New Product Add',
                    style: GoogleFonts.kanit().copyWith(
                        fontSize: 23,
                        fontWeight: FontWeight.w700,
                        color: Colors.white),
                    textAlign: TextAlign.center)
                .animate(onPlay: (controller) => controller.repeat()),
            // .shimmer(duration: 120000.ms, color: const Color(0xFF80DDFF))
            // .animate() // this wraps the previous Animate in another Animate
            // .fadeIn(duration: 1200.ms, curve: Curves.easeOutQuad)
            // .slide(),
            centerTitle: true),
        body: SingleChildScrollView(
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Container(
                  margin: const EdgeInsets.only(top: 130),
                  alignment: Alignment.topCenter,
                  child: MyTextFormField(
                    hintText: 'Product name',
                    isEmail: false,
                    controller: productNameController,
                    isPassword: false,
                    validator: (String value) {
                      if (value.isEmpty) {
                        return 'Enter your Product name';
                      }

                      return null;
                    },
                    onSaved: (String value) {
                      // school.schoolName = value;
                    },
                  ),
                ),
                MyTextFormField(
                  hintText: 'Product Description',
                  controller: productDescriptionController,
                  validator: (String value) {
                    if (value.isEmpty) {
                      return 'Enter the phone number';
                    }

                    return null;
                  },
                  onSaved: (String value) {
                    // school.schoolPhone = value;
                  },
                ),
                MyTextFormField(
                  hintText: 'Product Price',
                  controller: productPriceController,
                  validator: (String value) {
                    if (value.isEmpty) {
                      return 'Enter the email address';
                    }

                    return null;
                  },
                  onSaved: (String value) {
                    // school.schoolEmail = value;
                  },
                ),
                MyTextFormField(
                  hintText: 'Product Category',
                  isEmail: true,
                  controller: productCategoryController,
                  validator: (String value) {
                    if (value.isEmpty) {
                      return "Enter the school's website";
                    }

                    return null;
                  },
                  onSaved: (String value) {
                    // school.schoolWebsite = value;
                  },
                ),
                Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 20, vertical: 10),
                    child: Row(
                      children: [
                        Text(fileName ?? ''),
                        const Spacer(),
                        InkWell(
                          onTap: () async {
                            File? file = await chooseProfileImage(context);
                            if (file != null) {
                              print('Original path: ${file.path}');
                              String dir = path.dirname(file.path);
                              String newPath =
                                  path.join(dir, 'Case01wd03id01.jpg');
                              print('NewPath: ${path.basename(newPath)}');
                              fileName = path.basename(newPath);
                              productImage = await file.readAsBytes();
                              selectFile = file;
                              setState(() {});
                            }
                          },
                          child: Container(
                            color: Colors.cyan,
                            margin: const EdgeInsets.symmetric(
                                horizontal: 0, vertical: 10),
                            padding: const EdgeInsets.symmetric(
                                horizontal: 20, vertical: 10),
                            child: const Text(
                              'Select Image',
                              textAlign: TextAlign.start,
                              style: TextStyle(
                                  fontWeight: FontWeight.w700, fontSize: 15),
                            ),
                          ),
                        ),
                      ],
                    )),
                Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 20, vertical: 10),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        // TextButton(
                        //   style: ButtonStyle(
                        //       backgroundColor: MaterialStateProperty.all(
                        //         Colors.grey[200],
                        //       ),
                        //       shape: MaterialStateProperty.all(
                        //           RoundedRectangleBorder(
                        //               borderRadius: BorderRadius.circular(10.0),
                        //               side: const BorderSide(
                        //                   color: Colors.grey, width: 2))),
                        //       padding: MaterialStateProperty.all(
                        //           const EdgeInsets.symmetric(horizontal: 30))),
                        //   onPressed: () {
                        //     setState(() {
                        //       schoolNameController.text =
                        //       '${faker.address.streetName()},  ${faker.address.city()}';
                        //       phoneController.text = faker.phoneNumber.us().toString();
                        //       emailController.text =
                        //       '${faker.address.streetName()},  ${faker.address.city()}@gmail.com';
                        //       schoolWebsiteController.text =
                        //           faker.job.title().toString();
                        //     });
                        //   },
                        //   child: const Text(
                        //     'Set Data',
                        //     style: TextStyle(
                        //         fontSize: 19,
                        //         color: Colors.black,
                        //         fontWeight: FontWeight.w700),
                        //   ),
                        // ),
                        TextButton(
                          style: ButtonStyle(
                              backgroundColor:
                                  MaterialStateProperty.all(Colors.grey[200]),
                              shape: MaterialStateProperty.all(
                                  RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(10.0),
                                      side: const BorderSide(
                                          color: Colors.grey, width: 2))),
                              padding: MaterialStateProperty.all(
                                  const EdgeInsets.symmetric(horizontal: 30))),
                          onPressed: () async {
                            if (_formKey.currentState!.validate()) {
                              _formKey.currentState!.save();
                              try {
                                final _firebaseStorage = FirebaseStorage.instance;
                                //Image name
                                final fileName = path.basename(selectFile!.path);
                                print('fileName---- ${fileName}');
                                //Upload to Firebase
                                var snapshot = await _firebaseStorage.ref().child('images/$fileName').putFile(selectFile!);
                                var downloadUrl = await snapshot.ref.getDownloadURL();
                                print('downloadUrl ----- ${downloadUrl}');
                                // return imageUrl;
                                ProductModel data = ProductModel(
                                    id: objectVar.ObjectId(),
                                    price: productPriceController.text.trim(),
                                    title: productNameController.text.trim(),
                                    category:
                                    productCategoryController.text.trim(),
                                    description: productDescriptionController.text.trim(),
                                    imageUrl: downloadUrl,
                                    image: [],
                                    rating: Rating.fromJson(
                                        {'count': 'esd', 'rate': 'dsf'}));
                                var result =
                                await MongodbDataBase.insertProduct(data);
                                print('Result Data----> ${result}');
                                // Navigator.push(context,
                                //     MaterialPageRoute(builder: (context) => SchoolRegTwo()));
                              } catch (e) {
                                print('Error uploading image: $e');
                                return;
                              }
                            }
                          },
                          child: const Text(
                            'Add Data',
                            style: TextStyle(
                                fontSize: 19,
                                color: Colors.black,
                                fontWeight: FontWeight.w700),
                          ),
                        )
                      ],
                    ))
              ],
            ),
          ),
        ));
  }

  Future<File?> chooseProfileImage(BuildContext context) async {
    File? file;
    await showCustomDialog(context, title: '', isCenter: true, children: [
      Row(
        children: [
          addText('Select Product Photo', 20, whiteColor, FontWeight.w500,
              fontFamily: 'TwCen'),
        ],
      ),
      spaceHeight(15),
      baseCardShadow(
          onTap: () async {
            try {
              if (!kIsWeb) {
                var status = await Permission.camera.request();
                print('Camera Permission Generate... $status');
                if (status != PermissionStatus.granted) {
                  return Future.error('Camera permissions are denied');
                }
              }
              FocusScope.of(context).unfocus();
              final result = await ImagePicker().pickImage(
                source: ImageSource.camera,
              );
              log('Pick Image Result.... ${result?.path}');
              if (result != null) file = File(result.path);
              log('Pick Image File.... ${file?.path}');
              if (context.mounted) Navigator.of(context).pop();
              // Navigator.pop(context);
            } catch (e) {
              log('Pick Image Catch.... ${e.toString()}');
              // showSnackBar(message: e.toString(), success: false);
            }
          },
          width: 60.w,
          height: 43,
          topLeftRadius: 10,
          topRightRadius: 10,
          bottomLeftRadius: 10,
          bottomRightRadius: 10,
          secondLeft: 4.0,
          secondTop: 4.0,
          secondBottom: 4.0,
          borderWidthThird: 1,
          borderColorThird: whiteColor,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              // SvgPicture.asset(
              //   LoyaltyIcons.camera,
              //   // width: 10,
              //   fit: BoxFit.fill,
              //   height: 20,
              //   color: ColorConstants.primaryProgessColor,
              // ),
              spaceWidth(15),
              addText(
                'Take Picture',
                14,
                whiteColor,
                FontWeight.w500,
              )
            ],
          )),
      spaceHeight(15),
      baseCardShadow(
          onTap: () async {
            try {
              if (!kIsWeb) {
                var status;
                final deviceInfo = await DeviceInfoPlugin().androidInfo;
                if (deviceInfo.version.sdkInt > 32) {
                  status = await Permission.photos.request();
                } else {
                  status = await Permission.storage.request();
                }
                // var status = await Permission.photos.request();
                print('Camera Permission Generate... $status');
                if (status != PermissionStatus.granted) {
                  await openAppSettings();
                  // return Future.error('Gallery permissions are denied');
                }
                if (status != PermissionStatus.granted) {
                  // await openAppSettings();
                  return Future.error('Gallery permissions are denied');
                }
              }
              FocusScope.of(context).unfocus();
              final result = await ImagePicker().pickImage(
                source: ImageSource.gallery,
              );
              if (result != null) file = File(result.path);
              if (context.mounted) Navigator.of(context).pop();
              // Navigator.pop(context);
            } catch (e) {
              log('Pick Image.... ${e.toString()}');
              // showSnackBar(message: e.toString(), success: false);
            }
          },
          width: 60.w,
          height: 43,
          topLeftRadius: 10,
          topRightRadius: 10,
          bottomLeftRadius: 10,
          bottomRightRadius: 10,
          secondLeft: 4.0,
          secondTop: 4.0,
          secondBottom: 4.0,
          borderWidthThird: 1,
          borderColorThird: whiteColor,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              // SvgPicture.asset(
              //   LoyaltyIcons.gallery,
              //   // width: 10,
              //   fit: BoxFit.fill,
              //   height: 20,
              //   color: ColorConstants.primaryProgessColor,
              // ),
              spaceWidth(15),
              addText(
                'Choose from Gallery',
                14,
                whiteColor,
                FontWeight.w500,
              )
            ],
          )),
      spaceHeight(20)
    ]);
    return file;
  }
}
