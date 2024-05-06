import 'dart:async';
import 'dart:math';
import 'package:dream/main.dart';
import 'package:email_otp/email_otp.dart';
import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';
import 'package:flutter/services.dart';
import 'package:flutter_otp_text_field/flutter_otp_text_field.dart';

class SendingMail extends StatefulWidget {
  SendingMail({Key? key, required this.email}) : super(key: key);
  String? email;

  @override
  State<SendingMail> createState() => _SendingMail();
}

class _SendingMail extends State<SendingMail> {
  // TextEditingController email = new TextEditingController();
  // TextEditingController otp = new TextEditingController();
  String otp = "";
  EmailOTP myauth = EmailOTP();

  bool _visible = false;
  VideoPlayerController? _controller =
      VideoPlayerController.asset("assets/fire.mp4");

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
      opacity: _visible ? 1.0 : 0.0,
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

  bool k = false;
  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      child: Scaffold(
        body: Stack(children: [
          _getVideoBackground(),

          // Positioned(
          //     left: 70,
          //     top: 200,
          //     child:
          //     T
          //
          // ),

          Container(
            child: Padding(
              padding: const EdgeInsets.all(15),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text("Verification Code",
                      style: Theme.of(context).textTheme.titleMedium!.copyWith(
                          fontStyle: FontStyle.normal,
                          fontSize: 50,
                          color: Colors.white)),
                  Card(
                    child: Column(
                      children: [
                        // Padding(
                        //   padding: const EdgeInsets.all(8.0),
                        //   child: TextFormField(
                        //       controller: email,
                        //       decoration:
                        //       const InputDecoration(hintText: "User Email")),
                        // ),

                        ElevatedButton(
                            onPressed: () async {
                              myauth.setTheme(
                                  theme: "v${Random().nextInt(2) + 1}");

                              myauth.setConfig(
                                  appEmail: "aryasingh8405@gmail.com",
                                  appName: "For Your Verification",
                                  userEmail: widget.email,
                                  otpLength: 6,
                                  otpType: OTPType.digitsOnly);
                              if (await myauth.sendOTP() == true) {
                                ScaffoldMessenger.of(context)
                                    .showSnackBar(const SnackBar(
                                  content: Text("OTP has been sent"),
                                ));
                              } else {
                                ScaffoldMessenger.of(context)
                                    .showSnackBar(const SnackBar(
                                  content: Text("Oops, OTP send failed"),
                                ));
                              }
                            },
                            child: const Text(
                              "Send OTP",
                              style: TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 15),
                            )),
                      ],
                    ),
                  ),
                  Card(
                    child: Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: OtpTextField(
                            fieldWidth: 40,
                            fieldHeight: 50,
                            numberOfFields: 6,
                            borderColor: Colors.pinkAccent,
                            enabledBorderColor: Colors.black,
                            fillColor: Colors.green,
                            filled: k,
                            focusedBorderColor: Colors.red,
                            // styles: otpTextStyles,
                            showFieldAsBox: false,
                            borderWidth: 2.0,
                            //runs when a code is typed in
                            onCodeChanged: (String code) {
                              //handle validation or checks here if necessary
                            },
                            keyboardType: TextInputType.number,
                            //runs when every textfield is filled
                            onSubmit: (String verificationCode) {
                              otp = verificationCode;
                              setState(() {
                                k = true;
                              });
                            },
                          ),
                          // child: TextFormField(
                          //     keyboardType: TextInputType.number,
                          //     controller: otp,
                          //     decoration:
                          //     InputDecoration(hintText: "                                        Enter OTP",suffixIcon: Icon(Icons.numbers_sharp))),
                        ),
                        ElevatedButton(
                            onPressed: () async {
                              if (await myauth.verifyOTP(otp: otp) == true) {
                                ScaffoldMessenger.of(context)
                                    .showSnackBar(const SnackBar(
                                  content: Text("OTP is verified"),
                                ));
                                Navigator.pushReplacement(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => MyHomePage()));
                              } else {
                                ScaffoldMessenger.of(context)
                                    .showSnackBar(const SnackBar(
                                  content: Text("Invalid OTP"),
                                ));
                              }
                            },
                            child: Text("V e r i f y",
                                style: Theme.of(context)
                                    .textTheme
                                    .titleMedium!
                                    .copyWith(
                                        fontStyle: FontStyle.normal,
                                        fontSize: 20,
                                        fontWeight: FontWeight.bold))),
                      ],
                    ),
                  ),
                  SizedBox(
                    width: 10,
                    height: 10,
                  ),
                ],
              ),
            ),
          ),
        ]),
      ),
    );
  }
}
//
// int number()
// {
//   int start=0;
//   for (int i=0;i<4;i++)
//   {
//     final random=Random();
//     int val=random.nextInt(9);
//
//     if (i!=0)
//     start+= pow(10,3-i).toInt()*val;
//     if (i==0) {
//       if (val==0)val++;
//       start += pow(10, 3 - i).toInt() * (val);
//     }
//   }
//   return start;
// }
