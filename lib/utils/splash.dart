import 'dart:async';
import 'dart:ffi';

import 'package:dream/auth/login_idea/login_screen.dart';
import 'package:dream/main.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:page_transition/page_transition.dart';
import 'package:flutter/services.dart';
import 'package:video_player/video_player.dart';


class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with TickerProviderStateMixin {
  final double _buttonWidth = 100;
  bool _visible = false;
  VideoPlayerController? _controller= VideoPlayerController.asset("assets/check.mp4");

  late AnimationController _buttonScaleController;
  late Animation<double> _buttonScaleAnimation;
  void _initButtonScale() {
    _buttonScaleController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 200),
    );
    _buttonScaleAnimation =
    Tween<double>(begin: 1, end: .9).animate(_buttonScaleController)
      ..addStatusListener((status) {
        if (status == AnimationStatus.completed) {
          _buttonWidthController.forward();
        }
      });


  }

  late AnimationController _buttonWidthController;
  late Animation<double> _buttonWidthAnimation;
  void _initButtonWidth(double screenWidth) {
    _buttonWidthController = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 200));
    _buttonWidthAnimation = Tween<double>(begin: _buttonWidth, end: screenWidth)
        .animate(_buttonWidthController)
      ..addStatusListener((status) {
        if (status == AnimationStatus.completed) {
          _positionedController.forward();
        }
      });
  }

  late AnimationController _positionedController;
  late Animation<double> _positionedAnimation;
  void _initPositioned(double screenWidth) {
    _positionedController = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 400));
    // 160 = 20 left padding + 20 right padding + 10 left positioned + 10 right positioned + 100 button width
    _positionedAnimation = Tween<double>(begin: 10, end: screenWidth - 160)
        .animate(_positionedController)
      ..addStatusListener((status) {
        if (status == AnimationStatus.completed) {
          _screenScaleController.forward();
        }
      });
  }

  late AnimationController _screenScaleController;
  late Animation<double> _screenScaleAnimation;
  void _initScreenScale() {
    _screenScaleController = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 400));
    _screenScaleAnimation =
    Tween<double>(begin: 1, end: 24).animate(_screenScaleController)
      ..addStatusListener((status) {
        if (status == AnimationStatus.completed) {
          Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(
                  builder: (context) => const LoginScreen()),
                  (e) => false);

          Navigator.pushReplacement(
              context,
              PageTransition(
                  child: const LoginScreen(),
                  type: PageTransitionType.fade));

        }
        
      });
  }

  @override
  void initState() {
    _initButtonScale();
    _initScreenScale();
    super.initState();
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
    ]);

    if (_controller!=null) {
      _controller!.initialize().then((_) {
        _controller!.setLooping(true);
        Timer(const Duration(milliseconds: 10), () {
          setState(() {
            _controller!.play();
            _visible = true;
          });
        });
      });
    }
    // Future.delayed(const Duration(seconds: 100), () {
    //
    // });
  }

  @override
  void dispose() {
    _buttonScaleController.dispose();
    super.dispose();
    if (_controller != null) {
      _controller!.dispose();
      _controller = null;
    }
  }
  _getVideoBackground() {

    return AnimatedOpacity(
      opacity: _visible ? 1.0 : 0.0,
      duration: const Duration(milliseconds: 1000),
      child: VideoPlayer(_controller!),
    );
  }
  _getBackgroundColor() {
    return Container(color: Colors.transparent //.withAlpha(120),
    );
  }

  _getContent() {
    return const Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.start,
    );
  }

  @override
  Widget build(BuildContext context) {
    final double screenWidth = MediaQuery.of(context).size.width;
    _initButtonWidth(screenWidth);
    _initPositioned(screenWidth);
    int t=1;

    return CupertinoPageScaffold(
      backgroundColor: CupertinoColors.secondarySystemFill,


      child: Stack(
        children: [
          _getVideoBackground(),
          Positioned(
              left: MediaQuery.of(context).size.width/2-156,
              top: MediaQuery.of(context).size.height/2-350,
              child: Text("Experience Devotion",style: Theme.of(context).textTheme.displayMedium!.copyWith(fontStyle:FontStyle.normal,fontSize: 35,color: Colors.white))
          ),
          Positioned(
              left: MediaQuery.of(context).size.width/2-28,
              top: MediaQuery.of(context).size.height/2-295,
              child: Text("and",style: Theme.of(context).textTheme.displaySmall!.copyWith(fontStyle:FontStyle.normal,fontWeight:FontWeight.bold,fontSize: 30,color: Colors.yellowAccent))

          ),

          Positioned(
              left: MediaQuery.of(context).size.width/2-94,
              top: MediaQuery.of(context).size.height/2-250,
              child: Text("PURENESS",style: Theme.of(context).textTheme.displayLarge!.copyWith(fontStyle:FontStyle.normal,fontWeight:FontWeight.bold,fontSize: 35,color: Colors.red))

          ),

          Container(

            padding: const EdgeInsets.only(bottom: 15,left: 20,right: 20,top: 25),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.end,
              children: [



                AnimatedBuilder(
                  animation: _buttonScaleController,
                  builder: (_, child) => Transform.scale(
                    scale: _buttonScaleAnimation.value,
                    child: CupertinoButton(
                      onPressed: () {
                        _buttonScaleController.forward();
                      },
                      child: Stack(
                        children: [


                          AnimatedBuilder(
                            animation: _buttonWidthController,
                            builder: (_, child) => Container(
                              height: _buttonWidth,
                              width: _buttonWidthAnimation.value,
                              decoration: BoxDecoration(
                                color: Colors.black.withOpacity(1),
                                borderRadius: BorderRadius.circular(100),
                              ),
                            ),
                          ),
                          AnimatedBuilder(
                            animation: _positionedController,
                            builder: (_, child) => Positioned(
                              top: 10,
                              left: _positionedAnimation.value,
                              child: AnimatedBuilder(
                                animation: _screenScaleController,
                                builder: (_, child) => Transform.scale(
                                  scale: _screenScaleAnimation.value,
                                  child: Container(
                                    height: _buttonWidth - 17,
                                    width: _buttonWidth - 17,
                                    decoration:  BoxDecoration(
                                      color: Colors.blue.withOpacity(1)
                                        
                                     ,
                                      shape: BoxShape.circle,
                                    ),
                                    alignment: Alignment.center,
                                    child: _screenScaleController.isDismissed
                                        ?  Icon(
                                      CupertinoIcons.chevron_forward,
                                      color: Colors.black.withOpacity(0.4*t),
                                      size: 35,
                                    )
                                        : null,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: MediaQuery.of(context).padding.bottom + 17,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}