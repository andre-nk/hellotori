part of "../pages.dart";

class SplashContent extends StatelessWidget {
  final Image? icon;
  final String? title;
  final String? description;

  const SplashContent({
    this.icon,
    this.title,
    this.description,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: MQuery.width(0.05, context)),
      child: Column(
        children: <Widget>[
          Expanded(
            flex: 7,
            child: FadeInLeft(
              child: Container(
                child: this.icon,
                height: MQuery.height(0.15, context),
                width: MQuery.width(0.45, context),
              ),
            ),
          ),
          Spacer(),
          Expanded(
            flex: 4,
            child: FadeInLeft(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Font.out(
                    title: this.title,
                    fontSize: MQuery.height(0.04, context).round(),
                    family: "EinaBold"
                  ),
                  SizedBox(height: MQuery.height(0.01, context)),
                  Font.out(
                    title: this.description,
                    fontSize: MQuery.height(0.0225, context).round(),
                    family: "EinaRegular"
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}