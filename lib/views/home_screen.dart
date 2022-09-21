import 'package:clinic_mobile/controllers/home_screen/cubit.dart';
import 'package:clinic_mobile/controllers/home_screen/states.dart';
import 'package:clinic_mobile/shared/colors.dart';
import 'package:clinic_mobile/shared/components.dart';
import 'package:clinic_mobile/views/options_screen.dart';
import 'package:clinic_mobile/views/update_note_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'add_note.dart';
import 'add_user.dart';

class HomeScreen extends StatelessWidget {
  @override
  var selectedItem;
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;
    HomeCubit cubit = HomeCubit.get(context);
    return BlocConsumer<HomeCubit, HomeStates>(
      listener: (context, state) {},
      builder: (context, state) {
        return Scaffold(
            backgroundColor: Colors.white,
            floatingActionButton: FloatingActionButton(
              backgroundColor: kPrimary,
              onPressed: () {
                navigate_to(context, AddNoteScreen());
              },
              child: Icon(Icons.add),
            ),
            appBar: AppBar(
              backgroundColor: kPrimary,
              elevation: 5.0,
              actions: [
                IconButton(
                  onPressed: () {
                    navigate_to(context, AddUserScreen());
                  },
                  icon: Icon(Icons.add),
                ),
                IconButton(
                  onPressed: () {
                    navigate_to(context, OptionsScreen());
                  },
                  icon: Icon(Icons.settings),
                ),
                IconButton(
                  onPressed: () {},
                  icon: Icon(Icons.menu),
                ),
              ],
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
                    //TODO Search and Filter Bar
                    Row(
                      children: [
                        IconButton(
                          onPressed: () {
                            cubit.ShowFilter();
                          },
                          icon: Icon(
                            Icons.filter_list,
                            color: kPrimary,
                          ),
                        ),
                        IconButton(
                          onPressed: () {
                            cubit.ShowSearch();
                          },
                          icon: const Icon(
                            Icons.search,
                            color: kPrimary,
                          ),
                        ),
                        cubit.DisplaySearch
                            ? DefaultTextFormField(
                                filledColor: Colors.white,
                                borderColor: Colors.grey,
                                width: width * 0.62,
                                borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(20),
                                  bottomRight: Radius.circular(20),
                                  bottomLeft: Radius.circular(20),
                                ),
                                onChange: (item) {
                                  cubit.searchByText(item);
                                },
                                suffixWidget: IconButton(
                                  icon: Icon(Icons.cancel, color: kCrimson),
                                  onPressed: () {
                                    cubit.ShowSearch();
                                  },
                                ),
                                contentPadding: EdgeInsets.symmetric(
                                    horizontal: 8, vertical: 0),
                                hintText: 'Enter Search Text Here',
                              )
                            : Spacer(),
                      ],
                    ),
                    cubit.DisplayFilter
                        ? DefaultDropDown(
                            items: cubit.users,
                            selectedItem: selectedItem,
                            onChanged: (item) {
                              cubit.filterByUser(item.id);
                              
                            },
                            label: 'Select User',
                          )
                        : SizedBox(),
                    //=============== List of notes =================
                    SizedBox(
                      height: height * 0.8,
                      width: width,
                      child: ListView.separated(
                          itemBuilder: (context, index) => NoteItem(
                              model: cubit.DisplayFilter
                                  ? cubit.filter[index]
                                  : cubit.DisplaySearch
                                      ? cubit.search[index]
                                      : cubit.notes[index],
                              onPressed: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => EditNoteScreen(
                                          model: cubit.DisplayFilter
                                              ? cubit.filter[index]
                                              : cubit.DisplaySearch
                                                  ? cubit.search[index]
                                                  : cubit.notes[index]),
                                    ));
                              }),
                          separatorBuilder: (context, index) => SizedBox(
                                height: 5,
                              ),
                          itemCount: cubit.DisplayFilter
                              ? cubit.filter.length
                              : cubit.DisplaySearch
                                  ? cubit.search.length
                                  : cubit.notes.length),
                    ),
                  ],
                ),
              ),
            ));
      },
    );
  }
}
