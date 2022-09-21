import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';

import 'package:clinic_mobile/controllers/add_note/cubit.dart';
import 'package:clinic_mobile/controllers/add_user/cubit.dart';
import 'package:clinic_mobile/controllers/add_user/states.dart';
import 'package:clinic_mobile/controllers/home_screen/cubit.dart';
import 'package:clinic_mobile/shared/colors.dart';
import 'package:clinic_mobile/views/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_picker/image_picker.dart';
import 'package:ms_widgets/ms_widgets.dart';

import '../controllers/add_note/states.dart';
import '../shared/components.dart';

class AddUserScreen extends StatefulWidget {
  @override
  State<AddUserScreen> createState() => _AddUserScreenState();
}

class _AddUserScreenState extends State<AddUserScreen> {
  var selectedItem;

  var usernameController = TextEditingController();
  var emailController = TextEditingController();
  var passwordController = TextEditingController();
  var ImageBase64;
  File? _image;
  Uint8List? bytes;
  final ImagePicker _picker = ImagePicker();
  // Pick an image
  //TODO Pick Image Method
  void PickImage() async {
    final XFile? image = await _picker.pickImage(source: ImageSource.gallery);
    _image = File(image!.path);
    bytes = File(_image!.path).readAsBytesSync();
    ImageBase64 = base64Encode(bytes!);
  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;
    AddUserCubit cubit = AddUserCubit.get(context);

    return BlocConsumer<AddUserCubit, AddUserStates>(
      listener: (context, state) {
        if (state is AddUserSuccessState) {
          Fluttertoast.showToast(
              msg: "User Added successfully",
              toastLength: Toast.LENGTH_SHORT,
              gravity: ToastGravity.BOTTOM,
              timeInSecForIosWeb: 1,
              backgroundColor: Colors.green,
              textColor: Colors.white,
              fontSize: 16.0);
          navigate_to(context, HomeScreen());
        }
        if(state is AddUserLoadingState){
          Fluttertoast.showToast(
              msg: "Wait User creating",
              toastLength: Toast.LENGTH_SHORT,
              gravity: ToastGravity.BOTTOM,
              timeInSecForIosWeb: 1,
              backgroundColor: Colors.amberAccent,
              textColor: Colors.white,
              fontSize: 16.0);
        }
      },
      builder: (context, state) {
        return Scaffold(
            backgroundColor: Colors.white,
            floatingActionButton: FloatingActionButton(
              backgroundColor: kPrimary,
              onPressed: () {
                cubit.AddUser(usernameController.text, passwordController.text,
                    emailController.text, ImageBase64, selectedItem.id,context);
              },
              child: Icon(Icons.save),
            ),
            appBar: AppBar(
              centerTitle: true,
              backgroundColor: kPrimary,
              elevation: 5.0,
              title: Text(
                'Add User',
                style: TextStyle(
                  color: Colors.white,
                ),
              ),
            ),
            body: Padding(
              padding: EdgeInsets.all(30),
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    //TODO Image Picker Widget
                    Center(
                      child: ClipOval(
                        child: Material(
                          color: Colors.blue, // Button color
                          child: InkWell(
                            splashColor: Colors.red, // Splash color
                            onTap: () {
                              PickImage();
                            },
                            child: SizedBox(
                              width: 100,
                              height: 100,
                              child: Icon(
                                Icons.camera_alt,
                                color: Colors.white,
                                size: 60,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: height * 0.05,
                    ),
                    defaultTextFormField(
                      contentPadding: EdgeInsets.symmetric(horizontal: 10),
                      hintText: 'Enter username',
                      filledColor: Colors.white,
                      textFieldController: usernameController,
                      prefixWidget: Icon(Icons.account_circle),
                      labelText: 'Username',
                    ),
                    SizedBox(
                      height: height * 0.02,
                    ),
                    defaultTextFormField(
                      contentPadding: EdgeInsets.symmetric(horizontal: 10),
                      isSecure: cubit.isPassword,
                      textFieldController: passwordController,
                      hintText: 'Enter your password',
                      filledColor: Colors.white,
                      labelText: 'Password',
                      prefixWidget: Icon(Icons.lock),
                      suffixWidget: IconButton(
                        onPressed: () {
                          cubit.changePasswordVisibility();
                        },
                        icon: Icon(cubit.suffix),
                      ),
                    ),
                    SizedBox(
                      height: height * 0.02,
                    ),
                    defaultTextFormField(
                      contentPadding: EdgeInsets.symmetric(horizontal: 10),
                      hintText: 'Enter your email',
                      textFieldController: emailController,
                      filledColor: Colors.white,
                      labelText: 'Email',
                      prefixWidget: Icon(Icons.email),
                    ),
                    SizedBox(
                      height: height * 0.02,
                    ),
                    SizedBox(
                      width: width * 0.9,
                      height: height * 0.05,
                      child: DefaultDropDownForm(
                        items: cubit.InterestData,
                        selectedItem: selectedItem,
                        onChanged: (item) {
                          selectedItem = item;
                        },
                        label: 'Select Interest',
                      ),
                    ),
                  ],
                ),
              ),
            ));
      },
    );
  }
}
