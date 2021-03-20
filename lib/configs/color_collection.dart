part of "configs.dart";

class ColorCollection{
  static List<String> colors = [
    "f94144",
    "f3722c",
    "f8961e",
    "f9844a",
    "f9c74f",
    "43aa8b",
    "90be6d",
    "4d908e",
    "277da1",
    "ef476f",
    "118ab2",
    "06d6a0",
    "bdb2ff",
    "ffc6ff",
    "0096c7"
    "2a9d8f"
  ];

  static Color generateColor(){
    final _random = new Random();
    return HexColor(colors[_random.nextInt(colors.length)]);
  }
}