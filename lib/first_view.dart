import 'package:flutter/material.dart';
import 'package:simple_animations/simple_animations.dart';
import 'package:flutter/rendering.dart';

class FirstPage extends StatefulWidget {
  @override
  _FirstPageState createState() => _FirstPageState();
}

class _FirstPageState extends State<FirstPage> {
  double shoesYPost = 0;
  double textsTopPostion = 0;
  double firstShoesOpacity = 1;
  double secondShoesOpacity = 0;
  double thirdShoesOpacity = 0;
  var arrProduct = ['AIRBORNE 19', 'SAFARI HURRACHE', 'AIR CLASSIC'];
  String productName = 'AIRBORNE 19';
  double productLeftPos = 10;
  double productRightPos = 10;
  double productOpacity = 1;

  int _selectedPage = 0;
  static const String SFFamily = "SF-Pro";
  static const String SFHeavyFont = 'SF-Pro-Text-Heavy';

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    print(MediaQuery.of(context).size.height);
    return Stack(
      children: <Widget>[
        Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height * 3,
          decoration: BoxDecoration(
              gradient: LinearGradient(
                  //stops: [0.1, 0.4, 0.45, 0.85, 0.86, 1],
                  begin: Alignment.topRight,
                  end: Alignment.bottomLeft,
                  colors: [
                    Color(0xff6F00FE),
                    Color(0xffF72648),
//                    Color(0xff4054FF),
//                    Color(0xff00E8CA),
//                    Color(0xffFFBA00),
//                    Color(0xff40A1FF)
                  ])),
        ),
        NotificationListener<ScrollNotification>(
            onNotification: (scrollNotification) {
              if (scrollNotification is ScrollStartNotification) {
                _onStartScroll(scrollNotification.metrics);
              } else if (scrollNotification is ScrollUpdateNotification) {
                _onUpdateScroll(scrollNotification.metrics);
              } else if (scrollNotification is ScrollEndNotification) {
                _onEndScroll(scrollNotification.metrics);
              }
            },
            child: SingleChildScrollView(
              child: Stack(children: [
                Container(
                  width: MediaQuery.of(context).size.width,
                  height: MediaQuery.of(context).size.height * 3,
                  color: Colors.transparent,
                ),
                AnimatedPositioned(
                    duration: Duration(milliseconds: 200),
                    child: Column(children: <Widget>[
                      Container(
                        child: RotatedBox(
                          quarterTurns: -1,
                          child: Text("AIR",
                              textAlign: TextAlign.right,
                              style: TextStyle(
                                  fontFamily: SFFamily,
                                  fontWeight: FontWeight.w700,
                                  fontSize: 200,
                                  color: Colors.black.withAlpha(30))),
                        ),
                        height: MediaQuery.of(context).size.height * 1.5,
                      ),
                      Container(
                        height: MediaQuery.of(context).size.height * 1.75,
                        child: RotatedBox(
                          quarterTurns: -1,
                          child: Text("SAFARI",
                              textAlign: TextAlign.right,
                              style: TextStyle(
                                  fontFamily: SFFamily,
                                  fontWeight: FontWeight.w700,
                                  fontSize: 200,
                                  color: Colors.black.withAlpha(30))),
                        ),
                      ),
                      Container(
                        height: MediaQuery.of(context).size.height * 2,
                        child: RotatedBox(
                          quarterTurns: -1,
                          child: Text("CLASSIC",
                              textAlign: TextAlign.right,
                              style: TextStyle(
                                  fontFamily: SFFamily,
                                  fontWeight: FontWeight.w700,
                                  fontSize: 200,
                                  color: Colors.black.withAlpha(30))),
                        ),
                      )
                    ]),
                    right: -50,
                    top: textsTopPostion),
                AnimatedPositioned(
                  left: -60,
                  top: MediaQuery.of(context).size.height * 0.3,
                  right: 10,
                  duration: Duration(milliseconds: 1000),
                  child: AnimatedOpacity(
                    opacity: firstShoesOpacity,
                    duration: Duration(milliseconds: 500),
                    child: Image.asset("assets/ic_page_1.png"),
                  ),
                ),
                AnimatedPositioned(
                  top: (MediaQuery.of(context).size.height * 1.3),
                  left: -60,
                  right: 10,
                  duration: Duration(milliseconds: 1000),
                  child: AnimatedOpacity(
                    opacity: secondShoesOpacity,
                    duration: Duration(milliseconds: 500),
                    child: Image.asset("assets/ic_page_2.png"),
                  ),
                ),
                AnimatedPositioned(
                  top: ((MediaQuery.of(context).size.height * 2.3)),
                  left: -60,
                  right: 10,
                  duration: Duration(milliseconds: 1000),
                  child: AnimatedOpacity(
                    opacity: thirdShoesOpacity,
                    duration: Duration(milliseconds: 500),
                    child: Image.asset("assets/ic_page_3.png"),
                  ),
                ),
              ]),
              scrollDirection: Axis.vertical,
              physics: PageScrollPhysics(parent: ClampingScrollPhysics()),
              //controller: _scrollController,
            )),
        AnimatedPositioned(
            child: AnimatedOpacity(
                duration: Duration(milliseconds: 300),
                opacity: productOpacity,
                child: Text(productName,
                    style: TextStyle(
                        fontFamily: SFFamily,
                        fontWeight: FontWeight.w700,
                        fontSize: 20,
                        color: Colors.white))),
            duration: Duration(milliseconds: 300),
            left: productLeftPos,
            top: 50),

      ],
    );
  }

  _onStartScroll(ScrollMetrics metrics) {
    print("Scroll Start");
  }

  _onUpdateScroll(ScrollMetrics metrics) {
    print("Scroll Update");
    setState(() {

      // Vertical Text Animation
      textsTopPostion = -metrics.extentBefore;

      // Product name animation
      var index = metrics.extentBefore / metrics.extentInside;
      productOpacity = 0;
      productLeftPos -= index;

      // Shoes Animations
      if (index <= 1) {
        firstShoesOpacity = 1 - index;
        secondShoesOpacity = 1 - (1 - index);
      }
      if (index > 1) {
        print("===========");
        print(1 - (1 - index));
        secondShoesOpacity = 1 + (1 - index);
        thirdShoesOpacity = 1 - (2 - index);
      }
      //
//      if (index == 0) {}
//      print("===========");
//      print(index);
//
//      print(metrics.extentBefore);
//      print("===========");
    });

//    print(metrics.extentBefore);
//    print(metrics);
  }

  _onEndScroll(ScrollMetrics metrics) {
    print("Scroll End");
    setState(() {
      var index = metrics.extentBefore / metrics.extentInside;
      productName = arrProduct[index.toInt()];
      productOpacity = 1.0;
      productLeftPos = 10;
    });

  }

  Container pageFirst(BuildContext context,
      {@required String text,
      @required String imageName,
      @required Color firstColor,
      @required Color secondColor}) {
    shoesYPost = MediaQuery.of(context).size.height / 4;
    return Container(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height,
      color: Colors.transparent,
//      decoration: BoxDecoration(
//          gradient:   LinearGradient(
//            stops: [0.6, 0.9],
//              begin: Alignment.topRight,
//              end: Alignment.bottomLeft,
//              colors: [firstColor, secondColor])
//      ),
    );
  }
}
