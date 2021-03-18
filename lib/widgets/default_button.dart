part of "widgets.dart";

class OnboardingButton extends StatelessWidget {
  final dynamic method;
  final Widget? title;
  final Color? color;

  const OnboardingButton({this.method, this.title, this.color});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: this.method,
      child: title,
      style: ElevatedButton.styleFrom(
        primary: this.color,
        elevation: 0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(50.0)
        )
      )
    );
  }
}

