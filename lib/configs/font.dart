part of "configs.dart";

class Font{
  static Text out({title, int? fontSize, fontWeight, color, textAlign, family}){
    return Text(
      title ?? "",
      textAlign: textAlign ?? TextAlign.center,
      style: TextStyle(
        fontFamily: family ?? "EinaRegular",
        color: color ?? Colors.black,
        fontWeight: fontWeight ?? FontWeight.normal,
        fontSize: fontSize!.toDouble())
    );
  }
}