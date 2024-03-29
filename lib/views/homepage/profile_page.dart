part of "../pages.dart";

class ProfilePage extends ConsumerWidget {

  final bool isMainPage;

  ProfilePage({required this.isMainPage});

  @override
  Widget build(BuildContext context, ScopedReader watch) {
    final authModel = watch(authModelProvider);
    const _url = 'https://www.instagram.com/smansasatria/';
    const _url2 = "mailto:andreasnotokusumo23@gmail.com";

    return SafeArea(
      child: HeaderPage(
        appBar:  Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            IconButton(
              icon: Icon(Icons.arrow_back_ios_rounded, color: Palette.white),
              onPressed: (){
                Get.back();
              },
            )
          ],
        ),
        isDetailedPage: true,
        child: Scaffold(
          body: Padding(
            padding: EdgeInsets.symmetric(
              horizontal: MQuery.height(0.025, context),
              vertical: MQuery.height(0.05, context)
            ),
            child: FadeInUp(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Column(
                    children: [
                      Hero(
                        tag: "avatar",
                        child: CircleAvatar(
                          radius: MQuery.height(0.04, context),
                          backgroundColor: Palette.lightBlueAccent,
                          backgroundImage: NetworkImage(authModel.auth.currentUser!.photoURL ?? "")
                        ),
                      ),
                      SizedBox(height: MQuery.height(0.05, context)),
                      Container(
                        width:  double.infinity,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Font.out(
                              title: "Nama kamu",
                              fontSize: 16,
                              family: "EinaRegular"
                            ),
                            Font.out(
                              title: authModel.auth.currentUser!.displayName,
                              fontSize: 18,
                              family: "EinaSemiBold"
                            )
                          ],
                        ),
                      ),
                      SizedBox(height: MQuery.height(0.04, context)),
                      Container(
                        width:  double.infinity,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Font.out(
                              title: "E-mail kamu",
                              fontSize: 16,
                              family: "EinaRegular"
                            ),
                            Font.out(
                              title: authModel.auth.currentUser!.email,
                              fontSize: 18,
                              family: "EinaSemiBold"
                            )
                          ],
                        ),
                      ),
                      SizedBox(height: MQuery.height(0.04, context)),
                      InkWell(
                        onTap: () async {
                          await launch(_url2);
                        },
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Font.out(
                              title: "Kontak developer",
                              fontSize: 18,
                              family: "EinaRegular"
                            ),
                            Icon(
                              Icons.arrow_forward_ios_rounded
                            )
                          ],
                        ),
                      )
                    ],
                  ),
                  Column(
                    children: [
                      Font.out(
                        title: "v.1.0",
                        fontSize: 16,
                        family: "EinaSemiBold"
                      ),
                      SizedBox(height: MQuery.height(0.01, context)),
                      GestureDetector(
                        onTap: () async {
                          await launch(_url);
                        },
                        child: Font.out(
                          title: "from Satria SMANSA with ❤️",
                          fontSize: 14,
                          family: "EinaRegular"
                        ),
                      ),
                      SizedBox(height: MQuery.height(0.03, context)),
                      Container(
                        height: MQuery.height(0.08, context),
                        width: MQuery.width(0.8, context),
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
                          method: (){
                            authModel.signOutWithGoogle();
                            Get.offAndToNamed('/auth');
                          },
                          title: Font.out(
                            title: "Keluar Akun",
                            family: "EinaSemibold",
                            fontSize: 20,
                            color: Colors.red
                          ),
                        )
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}