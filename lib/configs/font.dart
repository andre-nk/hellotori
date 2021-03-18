part of "configs.dart";

class Font{
  static Text out({String? title, double? fontSize, FontWeight? fontWeight, Color? color, TextAlign? textAlign, String? family}){
    return Text(
      title ?? "",
      textAlign: textAlign ?? TextAlign.center,
      style: TextStyle(
        fontFamily: family ?? "EinaRegular",
        color: color ?? Colors.black,
        fontWeight: fontWeight ?? FontWeight.normal,
        fontSize: fontSize ?? 16
      )
    );
  }

  static TextStyle style({double? fontSize, FontWeight? fontWeight, Color? color, double? height, String? family}){
    return TextStyle(
      fontFamily: family ?? "EinaRegular",
      fontSize: fontSize ?? 16,
      fontWeight: fontWeight ?? FontWeight.normal,
      color: color ?? Palette.black,
      height: height ?? 1.5
    );
  }
}