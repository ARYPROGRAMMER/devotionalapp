import 'dart:async';
import 'dart:io';
import 'package:dream/utils/send_mail.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../../utils/app_colors.dart';
import '../../utils/styles/text_field_style.dart';
import '../../utils/utils.dart';
import 'package:video_player/video_player.dart';
import 'package:email_validator/email_validator.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  // final PageController controller;

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  bool _visible = false;
  VideoPlayerController? _controller =
      VideoPlayerController.asset("assets/check.mp4");

  final TextEditingController emailController = TextEditingController();
  final TextEditingController _passController = TextEditingController();
  final formKey = GlobalKey<FormState>();
  // String? emailval = "";

  final _formKey = GlobalKey<FormState>();
  // declare a variable to keep track of the input text
  String _emailval = '';
  String _passval = "";
  bool check1 = false;
  bool check2 = false;

  // bool _validate = false;
  // bool _second = false;

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
                height: MediaQuery.of(context).size.height,
                width: MediaQuery.of(context).size.width,
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
                        style:
                            Theme.of(context).textTheme.displayMedium!.copyWith(
                                  fontStyle: FontStyle.normal,
                                  color: Colors.white,
                                  fontSize: 25,
                                  fontWeight: FontWeight.w500,
                                ),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      TextFormField(
                        // validator: (value) {
                        //   if (value == null || value.isEmpty) {
                        //     return "Enter your e-mail.";
                        //   }
                        //   return null;
                        // },
                        autovalidateMode: AutovalidateMode.onUserInteraction,
                        validator: (text) {
                          if (text == null || text.isEmpty) {
                            return 'Can\'t be empty';
                          }
                          if (text.length < 7) {
                            return 'Too short';
                          }

                          if (text.contains("@") == false) return 'Missing @';

                          return null;
                        },
                        // update the state variable when the text changes
                        onChanged: (text) {
                          setState(() {
                            _emailval = text;
                          });

                          ;
                        },

                        onTapOutside: (value) {
                          if (_emailval.contains("@") &&
                              _emailval.length > 7 &&
                              _emailval != null &&
                              !_emailval.isEmpty &&
                              EmailValidator.validate(_emailval)) check1 = true;
                          // else
                          //   _dialogBuilder(context);
                        },
                        // onSaved: (value) {
                        //   if (_emailval.contains("@") &&
                        //       _emailval.length > 7 &&
                        //       _emailval != null &&
                        //       !_emailval.isEmpty &&
                        //       EmailValidator.validate(_emailval)) check1 = true;
                        //   // else
                        //   //   _dialogBuilder(context);
                        // },
                        onFieldSubmitted: (value) {
                          if (_emailval.contains("@") &&
                              _emailval.length > 7 &&
                              _emailval != null &&
                              (!_emailval.isEmpty) &&
                              EmailValidator.validate(_emailval)) check1 = true;
                          // else
                          //   _dialogBuilder(context);
                        },

                        // controller: emailController,
                        // style: textFieldTextStyle(),
                        style: Theme.of(context)
                            .textTheme
                            .displayLarge!
                            .copyWith(
                                letterSpacing: 1,
                                fontStyle: FontStyle.normal,
                                fontSize: 17,
                                color: Colors.white),
                        decoration: InputDecoration(
                          hintText: 'Email',
                          hintStyle: Theme.of(context)
                              .textTheme
                              .titleMedium!
                              .copyWith(fontSize: 16, color: Colors.grey),
                          prefixIcon: Icon(Icons.email_outlined),
                          labelText: "Enter your Email Id",
                          labelStyle:
                              TextStyle(fontSize: 15, color: Colors.red),
                        ),
                      ),
                      const SizedBox(
                        height: 15,
                      ),
                      TextFormField(
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
                        // focusNode: FocusNode(
                        //   canRequestFocus: true,
                        // ),
                        // controller: _passController,
                        autovalidateMode: AutovalidateMode.onUserInteraction,
                        validator: (text) {
                          if (text == null || text.isEmpty) {
                            return 'Can\'t be empty';
                          }
                          if (text.length < 6) {
                            return 'Too short';
                          }
                          return null;
                        },
                        // update the state variable when the text changes
                        onChanged: (text) {
                          setState(() {
                            _passval = text;
                          });
                        },

                        onTapOutside: (value) {
                          if (_passval != null &&
                              !_passval.isEmpty &&
                              _passval.length > 6) check2 = true;
                          // else
                          //   _dialogBuilder(context);
                        },
                        // onSaved: (value) {
                        //   if (_passval != null &&
                        //       !_passval.isEmpty &&
                        //       _passval.length > 6) check2 = true;
                        //   // else
                        //   //   _dialogBuilder(context);
                        // },
                        onFieldSubmitted: (value) {
                          if (_passval != null &&
                              !_passval.isEmpty &&
                              _passval.length > 6) check2 = true;
                          // else
                          //   _dialogBuilder(context);
                        },

                        // style: textFieldTextStyle(),
                        style: Theme.of(context)
                            .textTheme
                            .displayLarge!
                            .copyWith(
                                letterSpacing: 1,
                                fontStyle: FontStyle.normal,
                                fontSize: 17,
                                color: Colors.white),
                        decoration: InputDecoration(
                          hintText: 'Password',
                          hintStyle: Theme.of(context)
                              .textTheme
                              .titleMedium!
                              .copyWith(fontSize: 16, color: Colors.grey),
                          prefixIcon: Icon(Icons.password_outlined),
                          labelText: "Enter Password",
                          labelStyle:
                              TextStyle(fontSize: 15, color: Colors.red),
                        ),
                      ),
                      const SizedBox(
                        height: 25,
                      ),
                      FractionallySizedBox(
                        widthFactor: 1,
                        child: ElevatedButton(
                            style: TextButton.styleFrom(
                              backgroundColor: Color(0xff098c51),
                              foregroundColor: AppColors.whiteColor,
                            ),
                            onPressed: () async {
                              if (check1 == false && check2 == false) {
                                _dialogBuilder(context);
                                return null;
                              }

                              // emailController.text.isEmpty
                              //     ? _validate = true
                              //     : null;
                              // _passController.text.isEmpty
                              //     ? _validate = true
                              //     : null;

                              // emailval = emailController.text.toString();

                              loadingDialog(context);
                              FocusManager.instance.primaryFocus?.unfocus();
                              // Future.delayed(const Duration(seconds: 2)).then(
                              //   (value) => Navigator.pop(context),
                              // );
                              Navigator.pushReplacement(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          SendingMail(email: _emailval)));
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
                              _dialogBuilder(context);
                              //   widget.controller.animateToPage(1,
                              //       duration: const Duration(milliseconds: 500),
                              //       curve: Curves.ease);
                              // },
                              // emailval = emailController.text.toString();
                              // Navigator.pushReplacement(
                              //     context,
                              //     MaterialPageRoute(
                              //         builder: (context) =>
                              //             SendingMail(email: _emailval)));
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
                      InkWell(
                        onTap: () {
                          _dialogBuilder(context);
                        },
                        child: Text(
                          'Forget Password?',
                          style: TextStyle(
                            color: Color(0xff098c51),
                            fontSize: 13,
                            fontWeight: FontWeight.w500,
                          ),
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

Future<void> _dialogBuilder(BuildContext context) {
  return showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Invalid Credentials',
              style: Theme.of(context).textTheme.displayMedium!.copyWith(
                  fontStyle: FontStyle.normal,
                  fontSize: 20,
                  color: Colors.red)),
          content: const Text('Either Email or Password is Incorrect\n'
              'Try Again or Click Forget Password'),
          actions: <Widget>[
            TextButton(
              style: TextButton.styleFrom(
                textStyle: Theme.of(context).textTheme.titleMedium!.copyWith(
                      fontStyle: FontStyle.normal,
                    ),
              ),
              child: const Text('Quit App'),
              onPressed: () {
                exit(0);
              },
            ),
            TextButton(
              style: TextButton.styleFrom(
                textStyle: Theme.of(context)
                    .textTheme
                    .titleMedium!
                    .copyWith(fontStyle: FontStyle.normal),
              ),
              child: const Text('Ok'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      });
}
