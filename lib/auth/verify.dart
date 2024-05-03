import 'package:dream/utils/verification_temp.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class Verification extends StatelessWidget {
  const Verification({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Positioned(
            left: 70,
            top: 300,
            child:
                 Text("Verification Code",style: Theme.of(context).textTheme.displayMedium!.copyWith(fontStyle:FontStyle.normal,fontSize: 35,color: Colors.red))

            ),
          Positioned(
          left: 90,
          top: MediaQuery.of(context).size.height/2-10,
          child: Container(
              child: VerificationCodeInput(
                keyboardType: TextInputType.number,
                length: 4,
                itemDecoration: BoxDecoration(
                  border: Border.all(width: 2,color: Colors.green),
                  // borderRadius: BorderRadius.circular(2),
                  // boxShadow: [BoxShadow(color:Colors.white,spreadRadius: 1)],
                  // shape: BoxShape.circle
                ),
                autofocus: true,
                onCompleted: (String value) {
                  //...
                  print(value);
                },
              )
          ),
        ),
        ]
      ),
    );


  }

}


