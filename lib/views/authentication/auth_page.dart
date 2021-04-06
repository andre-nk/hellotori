part of "../pages.dart";

class AuthPage extends ConsumerWidget {
  @override
  Widget build(BuildContext context, ScopedReader watch) {

    final authModel = watch(authModelProvider);

    return ProviderListener<AuthenticationViewModel>(
      provider: authModelProvider,
      onChange: (context, model) async {
        if (model.error != null) {
          
        }
      },
      child: Scaffold(
        body: Stack(
          alignment: Alignment.topCenter,
          children: [
            Positioned(
              top: 0,
              child: Container(
                width: MQuery.width(0.65, context),
                child: Image(
                  image: AssetImage("assets/auth_photo.png"),
                  fit: BoxFit.fitWidth,
                ),
              ),
            ),          
            Positioned(
              bottom: 0,
              left: 0,
              right: 0,
              top: MediaQuery.of(context).size.height * 0.5,
              child: Container(
                height: MQuery.height(0.3, context),
                color: Palette.white,
                child: FadeInUp(
                  duration: Duration(milliseconds: 300),
                  from: 100,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Font.out(
                          title: "hellotori.",
                          fontSize: 48,
                          family: "EinaBold",
                          color: Palette.blueAccent),
                      Font.out(
                        title: "make the most of your",
                        fontSize: 24,
                        family: "EinaRegular",
                        color: Palette.black,
                      ),
                      SizedBox(height: MQuery.height(0.03, context)),
                      Container(
                        alignment: Alignment.center,
                        height: MQuery.height(0.05, context),
                        width: MQuery.width(0.2, context),
                        decoration: BoxDecoration(
                            color: Palette.blueAccent,
                            borderRadius: BorderRadius.circular(50)),
                        child: Font.out(
                          textAlign: TextAlign.center,
                          title: "#satriasmansa",
                          color: Palette.white,
                          fontWeight: FontWeight.w200,
                        ),
                      ),
                      SizedBox(height: MQuery.height(0.06, context)),
                      Container(
                        height: MQuery.height(0.08, context),
                        padding: EdgeInsets.symmetric(
                          horizontal: MQuery.width(0.05, context)
                        ),
                        decoration: BoxDecoration(
                          boxShadow: <BoxShadow>[
                            BoxShadow(
                              color: Palette.blueAccent.withOpacity(0.2),
                              blurRadius: 60,
                              offset: Offset(0, 4),
                            ),
                          ],
                        ),
                        child: OnboardingButton(
                          color: Colors.white,
                          method: () async {
                            await authModel.signUpWithGoogle();
                            Get.offAllNamed("/eventpage");
                          },
                          title: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Image(
                                image: AssetImage("assets/google_icon.png"),
                              ),
                              Font.out(
                                title: "Masuk dengan Google",
                                family: "EinaRegular",
                                fontSize: 20,
                                color: Palette.black),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            )
          ],
        )
      ),
    );
  }
}
