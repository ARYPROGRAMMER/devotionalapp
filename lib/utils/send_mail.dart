import 'package:flutter/material.dart';
import 'dart:math';


class SendingMail extends StatelessWidget {
  const SendingMail({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: ElevatedButton(
          onPressed: (){
            print(number());
          },
          child: Text("sample"),
        ),
      )
    );
  }
}

int number()
{
  int start=0;
  for (int i=0;i<4;i++)
  {
    final random=Random();
    int val=random.nextInt(9);

    if (i!=0)
    start+= pow(10,3-i).toInt()*val;
    if (i==0) {
      if (val==0)val++;
      start += pow(10, 3 - i).toInt() * (val);
    }
  }
  return start;
}
