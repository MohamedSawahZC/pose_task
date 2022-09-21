import 'package:clinic_mobile/controllers/add_note/cubit.dart';
import 'package:clinic_mobile/controllers/home_screen/cubit.dart';
import 'package:clinic_mobile/shared/colors.dart';
import 'package:clinic_mobile/shared/components.dart';
import 'package:clinic_mobile/views/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:ms_widgets/ms_widgets.dart';

import '../controllers/add_note/states.dart';

class AddNoteScreen extends StatelessWidget {
  @override
  var selectedItem;
  var noteController = TextEditingController();
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;
    AddNoteCubit cubit = AddNoteCubit.get(context);

    return BlocConsumer<AddNoteCubit, AddNoteStates>(
      listener: (context, state) {
        if(state is AddNoteSuccessState){
          Fluttertoast.showToast(
              msg: "Note Added successfully",
              toastLength: Toast.LENGTH_SHORT,
              gravity: ToastGravity.BOTTOM,
              timeInSecForIosWeb: 1,
              backgroundColor: Colors.green,
              textColor: Colors.white,
              fontSize: 16.0
          );
          navigate_to(context, HomeScreen());
        }
      },
      builder: (context, state) {
        return Scaffold(
            backgroundColor: Colors.white,
            floatingActionButton: FloatingActionButton(
              backgroundColor: kPrimary,
              onPressed: () {
                cubit.InsertNote(noteController.text, selectedItem.id, '2021-11-18T09:39:44',context);
              },
              child: Icon(Icons.save),
            ),

            appBar: AppBar(
              centerTitle: true,
              backgroundColor: kPrimary,
              elevation: 5.0,
              title: Text(
                'Notes',
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
                    DefaultDropDown(
                      items: cubit.users,
                      selectedItem: selectedItem,
                      onChanged: (item){
                        selectedItem=item;
                      },
                      label: 'Assign To user',
                    ),
                    SizedBox(
                      height: height*0.03,
                    ),
                    defaultTextFormField(
                      borderRadius: BorderRadius.circular(20),
                      borderColor: Colors.grey,
                      textFieldController: noteController,
                      width: width*0.9,
                      filledColor: Colors.white,
                      labelText: 'Enter note Text',
                      contentPadding: EdgeInsets.symmetric(horizontal: 10),
                      hintText: 'Enter note',
                      lineHeight: 7,
                    )
                  ],
                ),
              ),
            ));
      },
    );
  }
}
