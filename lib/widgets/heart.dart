part of "widgets.dart";

class Heart extends StatefulWidget {

  final FirestoreDatabase? dbProvider;
  final Event? event;

  Heart({this.dbProvider, this.event});

  @override
  _HeartState createState() => _HeartState();
}

class _HeartState extends State<Heart> with SingleTickerProviderStateMixin {
  bool isFav = false;
  int likesAdded = 0;
  double opacity = 1;
  late AnimationController _controller;
  late Animation<Color?> _colorAnimation;
  late Animation<double> _sizeAnimation;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      duration: Duration(milliseconds: 200),
      vsync: this,
    );

    _colorAnimation = ColorTween(begin: Colors.grey[400], end: Colors.red)
      .animate(_controller);

    _sizeAnimation = TweenSequence(
      <TweenSequenceItem<double>>[
        TweenSequenceItem<double>(
          tween: Tween<double>(begin: 30, end: 35),
          weight: 50,
        ),
        TweenSequenceItem<double>(
          tween: Tween<double>(begin: 35, end: 30),
          weight: 50,
        ),
      ]
    ).animate(_controller);

    _controller.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        setState(() {
          isFav = false;
        });
      }
      if (status == AnimationStatus.dismissed) {
        setState(() {
          isFav = false;
        });
      }
    }); 
  }

  // dismiss the animation when widgit exits screen
  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _controller,
      builder: (BuildContext context, _){
        return Column(
          children: [
            IconButton(
              icon: Icon(
                Icons.favorite,
                color: _colorAnimation.value,
                size: _sizeAnimation.value,
              ),
              onPressed: () {
                widget.dbProvider!.addLikes(widget.event!.uid, widget.event!.likes);
                isFav ? _controller.reverse() : _controller.forward();
                setState(() {
                  likesAdded++;
                });
              },
            ),
            AnimatedContainer(
              duration: Duration(milliseconds: 500),
              child: Opacity(
                opacity: opacity,
                child: Font.out(
                  title: "+${likesAdded < 500 ? likesAdded : 500}"
                ),
              ),
            )
          ],
        );
      }
    );
  }
}