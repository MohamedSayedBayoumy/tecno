// import 'package:flutter/material.dart';
// import 'package:get/get.dart';

// // import '../../Constants/colors.dart';

// class textField extends StatelessWidget {
//   String? initialValue;
//   bool? obsecure;
//   Function(String) action;
//   Widget? prefix, suffix;
//   String? hint, label;
//   TextInputType? type;
//   TextEditingController? controller;
//   int? maxLines;

//   textField(
//       {this.initialValue,
//       required this.action,
//       this.obsecure,
//       this.prefix,
//       this.hint,
//       this.label,
//       this.suffix,
//       this.type,
//       this.controller,
//       this.maxLines});

//   @override
//   Widget build(BuildContext context) {
//     return TextFormField(
//       validator: (value) {
//         if (value == null || value.isEmpty) {
//           return 'required'.tr;
//         }
//         return null;
//       },
//       controller: controller,
//       keyboardType: type,
//       initialValue: initialValue,
//       obscureText: obsecure ?? false,
//       onChanged: action,
//       maxLines: maxLines,
//       decoration: InputDecoration(
//         hintText: hint,
//         labelText: label,
//         hintStyle: const TextStyle(fontSize: 12),
//         labelStyle: const TextStyle(fontSize: 12),
//         prefixIcon: prefix,
//         suffixIcon: suffix,
//         // enabledBorder: OutlineInputBorder(
//         //   borderSide: BorderSide(
//         //     color: textFieldBackGround,
//         //   ),
//         //   borderRadius: BorderRadius.circular(15),
//         // ),
//         // focusedBorder: OutlineInputBorder(
//         //   borderSide: BorderSide(
//         //     color: textFieldBackGround,
//         //   ),
//         //   borderRadius: BorderRadius.circular(15),
//         // ),
//         // errorBorder: OutlineInputBorder(
//         //   borderSide: const BorderSide(
//         //     color: Colors.red,
//         //   ),
//         //   borderRadius: BorderRadius.circular(15),
//         // ),
//         // focusedErrorBorder: OutlineInputBorder(
//         //   borderSide: const BorderSide(
//         //     color: Colors.red,
//         //   ),
//         //   borderRadius: BorderRadius.circular(15),
//         // ),
//       ),
//     );
//   }
// }
