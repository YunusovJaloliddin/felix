import 'package:flutter/material.dart';

class CustomTextField extends StatelessWidget {
  final String mainText;
  final String hintText;
  final TextEditingController? controller;
  final Widget? leading;
  final int? maxLines;
  final bool address;

  const CustomTextField({
    required this.mainText,
    required this.hintText,
    this.controller,
    this.leading,
    this.maxLines,
    required this.address,
    super.key,
  });

  String? validate (String? value){
    if(value == ""){
      return "Incorrect";
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          mainText,
          style: Theme.of(context).textTheme.titleMedium?.copyWith(
            color: const Color(0xFF232638),
          ),
        ),
        const SizedBox(height: 5),
        TextFormField(
          validator: !address?validate:null,
          textInputAction: TextInputAction.next,
          controller: controller,
          maxLines: maxLines??1,
          decoration: InputDecoration(
            contentPadding: const EdgeInsets.only(left: 10),
            hintText: hintText,
            hintStyle: const TextStyle(
              color: Color(0xFF949CA9),
            ),
            enabledBorder: const OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(10)),
              borderSide: BorderSide(
                color: Color(0xFFE7ECF3),
                width: 2,
              ),
            ),
            errorBorder: const OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(15)),
              borderSide: BorderSide(
                color: Color(0xFFF5082E),
                width: 2,
              ),
            ),
            focusedErrorBorder: const OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(15)),
              borderSide: BorderSide(
                color: Color(0xFFF5082E),
                width: 2,
              ),
            ),
            focusedBorder: const OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(15)),
              borderSide: BorderSide(
                color: Color(0xFF01001F),
                width: 2,
              ),
            ),
          ),
        ),
        const SizedBox(height: 8),
      ],
    );
  }
}
