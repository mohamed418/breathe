// ignore_for_file: avoid_types_as_parameter_names, non_constant_identifier_names, avoid_print

import 'package:flutter/material.dart';

double height(context, double num) => MediaQuery.of(context).size.height * num;

double width(context, double num) => MediaQuery.of(context).size.width * num;

ShaderMask iconSh(icon, {double? size}) => ShaderMask(
      blendMode: BlendMode.srcATop,
      shaderCallback: (Rect bounds) => const LinearGradient(
        colors: <Color>[
          Color.fromRGBO(27, 200, 234, 1),
          Color.fromRGBO(194, 37, 104, 1),
        ],
      ).createShader(bounds),
      child: Icon(
        icon,
        size: size,
      ),
    );

buildSnackBar(String? message, context, duration) {
  return ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      content: Text(
        message!,
      ),
      duration: Duration(seconds: duration),
    ),
  );
}

Color defaultColor = const Color(0xff0873bb);

void navigateTo(Widget, context) => Navigator.pushReplacement(
      context,
      PageRouteBuilder(
        transitionDuration: const Duration(milliseconds: 500),
        pageBuilder: (context, animation, _) {
          return FadeTransition(
            opacity: animation,
            child: Widget,
          );
        },
      ),
    );

void navigateAndFinish(Widget, context) => Navigator.pushAndRemoveUntil(
      context,
      PageRouteBuilder(
        transitionDuration: const Duration(milliseconds: 500),
        pageBuilder: (context, animation, _) {
          return FadeTransition(
            opacity: animation,
            child: Widget,
          );
        },
      ),
      (route) => false,
    );

void printFullText(String text) {
  final pattern = RegExp('.{1,800}'); // 800 is the size of each chunk
  pattern.allMatches(text).forEach((match) => print(match.group(0)));
}

String token = '';

LinearGradient gradient = LinearGradient(
  // begin: Alignment.topLeft,
  // end: Alignment.bottomRight,
  colors: <Color>[
    Colors.blue.shade200,
    Colors.blue.shade300,
    Colors.blue.shade400,
    Colors.blue.shade500,
    Colors.blue.shade600,
    Colors.blue.shade700,
    Colors.blue.shade800,
  ],
);
LinearGradient gradient2 = const LinearGradient(
  // begin: Alignment.topLeft,
  // end: Alignment.bottomRight,
  colors: <Color>[
    Color.fromRGBO(27, 200, 234, 1),
    Color.fromRGBO(194, 37, 104, 1),
  ],
);

ShaderMask shadeMask(text, style) => ShaderMask(
      blendMode: BlendMode.srcIn,
      shaderCallback: (rect) => LinearGradient(
        // begin: Alignment.topLeft,
        // end: Alignment.bottomRight,
        colors: <Color>[
          Colors.blue.shade300,
          Colors.blue.shade400,
          Colors.blue.shade500,
          Colors.blue.shade600,
          Colors.blue.shade700,
          Colors.blue.shade800,
          Colors.blue.shade900,
        ],
      ).createShader(rect),
      child: Text(
        text,
        style: style,
      ),
    );

Widget defaultFormField({
  required TextEditingController? controller,
  required TextInputType? type,
  TextInputAction? action,
  Function? onSubmit,
  Function? onChange,
  Function? onTap,
  bool isPassword = false,
  required Function validate,
  required String? label,
  String? hint,
  required IconData? prefix,
  IconData? suffix,
  Function? suffixPressed,
  bool isClickable = true,
  int maxLines = 1,

  // ignore: use_function_type_syntax_for_parameters
}) =>
    TextFormField(
      onTap: () {
        //onTap!();
      },
      controller: controller,
      keyboardType: type,
      obscureText: isPassword,
      textInputAction: action,
      maxLines: maxLines,
      enabled: isClickable,
      //style: GoogleFonts.cairo(),
      onFieldSubmitted: (s) {
        onSubmit!(s);
      },
      onChanged: (s) {
        //onChange!(s);
      },
      validator: (value) {
        return validate(value);
      },
      decoration: InputDecoration(
        //errorStyle: GoogleFonts.cairo(),
        hintText: hint,
        //hintStyle: GoogleFonts.cairo(),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(15),
          borderSide: const BorderSide(),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(15),
          /* borderSide: const BorderSide(
            color: MyColors.basColor,
            width: 2.0,
          ),*/
        ),
        labelText: label,
        //labelStyle: GoogleFonts.cairo(),
        prefixIcon: Icon(
          prefix,
        ),
        suffixIcon: suffix != null
            ? IconButton(
                onPressed: () {
                  suffixPressed!();
                },
                icon: Icon(
                  suffix,
                ),
              )
            : null,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(15),
        ),
      ),
    );
