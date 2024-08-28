import 'package:flutter/material.dart';
import 'package:flutter_plantist_app/app/theme/colors.dart';



extension ThemeExtension on BuildContext {
  ThemeData get theme => Theme.of(this);

  TextTheme get textTheme => theme.textTheme;

  CustomColor get darkColor => CustomColor.darkColor;

  CustomColor get whiteColor => CustomColor.appWhiteColor;

  CustomColor get mainColor => CustomColor.appPinkColor;

  Color get otherStroke => const Color(0xFFCED4DA);
}

// text theme extension

extension TextThemeExtension on TextTheme {
  ///LARGE TITLES           =>            //** FONTSİZE - 34 **//

  TextStyle get largeTitleRegular =>
      const TextStyle(color: Colors.pink).newRegular.newSize(44);

  TextStyle get largeTitleEmphasized =>
      const TextStyle(color: Colors.pink).emphasized.newSize(44);

  ///TITLE1's           =>           //** FONTSİZE - 28 **//

  TextStyle get title1Regular =>
      const TextStyle(color: Colors.pink).newRegular.newSize(32);

  TextStyle get title1Emphasized =>
      const TextStyle(color: Colors.pink).emphasized.newSize(32);

  ///TITLE2's           =>           //** FONTSİZE - 22 **//

  TextStyle get title2Regular =>
      const TextStyle(color: Colors.pink).newRegular.newSize(22);

  TextStyle get title2Emphasized =>
      const TextStyle(color: Colors.pink).emphasized.newSize(22);

  ///TITLE3's           =>           //** FONTSİZE - 20 **//

  TextStyle get title3Regular =>
      const TextStyle(color: Colors.pink).newRegular.newSize(20);

  TextStyle get title3Emphasized =>
      const TextStyle(color: Colors.pink).emphasized.newSize(20);

  ///HEADLINES           =>           //** FONTSİZE - 17 **//

  TextStyle get headlineRegular =>
      const TextStyle(color: Colors.pink).semiEmphasized.newSize(17);

  TextStyle get headlineItalic =>
      const TextStyle(color: Colors.pink).semiEmphasized.italic.newSize(17);

  ///BODIES           =>           //** FONTSİZE - 17 **//

  TextStyle get bodyRegular =>
      const TextStyle(color: Colors.pink).newRegular.newSize(18);

  TextStyle get bodyEmphasized =>
      const TextStyle(color: Colors.pink).semiEmphasized.newSize(18);

  TextStyle get bodyItalic =>
      const TextStyle(color: Colors.pink).italic.newSize(18);

  TextStyle get bodyEmphasizedItalic =>
      const TextStyle(color: Colors.pink).semiEmphasized.italic.newSize(18);

  ///CALLOUTS           =>           //** FONTSİZE - 16 **//

  TextStyle get calloutRegular =>
      const TextStyle(color: Colors.pink).newRegular.newSize(17);

  TextStyle get calloutEmphasized =>
      const TextStyle(color: Colors.pink).semiEmphasized.newSize(17);

  TextStyle get calloutItalic =>
      const TextStyle(color: Colors.pink).italic.newSize(17);

  TextStyle get calloutEmphasizedItalic =>
      const TextStyle(color: Colors.pink).semiEmphasized.italic.newSize(17);

  ///SUBHEADLINES           =>           //** FONTSİZE - 15 **//

  TextStyle get subheadlineRegular =>
      const TextStyle(color: Colors.pink).newRegular.newSize(15);

  TextStyle get subheadlineEmphasized =>
      const TextStyle(color: Colors.pink).emphasized.newSize(15);

  TextStyle get subheadlineItalic =>
      const TextStyle(color: Colors.pink).italic.newSize(15);

  TextStyle get subheadlineEmphasizedItalic =>
      const TextStyle(color: Colors.pink).semiEmphasized.italic.newSize(15);

  ///FOOTNOTES           =>           //** FONTSİZE - 13 **//

  TextStyle get footnoteRegular =>
      const TextStyle(color: Colors.pink).newRegular.newSize(13);

  TextStyle get footnoteEmphasized =>
      const TextStyle(color: Colors.pink).semiEmphasized.newSize(13);

  TextStyle get footnoteItalic =>
      const TextStyle(color: Colors.pink).italic.newSize(13);

  TextStyle get footnoteEmphasizedItalic =>
      const TextStyle(color: Colors.pink).semiEmphasized.italic.newSize(13);

  ///CAPTION1's           =>           //** FONTSİZE - 12 **//

  TextStyle get caption1Regular =>
      const TextStyle(color: Colors.pink).newRegular.newSize(12);

  TextStyle get caption1Emphasized =>
      const TextStyle(color: Colors.pink).semiEmphasized.newSize(12);

  TextStyle get caption1Italic =>
      const TextStyle(color: Colors.pink).italic.newSize(12);

  TextStyle get caption1EmphasizedItalic =>
      const TextStyle(color: Colors.pink).semiEmphasized.italic.newSize(12);

  ///CAPTION2's           =>           //** FONTSİZE - 11 **//

  TextStyle get caption2Regular =>
      const TextStyle(color: Colors.pink).newRegular.newSize(11);

  TextStyle get caption2Emphasized =>
      const TextStyle(color: Colors.pink).semiEmphasized.newSize(11);

  TextStyle get caption2Italic =>
      const TextStyle(color: Colors.pink).italic.newSize(11);

  TextStyle get caption2EmphasizedItalic =>
      const TextStyle(color: Colors.pink).semiEmphasized.italic.newSize(11);
}

extension TextStyleExtension on TextStyle {
  TextStyle get emphasized => copyWith(fontWeight: FontWeight.w600);

  TextStyle get semiEmphasized => copyWith(fontWeight: FontWeight.w400);

  TextStyle get newRegular => copyWith(fontWeight: FontWeight.w200);

  TextStyle get newMedium => copyWith(fontWeight: FontWeight.w500);

  TextStyle get italic => copyWith(fontStyle: FontStyle.italic);

  TextStyle newSize(double size) => copyWith(fontSize: size);
}

