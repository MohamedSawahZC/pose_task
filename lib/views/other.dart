import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';

import 'package:clinic_mobile/controllers/add_note/cubit.dart';
import 'package:clinic_mobile/controllers/add_user/cubit.dart';
import 'package:clinic_mobile/controllers/add_user/states.dart';
import 'package:clinic_mobile/controllers/home_screen/cubit.dart';
import 'package:clinic_mobile/controllers/other/states.dart';
import 'package:clinic_mobile/shared/colors.dart';
import 'package:clinic_mobile/views/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_picker/image_picker.dart';
import 'package:ms_widgets/ms_widgets.dart';

import '../controllers/add_note/states.dart';
import '../controllers/other/cubit.dart';
import '../shared/components.dart';

class OtherScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;
    OtherCubit cubit = OtherCubit.get(context);

    return BlocConsumer<OtherCubit, OtherStates>(
      listener: (context, state) {
        if (state is ClearSuccessState) {
          Fluttertoast.showToast(
              msg: "Clear Done",
              toastLength: Toast.LENGTH_SHORT,
              gravity: ToastGravity.BOTTOM,
              timeInSecForIosWeb: 1,
              backgroundColor: Colors.green,
              textColor: Colors.white,
              fontSize: 16.0
          );
          HomeCubit.get(context).getAllNotes();
        }
        if (state is ResetSuccessState) {
          Fluttertoast.showToast(
              msg: "Reset Done",
              toastLength: Toast.LENGTH_SHORT,
              gravity: ToastGravity.BOTTOM,
              timeInSecForIosWeb: 1,
              backgroundColor: Colors.green,
              textColor: Colors.white,
              fontSize: 16.0
          );
          HomeCubit.get(context).getAllNotes();
        }

      },
      builder: (context, state) {
        return Scaffold(
            backgroundColor: Colors.white,

            appBar: AppBar(
              centerTitle: true,
              backgroundColor: kPrimary,
              elevation: 5.0,
              title: Text(
                'Other',
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
                    SizedBox(
                      width: width*0.8,
                        child: ElevatedButton(
                          onPressed: (){
                            cubit.resetDummy();
                          }, child: Text('Reset Dummy',style: TextStyle(color: Colors.white),),
                          style: ButtonStyle(
                            backgroundColor: MaterialStateProperty.all<Color>(kPrimary),
                          ),
                        ),
                    ),
                    SizedBox(
                        width: width*0.8,
                        child: ElevatedButton(
                          onPressed: (){
                          cubit.clearNotes();
                        }, child: Text('Clear Notes'),
                          style: ButtonStyle(
                            backgroundColor: MaterialStateProperty.all<Color>(Colors.red),
                          ),
                        )
                    ),
                  ],
                ),
              ),
            ));
      },
    );
  }
}
