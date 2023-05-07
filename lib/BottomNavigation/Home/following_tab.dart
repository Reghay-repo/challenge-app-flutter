import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:brands_app/Auth/login_navigator.dart';
import 'package:brands_app/BottomNavigation/Home/comment_sheet.dart';
import 'package:brands_app/Components/custom_button.dart';
import 'package:brands_app/Components/rotated_image.dart';
import 'package:brands_app/Locale/locale.dart';
import 'package:brands_app/Routes/routes.dart';
import 'package:brands_app/Theme/colors.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:video_player/video_player.dart';

RouteObserver<PageRoute> routeObserver = RouteObserver<PageRoute>();

class FollowingTabPage extends StatelessWidget {
  final List<String> videos;
  final List<String> images;
  final bool isFollowing;

  final int? variable;

  const FollowingTabPage(this.videos, this.images, this.isFollowing,
      {this.variable});

  @override
  Widget build(BuildContext context) {
    return FollowingTabBody(videos, images, isFollowing, variable);
  }
}

class FollowingTabBody extends StatefulWidget {
  final List<String> videos;
  final List<String> images;

  final bool isFollowing;
  final int? variable;

  const FollowingTabBody(
      this.videos, this.images, this.isFollowing, this.variable);

  @override
  _FollowingTabBodyState createState() => _FollowingTabBodyState();
}

class _FollowingTabBodyState extends State<FollowingTabBody> {
  PageController? _pageController;
  int current = 0;
  bool isOnPageTurning = false;

  void scrollListener() {
    if (isOnPageTurning &&
        _pageController!.page == _pageController!.page!.roundToDouble()) {
      setState(() {
        current = _pageController!.page!.toInt();
        isOnPageTurning = false;
      });
    } else if (!isOnPageTurning &&
        current.toDouble() != _pageController!.page) {
      if ((current.toDouble() - _pageController!.page!).abs() > 0.1) {
        setState(() {
          isOnPageTurning = true;
        });
      }
    }
  }

  @override
  void initState() {
    super.initState();
    _pageController = PageController();
    _pageController!.addListener(scrollListener);
  }

  @override
  Widget build(BuildContext context) {
    return PageView.builder(
      physics: BouncingScrollPhysics(),
      scrollDirection: Axis.vertical,
      controller: _pageController,
      itemBuilder: (context, position) {
        return VideoPage(
          widget.videos[position],
          widget.images[position],
          pageIndex: position,
          currentPageIndex: current,
          isPaused: isOnPageTurning,
          isFollowing: widget.isFollowing,
        );
      },
      itemCount: widget.videos.length,
    );
  }
}

class VideoPage extends StatefulWidget {
  final String video;
  final String image;
  final int? pageIndex;
  final int? currentPageIndex;
  final bool? isPaused;
  final bool? isFollowing;

  const VideoPage(this.video, this.image,
      {this.pageIndex, this.currentPageIndex, this.isPaused, this.isFollowing});

  @override
  _VideoPageState createState() => _VideoPageState();
}

class _VideoPageState extends State<VideoPage> with RouteAware {
  late VideoPlayerController _controller;
  bool initialized = false;
  bool isLiked = false;
  bool follow = true;
  String textFollow = "Follow";

  @override
  void initState() {
    super.initState();
    _controller = VideoPlayerController.asset(widget.video)
      ..initialize().then((value) {
        setState(() {
          _controller.setLooping(true);
          initialized = true;
          user.displayName;
        });
      });
  }

  final user = FirebaseAuth.instance.currentUser!;
  final db = FirebaseFirestore.instance.collection("users").doc().snapshots();

  @override
  void didPopNext() {
    print("didPopNext");
    _controller.play();
    super.didPopNext();
  }

  @override
  void didPushNext() {
    print("didPushNext");
    _controller.pause();
    super.didPushNext();
  }

  @override
  void didChangeDependencies() {
    routeObserver.subscribe(
        this, ModalRoute.of(context) as PageRoute<dynamic>); //Subscribe it here
    super.didChangeDependencies();
  }

  @override
  void dispose() {
    routeObserver.unsubscribe(this);
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (widget.pageIndex == widget.currentPageIndex &&
        !widget.isPaused! &&
        initialized) {
      _controller.play();
    } else {
      _controller.pause();
    }
    var locale = AppLocalizations.of(context)!;
//    if (_controller.value.position == _controller.value.duration) {
//      setState(() {
//      });
//    }
//    if (widget.pageIndex == 2) _controller.pause();
    return Scaffold(
      resizeToAvoidBottomInset: true,
      body: Stack(
        children: <Widget>[
          GestureDetector(
            onTap: () {
              _controller.value.isPlaying
                  ? _controller.pause()
                  : _controller.play();
            },
            child: _controller.value.isInitialized
                ? VideoPlayer(_controller)
                : SizedBox.shrink(),
          ),
          Positioned.directional(
            textDirection: Directionality.of(context),
            end: -10.0,
            bottom: 80.0,
            child: Column(
              children: <Widget>[
                InkWell(
                  onTap: () {
                    _controller.pause();
                    Navigator.pushNamed(context, PageRoutes.userProfilePage);
                  },
                  child: CircleAvatar(
                      backgroundImage: AssetImage('assets/images/user.webp')),
                ),
                CustomButton(
                  ImageIcon(
                    AssetImage('assets/icons/ic_views.png'),
                    color: secondaryColor,
                  ),
                  '1.2k',
                ),
                CustomButton(
                    ImageIcon(
                      AssetImage('assets/icons/ic_comment.png'),
                      color: secondaryColor,
                    ),
                    '287', onPressed: () {
                  commentSheet(context);
                }),
                CustomButton(
                  Icon(
                    isLiked ? Icons.favorite : Icons.favorite_border,
                    color: secondaryColor,
                  ),
                  '8.2k',
                  onPressed: () {
                    setState(() {
                      isLiked = !isLiked;
                    });
                  },
                ),
                Padding(
                  padding: EdgeInsets.symmetric(vertical: 8.0),
                  child: SizedBox.fromSize(
                    size: Size(56, 56), // button width and height
                    child: ClipOval(
                      child: Material(
                        color: Colors.transparent, // button color
                        child: InkWell(
                          splashColor: Colors.white10, // splash color
                          onTap: () {
                            Fluttertoast.showToast(
                                msg: 'Challenge joined!',
                                toastLength: Toast.LENGTH_SHORT);
                          }, // button pressed
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: const <Widget>[
                              Icon(Icons.queue_outlined,
                                  color: Colors.white), // icon
                              Text("Join"), // text
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(vertical: 8.0),
                  child: RotatedImage(widget.image),
                ),
              ],
            ),
          ),
          widget.isFollowing!
              ? Positioned.directional(
                  textDirection: Directionality.of(context),
                  end: 27.0,
                  bottom: 320.0,
                  child: CircleAvatar(
                      backgroundColor: mainColor,
                      radius: 8,
                      child: Icon(
                        Icons.add,
                        color: secondaryColor,
                        size: 12.0,
                      )),
                )
              : SizedBox.shrink(),
          Align(
            alignment: Alignment.bottomCenter,
            child: Padding(
                padding: EdgeInsets.only(bottom: 60.0),
                child: LinearProgressIndicator(
                    //minHeight: 1,
                    )),
          ),
          Positioned.directional(
            textDirection: Directionality.of(context),
            start: 12.0,
            bottom: 72.0,
            child: RichText(
              text: TextSpan(children: [
                TextSpan(
                    text: '@${user.displayName}  ',
                    style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                        fontSize: 16.0,
                        fontWeight: FontWeight.bold,
                        letterSpacing: 0.5)),
                TextSpan(
                  text: '$textFollow\n',
                  style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                      fontSize: 16.0,
                      fontWeight: FontWeight.bold,
                      letterSpacing: 0.5,
                      color: (!follow)
                          ? Color.fromARGB(255, 247, 84, 84)
                          : Color.fromARGB(255, 255, 255, 255)),
                  recognizer: TapGestureRecognizer()
                    ..onTap = () => setState(() {
                          follow = !follow;

                          (follow)
                              ? textFollow
                              : textFollow = locale.followingg!;
                          (!follow) ? textFollow : textFollow = locale.follow!;
                          print(follow);
                        }),
                ),
                TextSpan(text: locale.comment8),
                TextSpan(
                    text: '  ${locale.seeMore}',
                    style: TextStyle(
                        color: secondaryColor.withOpacity(0.5),
                        fontStyle: FontStyle.italic))
              ]),
            ),
          )
        ],
      ),
    );
  }
}
