part of "configs.dart";

class Font{
  static Text out({title, int fontSize = 16, fontWeight, color, textAlign, family, bool overrideMaxline = false}){
    return Text(
      title ?? "",
      maxLines: overrideMaxline ? 100 : 3,
      textAlign: textAlign ?? TextAlign.center,
      style: TextStyle(
        fontFamily: family ?? "EinaRegular",
        color: color ?? Colors.black,
        fontWeight: fontWeight ?? FontWeight.normal,
        fontSize: fontSize.toDouble())
    );
  }

  static TextStyle style({int fontSize = 16, Color? fontColor}){
    return TextStyle(
      fontFamily: "EinaRegular",
      fontWeight: FontWeight.normal,
      fontSize: fontSize.toDouble(),
      color: fontColor ?? Palette.black
    );
  }
}