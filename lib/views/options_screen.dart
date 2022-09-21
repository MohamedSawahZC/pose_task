import 'package:clinic_mobile/controllers/add_note/cubit.dart';
import 'package:clinic_mobile/controllers/home_screen/cubit.dart';
import 'package:clinic_mobile/controllers/option/cubit.dart';
import 'package:clinic_mobile/controllers/option/states.dart';
import 'package:clinic_mobile/shared/colors.dart';
import 'package:clinic_mobile/shared/components.dart';
import 'package:clinic_mobile/shared/network/cache_helper.dart';
import 'package:clinic_mobile/views/home_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:ms_widgets/ms_widgets.dart';

import '../controllers/add_note/states.dart';

class OptionsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;
    OptionsCubit cubit = OptionsCubit.get(context);

    return BlocConsumer<OptionsCubit, OptionsStates>(
      listener: (context, state) {

      },
      builder: (context, state) {
        return Scaffold(
            backgroundColor: Colors.white,

            appBar: AppBar(
              centerTitle: true,
              backgroundColor: kPrimary,
              elevation: 5.0,
              title: Text(
                'Options',
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
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Text('Use Local Database',style: TextStyle(
                          fontSize: 24,
                          color: Colors.grey[700],
                          fontWeight: FontWeight.bold
                        ),),
                        CupertinoSwitch(
                          value: CasheHelper.getData(key: 'switch') ?? false,
                          onChanged: (value) {
                            cubit.changeSwitch();
                            CasheHelper.saveData(key: 'switch', value: value);
                          },
                        ),
                      ],
                    )
                  ],
                ),
              ),
            ));
      },
    );
  }
}
