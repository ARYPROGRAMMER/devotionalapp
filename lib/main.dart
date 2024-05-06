import 'dart:io';

import 'package:dream/utils/parallaxing.dart';
import 'package:dream/utils/splash.dart';
import 'package:flutter/material.dart';
import 'package:flutter/gestures.dart';

void main() {
  runApp(const MyApp());
}

//for fun
class DragScrollBehavior extends MaterialScrollBehavior {
  @override
  Set<PointerDeviceKind> get dragDevices => {
        PointerDeviceKind.touch,
        PointerDeviceKind.mouse,
      };
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'DreamAI',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        textTheme: const TextTheme(
          displayLarge: const TextStyle(
              color: Colors.green,
              fontWeight: FontWeight.bold,
              fontStyle: FontStyle.italic,
              fontFamily: "fontmain1"),
          displayMedium: const TextStyle(
              color: Colors.greenAccent,
              fontWeight: FontWeight.bold,
              fontStyle: FontStyle.italic,
              fontFamily: "fontmain1"),
          displaySmall: const TextStyle(
              color: Colors.lightGreen,
              fontWeight: FontWeight.bold,
              fontStyle: FontStyle.italic,
              fontFamily: "fontmain3"),
          titleMedium: const TextStyle(
              color: Colors.greenAccent,
              fontWeight: FontWeight.bold,
              fontStyle: FontStyle.italic,
              fontFamily: "fontmain4"),
        ),
        primarySwatch: Colors.lightBlue,
      ),
      home: const SplashScreen(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  static const images = <String>[
    'assets/dreamai.png',
    'assets/dreamai.png',
    'assets/image3.png',
    'assets/image4.png',
    'assets/image2.png'
  ];
  @override
  void setState(VoidCallback fn) {
    // TODO: implement setState
    super.setState(fn);
    if (images.isEmpty) {
      return;
    }
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      onPopInvoked: (didpop)
      {
        _dialogBuilder(context);

      },
      child: Scaffold(
        body: Container(
          width: double.infinity,
          height: double.infinity,
          color: const Color(0xff000000),
          child: SingleChildScrollView(
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.only(
                      top: 90.0, left: 90.0, right: 90.0, bottom: 30.0),
                  child: Text("Sample Clickable Images",
                      style: Theme.of(context).textTheme.displayLarge!.copyWith(
                          fontStyle: FontStyle.normal,
                          fontWeight: FontWeight.bold,
                          fontSize: 18,
                          color: Colors.white)),
                ),
                InkWell(
                  onTap: () {
                    final snackBar =
                        SnackBar(content: const Text('To some other page!!'));
                    ScaffoldMessenger.of(context).showSnackBar(snackBar);
                  },
                  child: SizedBox(
                    height: 500,
                    child: ParallaxSwiper(
                      images: images,
                      viewPortFraction: 0.90,
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.all(15.0),
                ),
                InkWell(
                  onTap: () {
                    final snackBar =
                        SnackBar(content: const Text('To some other page!!'));
                    ScaffoldMessenger.of(context).showSnackBar(snackBar);
                  },
                  child: SizedBox(
                    height: 500,
                    child: ParallaxSwiper(
                      images: images,
                      viewPortFraction: 0.90,
                      backgroundZoomEnabled: true,
                      foregroundFadeEnabled: true,
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.all(15.0),
                ),
                InkWell(
                  onTap: () {
                    final snackBar =
                        SnackBar(content: const Text('To some other page!!'));
                    ScaffoldMessenger.of(context).showSnackBar(snackBar);
                    // Some code to undo the change.
                  },
                  child: SizedBox(
                    height: 500,
                    child: ParallaxSwiper(
                      images: images,
                      viewPortFraction: 0.90,
                      backgroundZoomEnabled: true,
                      foregroundFadeEnabled: true,
                    ),
                  ),
                ),
              ],
            ),
          ),
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
          title:  Text('Confirm Exit',style: Theme.of(context).textTheme.displayMedium!.copyWith(fontStyle:FontStyle.normal,fontSize:20,color: Colors.red)),
          content: const  Text(
              'Are you Sure to Quit?'
          ),
          actions: <Widget>[
            TextButton(
              style: TextButton.styleFrom(
                textStyle: Theme
                    .of(context)
                    .textTheme
                    .titleMedium!.copyWith(fontStyle:FontStyle.normal,),
              ),
              child: const Text('Quit'),
              onPressed: () {
                exit(0);
              },
            ),
            TextButton(
              style: TextButton.styleFrom(
                textStyle: Theme
                    .of(context)
                    .textTheme
                    .titleMedium!.copyWith(fontStyle:FontStyle.normal),
              ),
              child: const Text('Continue'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      }
  );
}
