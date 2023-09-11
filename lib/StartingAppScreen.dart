
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:translator/HomeScreen.dart';

class StartingAppScreen extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _StartingAppScreenState();
  }

}
class _StartingAppScreenState extends State<StartingAppScreen> with TickerProviderStateMixin{
  late final _imageController;
  late final _textController;

  late CurvedAnimation imageAnimation;
  late CurvedAnimation textAnimation;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _imageController=AnimationController(vsync: this,duration: const Duration(milliseconds: 1450));
    _textController=AnimationController(vsync:this,duration: const Duration(milliseconds: 1250));
    imageAnimation=CurvedAnimation(parent: _imageController, curve: Curves.easeInOut);
    textAnimation=CurvedAnimation(parent: _textController, curve: Curves.fastOutSlowIn);
  }
  void startAnimation()async {
    imageAnimation.reverseCurve;
    await _imageController.forward();
    await _textController.forward();
    _imageController.reverse();
    await _textController.reverse();
  
    Navigator.pushReplacement(context, 
    PageRouteBuilder(
      transitionDuration: const Duration(milliseconds: 650),
      pageBuilder: (context, animation, secondaryAnimation) {
        return ScaleTransition(
          scale: animation,
          child: HomeScreen(),);
      },));
  }
  @override
  Widget build(BuildContext context) {
    startAnimation();
    // TODO: implement build
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.bottomRight,
            end: Alignment.topLeft,
            colors: [
                Theme.of(context).colorScheme.onSecondaryContainer,

                Theme.of(context).colorScheme.onPrimaryContainer,
                Theme.of(context).colorScheme.onPrimaryContainer.withOpacity(0.9),

                Theme.of(context).colorScheme.onPrimaryContainer,
             ]),

        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ScaleTransition(
              scale: _imageController,
              child: Image.asset("assets/images/one.webp")),
            const SizedBox(height: 12,),
            ScaleTransition(
              scale: _textController,
              child: Column(
                children: [
                  Text("English Translator ",
              style: GoogleFonts.lato(
                fontSize: 35,
                color: const Color.fromARGB(255, 17, 224, 207),
                fontWeight: FontWeight.bold),),
                const SizedBox(
                  height: 12,
                ),
                Text("Developed by Maher ",
              style: GoogleFonts.lato(
                fontSize: 35,
                color: const Color.fromARGB(255, 18, 219, 152),
                fontWeight: FontWeight.bold),)
                
                
                ],
              )),
             
          ],
        ),
      ),
    );
  }

}