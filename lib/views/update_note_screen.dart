import 'package:clinic_mobile/controllers/home_screen/cubit.dart';
import 'package:clinic_mobile/models/note.dart';
import 'package:clinic_mobile/shared/colors.dart';
import 'package:clinic_mobile/shared/components.dart';
import 'package:clinic_mobile/views/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:ms_widgets/ms_widgets.dart';

import '../controllers/edit_note/cubit.dart';
import '../controllers/edit_note/states.dart';

class EditNoteScreen extends StatefulWidget {
  final NoteModel model;
  EditNoteScreen({
    required this.model,
  });

  @override
  State<EditNoteScreen> createState() => _EditNoteScreenState();
}


class _EditNoteScreenState extends State<EditNoteScreen> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    noteController.text = widget.model.text;

  }
  var selectedItem;

  var noteController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;
    EditNoteCubit cubit = EditNoteCubit.get(context);
    return BlocConsumer<EditNoteCubit, EditNoteStates>(
      listener: (context, state) {
        if(state is UpdateNoteSuccessState){
          Fluttertoast.showToast(
              msg: "Note Updated successfully",
              toastLength: Toast.LENGTH_SHORT,
              gravity: ToastGravity.BOTTOM,
              timeInSecForIosWeb: 1,
              backgroundColor: Colors.green,
              textColor: Colors.white,
              fontSize: 16.0
          );
          navigate_to_and_finish(context, HomeScreen());
          HomeCubit.get(context).getAllNotes();
        }
      },
      builder: (context, state) {
        return Scaffold(
            backgroundColor: Colors.white,
            appBar: AppBar(
              backgroundColor: kPrimary,
              elevation: 5.0,
              actions: [
                IconButton(
                  onPressed: () {
                        cubit.updateNoteData(noteController.text,widget.model.id, selectedItem.id);
                  },
                  icon: Icon(Icons.save),
                ),
              ],
              title: Text(
                'Edit Note',
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
                    //TODO Search and Filter Bar
                    defaultTextFormField(
                      textFieldController: noteController,
                      width: width * 0.8,
                      filledColor: Colors.white,
                      borderColor: Colors.grey,
                      borderRadius: BorderRadius.circular(10),
                      contentPadding: EdgeInsets.all(10),
                      labelText: 'Note',
                      lineHeight: 10,
                    ),
                    SizedBox(
                      height: 20,
                    ),

                    SizedBox(
                      width: width*0.8,
                      child:DefaultDropDown(
                        items: cubit.users,
                        selectedItem: selectedItem,
                        onChanged: (item){
                          selectedItem=item;
                        },
                        label: 'Assign To user',
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
