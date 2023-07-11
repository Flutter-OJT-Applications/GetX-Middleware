import 'package:flutter/material.dart';

import '../../models/todo/todo_model.dart';

typedef FormSubmitCallback = Function(TodoModel model);
typedef TodoTileCallback = Function(int id);

class CommonWidget{
  static MaterialColor appColors = const MaterialColor(
    0xff1976d2, // Set the primary color to a classic blue shade
    <int, Color>{
      50: Color(0xffe3f2fd),
      100: Color(0xffbbdefb),
      200: Color(0xff90caf9),
      300: Color(0xff64b5f6),
      400: Color(0xff42a5f5),
      500: Color(0xff2196f3), // Main classic blue shade
      600: Color(0xff1e88e5),
      700: Color(0xff1976d2),
      800: Color(0xff1565c0),
      900: Color(0xff0d47a1),
    },
  );

  static final ThemeData lightTheme = ThemeData(
    primaryColor: appColors,
    // Set the primary color to violet
    colorScheme: ColorScheme.fromSwatch(primarySwatch: CommonWidget.appColors),
    textTheme: TextTheme(
      bodySmall: TextStyle(color: appColors),
      bodyLarge: TextStyle(color: appColors),
      bodyMedium: TextStyle(color: appColors),
    ),
    appBarTheme: AppBarTheme(
      elevation: 0,
      iconTheme: IconThemeData(
        color: CommonWidget.appColors,
      ),
      backgroundColor: Colors.transparent,
      titleTextStyle: TextStyle(
        color: CommonWidget.appColors,
        fontSize: 18,
      ),
    ),
    inputDecorationTheme: InputDecorationTheme(
      filled: true,
      fillColor: Colors.transparent,
      // contentPadding: const EdgeInsets.fromLTRB(20, 15, 20, 15),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(20),
        borderSide: BorderSide(
          color: CommonWidget.appColors,
        ),
      ),
    ),
    drawerTheme: const DrawerThemeData(
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
                topRight: Radius.circular(10),
                bottomRight: Radius.circular(10)))),
  );

  static ButtonStyle primaryButtonStyle({Color? backgroundColor}) =>
      ElevatedButton.styleFrom(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15),
        ),
        backgroundColor: backgroundColor,
      );

  /// The secondary button style
  static ButtonStyle secondaryButtonStyle() => ElevatedButton.styleFrom(
    padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(15),
    ),
    backgroundColor: Colors.black38,
  );

  /// The secondary button style
  static ButtonStyle dangerButtonStyle() => ElevatedButton.styleFrom(
    padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(15),
    ),
    backgroundColor: Colors.red,
  );

  /// The basic input style
  static InputDecoration inputStyle({String? placeholder}) => InputDecoration(
    hintText: placeholder ?? "Enter text",
  );

  /// The basic input style
  static InputDecoration passwordStyle(
      {String? placeholder, bool? isShow, VoidCallback? onShow}) =>
      InputDecoration(
        hintText: placeholder ?? "Enter text",
        contentPadding: const EdgeInsets.fromLTRB(10, 5, 10, 15),
        suffix: CircleAvatar(
          radius: 20,
          backgroundColor: Colors.transparent,
          child: IconButton(
            onPressed: onShow,
            iconSize: 20,
            color: appColors,
            icon: Icon(isShow != null && isShow
                ? Icons.visibility
                : Icons.visibility_off),
          ),
        ),
      );

  /// The default title text style
  static TextStyle titleText({Color? color}) =>
      TextStyle(fontWeight: FontWeight.bold, fontSize: 24, color: color);

  static TextStyle secondaryTitleText({Color? color}) =>
      TextStyle(fontWeight: FontWeight.bold, fontSize: 17, color: color);

}