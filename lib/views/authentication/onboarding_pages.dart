part of "../pages.dart";

class OnboardingPages extends StatefulWidget {
  @override
  _OnboardingPagesState createState() => _OnboardingPagesState();
}

class _OnboardingPagesState extends State<OnboardingPages> {
  PageController _controller = PageController();
  int currentPage = 0;
  List<Map<String, String>> splashData = [
    {
      "title": "Event terbaru!",
      "text": "Temukan info terbaru dan gabung keseruan dari acara-acara dari OSIS SMANSA!",
      "image": "assets/onboarding_1.png"
    },
    {
      "title": "Live Show dan Chat!",
      "text": "Tonton siaran langsung dari event SMANSA jangan lupa ramein chatnya!",
      "image": "assets/onboarding_2.png"
    },
    {
      "title": "SMANSA dan OSIS!",
      "text": "Kepo gak tuh sama SMANSA dan OSIS yang sekarang? Temuin jawabannya disini!",
      "image": "assets/onboarding_3.png"
    },
  ];

  Future<void> onGetStarted(BuildContext context) async {
    final onboardingViewModel = context.read(onboardingViewModelProvider);
    await onboardingViewModel.completeOnboarding();
  }

  @override
  Widget build(BuildContext context) {
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
                          image: AssetImage(splashData[index]['image'] ?? ""),
                          fit: index == 1 ? BoxFit.cover : BoxFit.fill
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
  }
}
