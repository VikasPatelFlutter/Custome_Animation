import 'dart:async';

import 'package:flutter/material.dart';

class CarAnimation extends StatefulWidget {
  const CarAnimation({Key? key}) : super(key: key);

  @override
  State<CarAnimation> createState() => _CarAnimationState();
}

class _CarAnimationState extends State<CarAnimation>with TickerProviderStateMixin {
  double? wid,hei;
  bool showRegister = false;

  //region red and blue cars
  late final AnimationController _leftSideBadgeController = AnimationController(duration: const Duration(seconds: 6),vsync: this,)..repeat(reverse: false);
  late final Animation<AlignmentGeometry> _leftSideBadgeAnimation = Tween<AlignmentGeometry>(
    begin: Alignment.topLeft,
    end: Alignment.topRight,
  ).animate(CurvedAnimation(parent: _leftSideBadgeController, curve: Curves.easeInOut,));
  late final AnimationController _leftSideCarController = AnimationController(duration: const Duration(seconds: 6),vsync: this)..repeat(reverse: false,);
  late final Animation<AlignmentGeometry> _leftSideCarAnimation = Tween<AlignmentGeometry>(
    begin: Alignment.centerLeft,
    end: Alignment.centerRight,
  ).animate(CurvedAnimation(parent: _leftSideCarController, curve: Curves.easeInOut,));
  late final Animation<double> _leftSideCarAnimationFade = Tween<double>(
    begin:1.0,
    end: 0.2,
  ).animate(_leftSideCarController);
  //endregion

  //region yellow and black cars
  late final AnimationController _rightBadgeController = AnimationController(duration: const Duration(seconds: 6),vsync: this,)..repeat(reverse: false);
  late final Animation<AlignmentGeometry> _rightBadgeAnimation = Tween<AlignmentGeometry>(
    begin: Alignment.topRight,
    end: Alignment.topLeft,
  ).animate(CurvedAnimation(parent: _rightBadgeController, curve: Curves.easeInOut,));
  late final AnimationController _rightCarController = AnimationController(duration: const Duration(seconds: 6),vsync: this,)..repeat(reverse: false);
  late final Animation<AlignmentGeometry> _rightCarAnimation = Tween<AlignmentGeometry>(
    begin: Alignment.centerRight,
    end: Alignment.centerLeft,
  ).animate(CurvedAnimation(parent: _rightCarController, curve: Curves.easeInOut,));
  late final Animation<double> _rightCarAnimationFade = Tween<double>(
    begin:1.0,
    end: 0.2,
  ).animate(_rightCarController);
  //endregion

  //region bounce animation
  late final AnimationController _thumbsUpController = AnimationController(duration: const Duration(seconds: 4),vsync: this,value: 0.45,lowerBound: 0.45)..repeat(reverse: true,);
  late final Animation<double> _thumbsUpAnimation = CurvedAnimation(
    parent: _thumbsUpController,
    curve: Curves.easeInOut,
  );
  //endregion

  //region initState
  @override
  void initState() {
    super.initState();
    Timer(
        const Duration(minutes: 5),() {
      setState(() {
        showRegister = true;
      });
    }
    );
  }
  //endregion

  @override
  Widget build(BuildContext context) {
    wid = MediaQuery.of(context).size.width * 1.5;
    hei = MediaQuery.of(context).size.height * 0.16;

    return showRegister ? getNextWidget() : getAnimationWidget();
  }

  //region getAnimationWidget
  Widget getAnimationWidget(){
    return Scaffold(
      backgroundColor: Colors.white,//CustomColors.whiteBGColor,
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            //region green car animation
            SizedBox(
              height: hei,
              child: Stack(
                children: [
                  Positioned(
                    top: 0, bottom: 0,
                    left: 00, right: 0,
                    child: Center(
                      child: SizedBox(
                        width: wid,
                        child:  AlignTransition(
                            alignment: _rightCarAnimation,
                            child: Image.asset("assets/right1.png",height: MediaQuery.of(context).size.height*0.2)
                        ),
                      ),
                    ),
                  ),
                  Positioned(
                    top: 15, left: MediaQuery.of(context).size.width * 0.25, right: 10,
                    child: Container(
                      padding: const EdgeInsets.only(bottom: 35),
                      width: wid,
                      height: 200,
                      child: AlignTransition(
                        alignment: _rightBadgeAnimation,
                        child: ScaleTransition(
                            alignment: Alignment.center,
                            scale: _thumbsUpAnimation,
                            child: Image.asset("assets/ok.png",height: MediaQuery.of(context).size.height * 0.09)
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            //endregion

            //region blue car animation
            SizedBox(
              height: hei,
              child: Stack(
                children: [
                  Positioned(
                    top: 0, bottom: 0,
                    left: 0, right: 0,
                    child: Center(
                      child: SizedBox(
                        width: wid,
                        child:  AlignTransition(
                          alignment: _leftSideCarAnimation,
                          child: FadeTransition(
                              opacity: _leftSideCarAnimationFade,
                              child: Image.asset("assets/left1.png",height: MediaQuery.of(context).size.height*0.2)
                          ),
                        ),
                      ),
                    ),
                  ),
                  Positioned(
                    top: 0,
                    left: MediaQuery.of(context).size.width * 0.020, right: MediaQuery.of(context).size.width * 0.20,
                    child: Container(
                      padding: const EdgeInsets.only(bottom: 35),
                      width:MediaQuery.of(context).size.width,
                      height: 200,
                      child: AlignTransition(
                        alignment: _leftSideBadgeAnimation,
                        child: ScaleTransition(
                            alignment: Alignment.center,
                            scale: _thumbsUpAnimation,
                            child: Image.asset("assets/ok.png",height: MediaQuery.of(context).size.height * 0.09)
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),

            Stack(
              children: [
                SizedBox(
                  //color: Colors.brown,
                  height: MediaQuery.of(context).size.height*0.2,
                  width: MediaQuery.of(context).size.width,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Image.asset("assets/center.jpeg",height: MediaQuery.of(context).size.height * 0.20),
                    ],
                  ),
                ),
              ],
            ),
            //endregion

            //region white car animation
            SizedBox(
              height: hei,
              child: Stack(
                children: [
                  Positioned(
                    top: 0, bottom: 0,
                    left: 0, right: 0,
                    child: Center(
                      child: SizedBox(
                        width:MediaQuery.of(context).size.width*1.5,
                        child:  AlignTransition(
                          alignment: _rightCarAnimation,
                          child: FadeTransition(
                              opacity: _rightCarAnimationFade,
                              child: Image.asset("assets/right2.png",height: MediaQuery.of(context).size.height*0.2)//,height: 100)
                          ),
                        ),
                      ),
                    ),
                  ),
                  Positioned(
                    top: 0, left: MediaQuery.of(context).size.width* 0.2, right: 0,
                    child: Container(
                      padding: const EdgeInsets.only(bottom: 35),
                      width: wid,
                      height: 200,
                      child: AlignTransition(
                        alignment: _rightBadgeAnimation,
                        child: ScaleTransition(
                            alignment: Alignment.center,
                            scale: _thumbsUpAnimation,
                            child: Image.asset("assets/ok.png",height: MediaQuery.of(context).size.height * 0.09)
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            //endregion
            // region red car animation
            SizedBox(
              height: hei,
              child: Stack(
                children: [
                  Positioned(
                    top: 0, bottom: 0,
                    left: -30, right: -30,
                    child: Center(
                      child: Container(
                        padding: const EdgeInsets.only(bottom: 0),
                        width: wid,
                        child:  AlignTransition(
                            alignment: _leftSideCarAnimation,
                            child: Image.asset("assets/left2.jpeg",height: MediaQuery.of(context).size.height * 0.2)//,height: 100),
                        ),
                      ),
                    ),
                  ),
                  Positioned(
                    top: 0,
                    // left: 20, right: 120,
                    left: MediaQuery.of(context).size.width * 0.01, right: MediaQuery.of(context).size.width * 0.20,
                    child: Container(
                      padding: const EdgeInsets.only(bottom: 35),
                      width:MediaQuery.of(context).size.width,
                      height: 200,
                      child: AlignTransition(
                        alignment: _leftSideBadgeAnimation,
                        child: ScaleTransition(
                            alignment: Alignment.center,
                            scale: _thumbsUpAnimation,
                            child: Image.asset("assets/ok.png",height: MediaQuery.of(context).size.height * 0.09)
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            //endregion
          ],
        ),
      ),
    );
  }
  //endregion


  Widget getNextWidget(){
    return Scaffold(
        body: SafeArea(
          child: Container(
            padding: EdgeInsets.only(left: MediaQuery.of(context).size.width * 0.10,right: MediaQuery.of(context).size.width * 0.10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                /// Text
                RichText(
                  text: const TextSpan(
                      children:  [
                        TextSpan(
                          text: 'An ',
                        ),
                        TextSpan(
                            text: 'Animation',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                            )
                        ),
                        TextSpan(
                          text: ' object knows the current state of an animation (for example, whether it’s started, stopped, or moving forward or in reverse), but does’t know anything about what appears onscreen.',
                        ),
                      ],
                      style: TextStyle(
                          fontSize: 22,
                          fontFamily: "Poppins",
                          color: Colors.grey,//CustomColors.remainingOtpPinColor,
                          height: 1.3
                      )
                  ),
                  textAlign: TextAlign.center,
                ),

              ],
            ),
          ),
        )
    );
  }
  //endregion

  //region dispose
  @override
  void dispose() {
    // _goodToGoController.dispose();
    _leftSideBadgeController.dispose();
    _leftSideCarController.dispose();
    _rightBadgeController.dispose();
    _rightCarController.dispose();
    _thumbsUpController.dispose();
    super.dispose();
  }
//endregion

}