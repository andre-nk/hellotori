part of "../pages.dart";

class OnboardingPages extends StatefulWidget {
  @override
  _OnboardingPagesState createState() => _OnboardingPagesState();
}

class _OnboardingPagesState extends State<OnboardingPages> {
  PageController _controller = PageController();
  int currentPage = 0;

  Future<void> onGetStarted(BuildContext context) async {
    final onboardingViewModel = context.read(onboardingViewModelProvider);
    await onboardingViewModel.completeOnboarding();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer(
      builder: (context, watch, _){

        final appProvider = watch(appBiosProvider);

        return appProvider.when(
          data: (value){

            List<Map<String, String>>  splashData = [];

            value.forEach((element) {
              splashData.add(
                {
                "title": element.title,
                "text": element.tagline,
                "image": element.photoURL
                },
              );
            });
        
            return Scaffold(
              body: SafeArea(
                child: SizedBox(
                  width: double.infinity,
                  child: Column(
                    children: <Widget>[
                      Spacer(),
                      Align(
                        alignment: Alignment.centerRight,
                        child: Padding(
                          padding: EdgeInsets.symmetric(horizontal: MQuery.width(0.05, context)),
                          child: TextButton(
                            child: Font.out(title: "Lewati", fontSize: 16),
                            onPressed: () {
                              onGetStarted(context);
                              Get.offAndToNamed("/auth");
                              Get.to(() => AuthPage(), transition: Transition.rightToLeftWithFade);
                            },
                          ),
                        ),
                      ),
                      Spacer(),
                      Expanded(
                        flex: 40,
                        child: PageView.builder(
                            physics: BouncingScrollPhysics(),
                            controller: _controller,
                            onPageChanged: (value) {
                              setState(() {
                                currentPage = value;
                              });
                            },
                            itemCount: splashData.length,
                            itemBuilder: (context, index) {
                              return SplashContent(
                                icon: Image(
                                  image: NetworkImage(splashData[index]['image'] ?? ""),
                                  fit: index == 1 ? BoxFit.cover : index == 3  ? BoxFit.fitHeight : BoxFit.fill
                                ),
                                title: splashData[index]['title'] ?? "Untitled",
                                description: splashData[index]['text'] ?? "Description",
                              );
                            }),
                      ),
                      Expanded(
                        flex: 7,
                        child: Padding(
                          padding: EdgeInsets.symmetric(
                              horizontal: MQuery.width(0.05, context)),
                          child: Column(
                            children: <Widget>[
                              Container(
                                width: double.infinity,
                                height: MQuery.height(0.08, context),
                                padding: EdgeInsets.only(
                                    bottom: MQuery.height(0.005, context)),
                                child: OnboardingButton(
                                  color: Palette.blueAccent,
                                  method: () {
                                    if(currentPage == splashData.length - 1){
                                      onGetStarted(context);
                                      Get.offAndToNamed("/auth");
                                    } else {
                                      _controller.nextPage(
                                        duration: Duration(milliseconds: 250),
                                        curve: Curves.easeInOut
                                      );   
                                    }          
                                  },
                                  title: Font.out(
                                    title: currentPage == splashData.length - 1 ? "Langsung mulai aja!" :"Lanjut",
                                    fontWeight: FontWeight.w900,
                                    fontSize: 20,
                                    color: Palette.white
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            );
          },
          loading: () => SpinKitCubeGrid(color: Palette.blueAccent),
          error: (_,__){
            return  SpinKitCubeGrid(color: Colors.red);
          }
        );
      }
    );
  }
}
