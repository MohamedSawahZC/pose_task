import 'package:clinic_mobile/controllers/add_note/states.dart';
import 'package:clinic_mobile/controllers/home_screen/cubit.dart';
import 'package:clinic_mobile/controllers/option/states.dart';
import 'package:clinic_mobile/shared/network/dio_helper.dart';
import 'package:clinic_mobile/shared/network/end_points.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sqflite/sqflite.dart';

import '../../models/note.dart';
import '../../models/user_model.dart';

class OptionsCubit extends Cubit<OptionsStates> {
  OptionsCubit() : super(OptionsInitialStates());

  static OptionsCubit get(context) => BlocProvider.of(context);

  bool isSwitched = false;
  void changeSwitch(){
    isSwitched = !isSwitched;
    emit(SwitchChangeState());
  }


}
