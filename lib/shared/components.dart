import 'package:flutter/material.dart';

import '../models/note.dart';
import '../models/user_model.dart';


void navigate_to(context, widget) {
  Navigator.push(
    context,
    MaterialPageRoute(
      builder: (context) => widget,
    ),
  );
}

void navigate_to_and_finish(context, widget) {
  Navigator.pushAndRemoveUntil(
    context,
    MaterialPageRoute(
      builder: (context) => widget,
    ),
    (Route<dynamic> route) => false,
  );
}


class NoteItem extends StatelessWidget {
  final NoteModel model;
  final VoidCallback onPressed;
  NoteItem({
    required this.model,
    required this.onPressed,
});
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: Text(
            '${model.text}',
            style: TextStyle(
                color: Colors.black,
                fontSize: 16
            ),
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
          ),
        ),
        IconButton(onPressed: onPressed, icon: Icon(Icons.edit))

      ],
    );
  }
}

class DefaultTextFormField extends StatelessWidget {
  final String hintText;
  final String labelText;
  final Widget? prefixWidget;
  final Widget? suffixWidget;
  final Color borderColor;
  final Color? hintColor;
  final TextEditingController? textFieldController;
  final Function? suffixTap;
  final Function? validateTextField;
  final Function? onSubmit;
  final Color? filledColor;
  final Color? inputColor;
  final Color? labelColor;
  final bool isSecure;
  final int lineHeight;
  final double labelFontSize;
  final BorderRadius? borderRadius;
  final double hintFontSize;
  final double? width;
  final double? height;
  final bool enableEditing;
  final EdgeInsetsGeometry? contentPadding;
  final Function onChange;

  const DefaultTextFormField({
    Key? key,
    this.hintColor,
    this.labelColor,
    this.inputColor,
    this.contentPadding,
    this.width,
    this.height,
    required this.onChange,
    this.borderRadius= BorderRadius.zero,
    this.hintText='',
    this.labelText="",
    this.prefixWidget,
    this.suffixWidget,
    this.borderColor = Colors.blue,
    this.textFieldController,
    this.suffixTap,
    this.onSubmit,
    this.enableEditing = true,
    this.validateTextField,
    this.filledColor = Colors.lightBlue,
    this.isSecure = false,
    this.lineHeight = 1,
    this.labelFontSize = 16,
    this.hintFontSize = 16,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width,
      height: height,
      child: TextFormField(
        onFieldSubmitted: (String? value) {
          return onSubmit!(value);
        },
        enabled: enableEditing,
        textAlignVertical: TextAlignVertical.center,
        style: TextStyle(
          height: 2,
          color: inputColor,
        ),
        onChanged: (item){
          return onChange(item);
        },
        controller: textFieldController,
        obscureText: isSecure,
        maxLines: lineHeight,
        decoration: InputDecoration(
          floatingLabelBehavior: FloatingLabelBehavior.always,
          contentPadding: contentPadding,
          errorStyle: const TextStyle(
            fontSize: 16,
          ),
          filled: true,
          fillColor: filledColor,
          hintText: hintText,
          prefixIcon: prefixWidget,
          suffixIcon: suffixWidget,
          labelText: labelText,
          labelStyle: TextStyle(
            color: labelColor,
            fontSize: labelFontSize,
          ),
          hintStyle: TextStyle(
            fontSize: hintFontSize,
            color: hintColor,
          ),
          border: OutlineInputBorder(
            borderRadius: borderRadius! ,
            borderSide: BorderSide(
              color: borderColor,
              width: 0,
              style: BorderStyle.none,
            ),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: borderRadius!,
            borderSide: BorderSide(
              width: 0.5,
              style: BorderStyle.solid,
              color: borderColor,
            ),
          ),
          enabledBorder:OutlineInputBorder(
            borderRadius: borderRadius!,
            borderSide: BorderSide(
              width: 0.5,
              style: BorderStyle.solid,
              color: borderColor,
            ),
          ),
        ),
        validator: (String? value) {
          return validateTextField!(value);
        },

      ),
    );
  }
}

class DefaultDropDown extends StatelessWidget {
  final List items;
  late final selectedItem;
  final Function onChanged;
  final String label;
  DefaultDropDown({
    required this.items,
    required this.selectedItem,
    required this.onChanged,
    required this.label,
  });
  @override
  Widget build(BuildContext context) {
    return DropdownButtonFormField<dynamic>(
      items: items.map((item) => DropdownMenuItem<dynamic>(
        child: Center(
          child: Text(item.username,style: TextStyle(fontSize: 18,color: Colors.black),
          ),
        ),
        value: item,

      ),
      ).toList(),
      decoration: InputDecoration(
        labelText: label,
        filled: false,

        border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(20),
        ),
        enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(20),
        ),
        focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(20),
        ),
      ),
      onChanged: (item){
        return onChanged(item);
      },
      elevation: 5,
      borderRadius: BorderRadius.circular(20),
      hint: Center(
        child: Text(
          label,
        ),
      ),
      icon: Icon(Icons.arrow_drop_down_outlined),
isExpanded: true,

    );
  }
}


class DefaultDropDownForm extends StatelessWidget {
  final List items;
  late final selectedItem;
  final Function onChanged;
  final String label;
  DefaultDropDownForm({
    required this.items,
    required this.selectedItem,
    required this.onChanged,
    required this.label,
  });
  @override
  Widget build(BuildContext context) {
    return DropdownButtonFormField<dynamic>(
      items: items.map((item) => DropdownMenuItem<dynamic>(
        child: Center(
          child: Text(item.intrestText,style: TextStyle(fontSize: 18,color: Colors.black),
          ),
        ),
        value: item,

      ),
      ).toList(),
      decoration: InputDecoration(
        labelText: label,
        filled: false,

        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(0),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(0),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(0),
        ),
      ),
      onChanged: (item){
        return onChanged(item);
      },
      elevation: 5,
      borderRadius: BorderRadius.circular(0),
      hint: Center(
        child: Text(
          label,
        ),
      ),
      icon: Icon(Icons.arrow_drop_down_outlined),
      isExpanded: true,

    );
  }
}



