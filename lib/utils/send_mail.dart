import 'package:email_otp/email_otp.dart';
import 'package:flutter/material.dart';

class SendingMail extends StatefulWidget {
  const SendingMail({Key? key}) : super(key: key);

  @override
  State<SendingMail> createState() => _SendingMail();
}

class _SendingMail extends State<SendingMail> {
  TextEditingController email = new TextEditingController();
  TextEditingController otp = new TextEditingController();
  EmailOTP myauth = EmailOTP();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children:[


          Positioned(
              left: 70,
              top: 300,
              child:
              Text("Verification Code",style: Theme.of(context).textTheme.displayMedium!.copyWith(fontStyle:FontStyle.normal,fontSize: 35,color: Colors.red))

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
                            controller: email,
                            decoration:
                            const InputDecoration(hintText: "User Email")),
                      ),
                      ElevatedButton(
                          onPressed: () async {
                            myauth.setTheme(
                                theme:"v3"
                            );

                            myauth.setConfig(
                                appEmail: "aryasingh8405@gmail.com",
                                appName: "For Your Verification",
                                userEmail: email.text,
                                otpLength: 4,
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
                          child: const Text("Send OTP")),
                    ],
                  ),
                ),
                Card(
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: TextFormField(
                            controller: otp,
                            decoration:
                            const InputDecoration(hintText: "Enter OTP")),
                      ),
                      ElevatedButton(
                          onPressed: () async {
                            if (await myauth.verifyOTP(otp: otp.text) == true) {
                              ScaffoldMessenger.of(context)
                                  .showSnackBar(const SnackBar(
                                content: Text("OTP is verified"),
                              ));
                            } else {
                              ScaffoldMessenger.of(context)
                                  .showSnackBar(const SnackBar(
                                content: Text("Invalid OTP"),
                              ));
                            }
                          },
                          child: const Text("Verify")),
                    ],
                  ),
                )
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
