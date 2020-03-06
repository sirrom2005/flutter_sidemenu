import 'package:flutter/material.dart';

final Color backGroundColor = Color(0xff4a4a58);

class MainDashBoardPage extends StatefulWidget {
  @override
  _MainDashBoardPageState createState() => _MainDashBoardPageState();
}

class _MainDashBoardPageState extends State<MainDashBoardPage> with SingleTickerProviderStateMixin {
  bool isCallapsed = true;
  double screenWidth, screenHeight;
  final Duration duration = const Duration(milliseconds: 300);
  AnimationController _controller;
  Animation<double> _scaleAnimation;
  Animation<double> _menuScaleAnimation;
  Animation<Offset> _slideAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(vsync: this, duration: duration);
    _scaleAnimation = Tween<double>(begin: 1, end: 0.6).animate(_controller);
    _menuScaleAnimation = Tween<double>(begin: 0.2, end: 1).animate(_controller);
    _slideAnimation = Tween<Offset>(begin: Offset(-1, 0), end: Offset(0, 0)).animate(_controller);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    screenWidth = size.width;
    screenHeight = size.height;
    return Scaffold(
      backgroundColor: backGroundColor,
      body: Stack(
        children: <Widget>[
          menu(context),
          dashboard(context)
        ],
      ),
    );
  }

  Widget menu(context){
    return SlideTransition(
        position: _slideAnimation,
        child: ScaleTransition(
          scale: _menuScaleAnimation,
          child: Padding(
          padding: const EdgeInsets.only(left: 16),
          child: Align(
            alignment: Alignment.centerLeft,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text('Dashboard', style: TextStyle(color: Colors.white, fontSize: 22)),
                SizedBox(height: 10),
                Text('Messages', style: TextStyle(color: Colors.white, fontSize: 22)),
                SizedBox(height: 10),
                Text('Utitly Bills', style: TextStyle(color: Colors.white, fontSize: 22)),
                SizedBox(height: 10),
                Text('Funds Transfer', style: TextStyle(color: Colors.white, fontSize: 22)),
                SizedBox(height: 10),
                Text('Branches', style: TextStyle(color: Colors.white, fontSize: 22)),
              ],
            ),
          ),
      ),
        ),
    );
  }

  Widget dashboard(context)
  {
    return AnimatedPositioned(
      duration: duration,
      top:    0,//isCallapsed? 0 : 0.2*screenHeight,
      bottom: 0,//isCallapsed? 0 : 0.2*screenWidth,
      left:   isCallapsed? 0 : 0.4  * screenWidth,
      right:  isCallapsed? 0 : -0.4 * screenWidth,
        child: ScaleTransition(
          scale: _scaleAnimation,
          child: Material(
            animationDuration: duration,
            borderRadius: BorderRadius.all(Radius.circular(40)),
            elevation: 8,
            color: backGroundColor,
            child: SingleChildScrollView(
              scrollDirection: Axis.vertical,
              child: Container(
                padding: const EdgeInsets.only(left: 16, right: 16, top:48,),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      mainAxisSize: MainAxisSize.max,
                      children: <Widget>[
                        InkWell(
                          child: Icon(Icons.menu, color: Colors.white,), onTap:(){
                          setState(() {
                            if(isCallapsed)
                              _controller.forward();
                            else
                              _controller.reverse();
                            isCallapsed = !isCallapsed;
                          });
                        }),
                        Text('My Cards', style: TextStyle(fontSize: 24, color:Colors.white),),
                        Icon(Icons.settings, color: Colors.white),
                      ],
                    ),
                    SizedBox(height: 50),
                    Container(
                      height: 200,
                      child: PageView(
                        controller: PageController(viewportFraction: 0.8),
                        scrollDirection: Axis.horizontal,
                        pageSnapping: true,
                        children: <Widget>[
                          Container(
                            margin: EdgeInsets.symmetric(horizontal: 0.8),
                            color: Colors.redAccent,
                            width: 100,
                          ),
                          Container(
                            margin: EdgeInsets.symmetric(horizontal: 0.8),
                            color: Colors.blueAccent,
                            width: 100,
                          ),
                          Container(
                            margin: EdgeInsets.symmetric(horizontal: 0.8),
                            color: Colors.amberAccent,
                            width: 100,
                          ),                      
                        ],
                      ),
                    ),
                    SizedBox(height: 20),
                    Text('Data', style: TextStyle(fontSize: 20, color: Colors.white),),
                    SizedBox(height: 2),
                    Text('Data', style: TextStyle(fontSize: 15, color: Colors.white),),
                    ListView.separated(
                      shrinkWrap: true,
                      itemCount: 10,
                      itemBuilder: (BuildContext context, int index) {
                        return listViewContainerItem(index);
                      },
                      separatorBuilder: (BuildContext context, int index) => Divider(height: 1,color: Colors.white, thickness: 0,),
                    )
                  ],
                ),
              ),
            ),
          ),
        ),
      );
  }
}

Widget listViewContainerItem(int index){
  return 
  Container(
            margin: EdgeInsets.symmetric(horizontal: 0.8),
            color: Colors.amberAccent,
            width: 100,
            height: 150,
          );
}