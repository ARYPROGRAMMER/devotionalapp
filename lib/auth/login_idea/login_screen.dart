
import 'dart:async';
import 'package:dream/utils/send_mail.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../../utils/app_colors.dart';
import '../../utils/styles/text_field_style.dart';
import '../../utils/utils.dart';
import 'package:video_player/video_player.dart';


class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  // final PageController controller;

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {


  bool _visible = false;
  VideoPlayerController? _controller = VideoPlayerController.asset(
      "assets/check.mp4");

  final TextEditingController emailController = TextEditingController();
  final TextEditingController _passController = TextEditingController();
  final formKey = GlobalKey<FormState>();
  String ?emailval = "";

  bool _validate=false;
  bool _second=false;

  @override
  void initState() {
    super.initState();
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
    ]);
    if (_controller != null) {
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
  }

    @override
    void dispose() {
      super.dispose();
      if (_controller != null) {
        _controller!.dispose();
        _controller = null;
      }
    }

    _getVideoBackground() {
      return AnimatedOpacity(
        opacity: _visible ? 0.5 : 0.0,
        duration: const Duration(milliseconds: 100),
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
      return Scaffold(
        backgroundColor: Colors.transparent,
        body: SizedBox.fromSize(
          size: MediaQuery.sizeOf(context),
          child: Stack(
            children: [
              _getVideoBackground(),

              Positioned(

                bottom: 60,
                child: new Container(
                  height: MediaQuery
                      .of(context)
                      .size
                      .height,
                  width: MediaQuery
                      .of(context)
                      .size
                      .width,
                  decoration: new BoxDecoration(


                    image: DecorationImage(
                      image: AssetImage('assets/login.jpg'),
                      // fit: BoxFit.fill
                    ),
                  ),
                ),
              ),


              Positioned(
                // padding: const EdgeInsets.all(30),
                bottom: 30,
                left: 30,
                right: 30,

                child: Container(
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(30),
                    color: Color(0xff8C0944).withOpacity(.6),
                  ),
                  child: Form(
                    key: formKey,
                    child: Column(

                      // padding: const EdgeInsets.symmetric(horizontal: 50),
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(top: 8.0),
                        ),
                        Text(
                          'Log In ',
                          style: Theme.of(context).textTheme.displayMedium!.copyWith(
                            fontStyle: FontStyle.normal,
                            color: Colors.white,
                            fontSize: 25,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        TextField(
                          // validator: (value) {
                          //   if (value == null || value.isEmpty) {
                          //     return "Enter your e-mail.";
                          //   }
                          //   return null;
                          // },

                          controller: emailController,
                          style: textFieldTextStyle(),
                          decoration: InputDecoration(
                              hintText: 'Email',hintStyle:Theme.of(context).textTheme.titleMedium!.copyWith(fontSize: 16,color: Colors.grey),prefixIcon: Icon(Icons.email_outlined),
                            labelText: "Enter your Email Id",
                            labelStyle: TextStyle(fontSize: 15,color: Colors.red),
                              errorText: _validate ? "Value Can't Be Empty" : null,
                          ),
                        ),
                        const SizedBox(
                          height: 15,
                        ),
                        TextField(

                          obscureText: true,
                          obscuringCharacter: "*",
                          // validator: (value) {
                            // if (value == null || value.isEmpty) {
                            //   return "Enter you password";
                            // } else if (value.length < 6) {
                            //   return "Must have at least 6 chars";
                            // }
                            // return null;
                          // },
                          focusNode: FocusNode(
                            canRequestFocus: true,
                          ),
                          controller: _passController,
                          style: textFieldTextStyle(),
                          decoration: InputDecoration(
                              hintText: 'Password',hintStyle:Theme.of(context).textTheme.titleMedium!.copyWith(fontSize: 16,color: Colors.grey),prefixIcon: Icon(Icons.password_outlined),
                            labelText: "Enter Password",
                            labelStyle: TextStyle(fontSize: 15,color: Colors.red),
                            errorText: _second ? "Min Size is 4" : null,

                          ),

                        ),
                        const SizedBox(
                          height: 25,
                        ),
                        FractionallySizedBox(
                          widthFactor: 1,
                          child: TextButton(
                              style: TextButton.styleFrom(
                                backgroundColor: Color(0xff098c51),
                                foregroundColor: AppColors.whiteColor,
                              ),
                              onPressed: () async {

                                setState(() {
                                  emailController.text.isEmpty ? _validate=true:null;
                                  _passController.text.isEmpty ? _validate=true:null;
                                });
                                emailval = emailController.text.toString();

                                loadingDialog(context);
                                FocusManager.instance.primaryFocus?.unfocus();
                                // Future.delayed(const Duration(seconds: 2)).then(
                                //   (value) => Navigator.pop(context),
                                // );
                                Navigator.pushReplacement(context,
                                    MaterialPageRoute(builder: (context) =>
                                        SendingMail(email: emailval)));
                              },
                              child: const Text("Sign In")),
                        ),
                        const SizedBox(
                          height: 15,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              'Don’t have an account?',
                              style: TextStyle(
                                color: AppColors.primaryDark,
                                fontSize: 13,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                            const SizedBox(
                              width: 2.5,
                            ),
                            InkWell(
                              onTap: () {
                                FocusManager.instance.primaryFocus?.unfocus();
                                //   widget.controller.animateToPage(1,
                                //       duration: const Duration(milliseconds: 500),
                                //       curve: Curves.ease);
                                // },
                                emailval = emailController.text.toString();
                                Navigator.pushReplacement(context,
                                    MaterialPageRoute(builder: (context) =>
                                        SendingMail(email: emailval)));
                              },
                              child: Text(
                                'Sign Up',
                                style: TextStyle(
                                  color: Color(0xff098c51),
                                  fontSize: 13,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: 15,
                        ),
                        Text(
                          'Forget Password?',
                          style: TextStyle(
                            color: Color(0xff098c51),
                            fontSize: 13,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      );
    }
  }

