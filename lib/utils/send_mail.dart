import 'dart:async';
import 'package:dream/main.dart';
import 'package:email_otp/email_otp.dart';
import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';
import 'package:flutter/services.dart';


class SendingMail extends StatefulWidget {
  SendingMail({Key? key,required this.email} ) : super(key: key);
  String ?email;

  @override
  State<SendingMail> createState() => _SendingMail();
}

class _SendingMail extends State<SendingMail> {
  // TextEditingController email = new TextEditingController();
  TextEditingController otp = new TextEditingController();
  EmailOTP myauth = EmailOTP();

  bool _visible = false;
  VideoPlayerController? _controller = VideoPlayerController.asset(
      "assets/fire.mp4");

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
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children:[
          _getVideoBackground(),


          Positioned(
              left: 70,
              top: 200,
              child:
              Text("Verification Code",style: Theme.of(context).textTheme.displayLarge!.copyWith(fontStyle:FontStyle.normal,fontSize: 35,color: Colors.white))

          ),

          Container(
          child: Padding(
            padding: const EdgeInsets.all(15),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Card(
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: TextFormField(
                            keyboardType: TextInputType.number,
                            controller: otp,
                            decoration:
                            const InputDecoration(hintText: "                                Enter OTP")),
                      ),
                      ElevatedButton(
                          onPressed: () async {
                            if (await myauth.verifyOTP(otp: otp.text) == true) {
                              ScaffoldMessenger.of(context)
                                  .showSnackBar(const SnackBar(
                                content: Text("OTP is verified"),
                              ));
                              Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>MyHomePage()));
                            } else {
                              ScaffoldMessenger.of(context)
                                  .showSnackBar(const SnackBar(
                                content: Text("Invalid OTP"),
                              ));
                            }
                          },
                          child: const Text("Verify",style: TextStyle(fontSize: 15,fontWeight: FontWeight.bold),)),
                    ],
                  ),
                ),
                SizedBox(
                  width: 10,
                  height: 10,
                ),
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
                                theme:"v3"
                            );

                            myauth.setConfig(
                                appEmail: "aryasingh8405@gmail.com",
                                appName: "For Your Verification",
                                userEmail: widget.email,
                                otpLength: 10,
                                otpType: OTPType.digitsOnly
                            );
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
                          child: const Text("Send OTP",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 15),)),
                    ],
                  ),
                ),

              ],
            ),
          ),
        ),]
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
