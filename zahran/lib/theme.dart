import 'package:flutter/material.dart';

class ThemeGenerator {
  //! Application colors
  static ColorScheme get _colorScheme => ColorScheme.light().copyWith(
        primary: Color(0xFF272727),
        primaryVariant: Color(0xFF110B0B),
        secondary: Color(0xFFF90000),
        secondaryVariant: Color(0xFFA40C0C),
        surface: Colors.white,
        background: Color(0xffF5F5F5),
        onPrimary: Colors.white,
        onSecondary: Colors.white,
        onBackground: Color(0xff2C3550),
        onSurface: Color(0xff545365),
      );
  //! font family
  static String get _fontFamily => "ProximaNova";
  //! generate text theme
  static TextTheme _textTheme({
    Color bodyColor,
    Color captionColor,
    Color displayColor,
    Color bodyBoldColor,
    double captionFontSize = 14,
  }) {
    var _textTheme = Typography.tall2018
        .copyWith(
          headline6: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
          headline5: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
          headline4: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
          ),
          headline3: TextStyle(
            fontSize: 26,
            fontWeight: FontWeight.bold,
          ),
          headline2: TextStyle(
            fontSize: 28,
            fontWeight: FontWeight.bold,
          ),
          headline1: TextStyle(
            fontSize: 30,
            fontWeight: FontWeight.bold,
          ),
        )
        .apply(
          bodyColor: bodyColor,
          displayColor: displayColor ?? bodyColor,
          decorationColor: bodyColor,
        )
        .copyWith(
          caption: TextStyle(
            color: captionColor,
            fontSize: captionFontSize,
          ),
          bodyText1: TextStyle(
            color: bodyBoldColor ?? bodyColor,
            fontSize: 14,
            fontWeight: FontWeight.bold,
          ),
        );
    return _textTheme.apply(fontFamily: _fontFamily);
  }

  //! generate theme
  static ThemeData generate() {
    var colors = _colorScheme;
    var theme = ThemeData.from(colorScheme: colors);
    return theme.copyWith(
      textTheme: _textTheme(
        bodyColor: colors.onSurface,
        captionColor: Color(0xFFBDBCD1),
        displayColor: Color(0xFF02001E),
        bodyBoldColor: Color(0xFF3F4861),
      ),
      primaryTextTheme: _textTheme(
        bodyColor: colors.onPrimary,
        captionColor: Color(0xFFB4B3BE),
        captionFontSize: 16,
      ),
      accentTextTheme: _textTheme(bodyColor: colors.onSecondary),
      bottomSheetTheme: BottomSheetThemeData(
        backgroundColor: colors.background,
        modalBackgroundColor: colors.surface,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(24),
            topRight: Radius.circular(24),
          ),
        ),
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          primary: colors.secondary,
          onPrimary: colors.onSecondary,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(6)),
          elevation: 0,
          padding: EdgeInsets.symmetric(vertical: 12, horizontal: 16),
        ),
      ),
      outlinedButtonTheme: OutlinedButtonThemeData(
        style: OutlinedButton.styleFrom(
          primary: colors.secondary,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(6)),
          elevation: 0,
          padding: EdgeInsets.symmetric(vertical: 12, horizontal: 16),
        ),
      ),
      textButtonTheme: TextButtonThemeData(
        style: TextButton.styleFrom(
          primary: colors.secondary,
          elevation: 0,
          padding: EdgeInsets.symmetric(vertical: 12, horizontal: 16),
        ),
      ),
      inputDecorationTheme: InputDecorationTheme(
        enabledBorder: _buildInputBorder(),
        focusedBorder: _buildInputBorder(colors.secondary, 1),
        disabledBorder: _buildInputBorder(colors.primary, 0.5),
        errorBorder: _buildInputBorder(colors.error, 1),
        focusedErrorBorder: _buildInputBorder(colors.error, 1),
        contentPadding: EdgeInsets.symmetric(vertical: 5, horizontal: 10),
        fillColor: Colors.white,
        filled: true,
      ),
    );
  }

  static OutlineInputBorder _buildInputBorder(
      [Color color = Colors.transparent, double width = 0.0]) {
    return OutlineInputBorder(
      borderRadius: BorderRadius.circular(6),
      borderSide: BorderSide(
        color: color,
        width: width,
      ),
    );
  }
}
