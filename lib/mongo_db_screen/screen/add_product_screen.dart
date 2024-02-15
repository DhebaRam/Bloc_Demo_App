import 'package:faker/faker.dart';
import 'package:flutter/material.dart';

import '../../mongo_db/dbHelper/mongo_db_connect.dart';
import '../model/data_model.dart';
import '../widget/text_form_field_widget.dart';

class AddProductScreen extends StatefulWidget {
  const AddProductScreen({super.key});

  @override
  State<AddProductScreen> createState() => _AddProductScreenState();
}

class _AddProductScreenState extends State<AddProductScreen> {
  final _formKey = GlobalKey<FormState>();
  Faker faker = Faker();
  School school = School();
  final schoolNameController = TextEditingController(),
      phoneController = TextEditingController(),
      emailController = TextEditingController(),
      schoolWebsiteController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SingleChildScrollView(
      child: Form(
        key: _formKey,
        child: Column(
          children: <Widget>[
            Container(
              margin: const EdgeInsets.only(top: 130),
              alignment: Alignment.topCenter,
              child: MyTextFormField(
                hintText: 'School name',
                isEmail: false,
                controller: schoolNameController,
                isPassword: false,
                validator: (String value) {
                  if (value.isEmpty) {
                    return 'Enter your school name';
                  }

                  return null;
                },
                onSaved: (String value) {
                  school.schoolName = value;
                },
              ),
            ),
            MyTextFormField(
              hintText: 'Phone',
              controller: phoneController,
              validator: (String value) {
                if (value.isEmpty) {
                  return 'Enter the phone number';
                }

                return null;
              },
              onSaved: (String value) {
                school.schoolPhone = value;
              },
            ),
            MyTextFormField(
              hintText: 'Email',
              controller: emailController,
              validator: (String value) {
                if (value.isEmpty) {
                  return 'Enter the email address';
                }

                return null;
              },
              onSaved: (String value) {
                school.schoolEmail = value;
              },
            ),
            MyTextFormField(
              hintText: 'School Website',
              isEmail: true,
              controller: schoolWebsiteController,
              validator: (String value) {
                if (value.isEmpty) {
                  return "Enter the school's website";
                }

                return null;
              },
              onSaved: (String value) {
                school.schoolWebsite = value;
              },
            ),
            Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    TextButton(
                      style: ButtonStyle(
                          backgroundColor: MaterialStateProperty.all(
                            Colors.grey[200],
                          ),
                          shape: MaterialStateProperty.all(
                              RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10.0),
                                  side: const BorderSide(
                                      color: Colors.grey, width: 2))),
                          padding: MaterialStateProperty.all(
                              const EdgeInsets.symmetric(horizontal: 30))),
                      onPressed: () {
                        setState(() {
                          schoolNameController.text =
                              '${faker.address.streetName()},  ${faker.address.city()}';
                          phoneController.text = faker.phoneNumber.us().toString();
                          emailController.text =
                              '${faker.address.streetName()},  ${faker.address.city()}@gmail.com';
                          schoolWebsiteController.text =
                              faker.job.title().toString();
                        });
                      },
                      child: const Text(
                        'Set Data',
                        style: TextStyle(
                            fontSize: 19,
                            color: Colors.black,
                            fontWeight: FontWeight.w700),
                      ),
                    ),
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
                          School data = School(
                              schoolName: schoolNameController.text.trim(),
                              schoolEmail: emailController.text.trim(),
                              schoolPhone: phoneController.text.trim(),
                              schoolWebsite:
                                  schoolWebsiteController.text.trim());
                          var result = await MongodbDataBase.insert(data);
                          print('Result Data----> ${result}');
                          // Navigator.push(context,
                          //     MaterialPageRoute(builder: (context) => SchoolRegTwo()));
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
}
