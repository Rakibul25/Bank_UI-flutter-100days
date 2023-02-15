import 'package:bank/Screens/login.dart';
import 'package:bank/Screens/splash.dart';
import 'package:bank/constants/color_constant.dart';
import 'package:bank/models/card_model.dart';
import 'package:bank/models/operation_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int current = 0;
  var nameController = TextEditingController();
  var nameValue = "";

  List<T> map<T>(List list, Function handler) {
    List<T> result = [];
    for (var i = 0; i < list.length; i++) {
      result.add(handler(i, list[i]));
    }
    return result;
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getValue();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        margin: EdgeInsets.only(top: 8),
        child: ListView(
          physics: const ClampingScrollPhysics(),
          children: <Widget>[
            Container(
              margin: EdgeInsets.only(left: 16, right: 16, top: 16),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  GestureDetector(
                      onTap: () {
                        print('tapped');
                      },
                      child: SvgPicture.asset(
                        'assets/svg/navbar.svg',
                        height: 35,
                        width: 35,
                      )),
                  Column(
                    children: [
                      Container(
                        height: 59,
                        width: 59,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(15),
                            image: DecorationImage(
                                image: AssetImage('assets/images/user.jpg'))),
                      ),
                      SizedBox(height: 11),
                      ElevatedButton(
                          onPressed: () async {
                            var sharedpref = await SharedPreferences.getInstance();
                            sharedpref.setBool(SplashState.keylogin, false);
                            Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => const logIn()));
                          },
                          child: Text('Log Out'))
                    ],
                  ),
                ],
              ),
            ),
            //card
            SizedBox(
              height: 25,
            ),
            Padding(
              padding: EdgeInsets.only(left: 16, bottom: 16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text('Good Morning',
                      style: GoogleFonts.inter(
                          fontSize: 18,
                          fontWeight: FontWeight.w500,
                          color: Color(0xFF000000))),
                  Text(nameValue,
                      style: GoogleFonts.inter(
                          fontSize: 20,
                          fontWeight: FontWeight.w700,
                          color: Color(0xFF000000)))
                ],
              ),
            ),
            Container(
              height: 199,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                padding: EdgeInsets.only(left: 16, right: 6),
                itemCount: cards.length,
                itemBuilder: (context, index) {
                  return Container(
                    margin: EdgeInsets.only(right: 10),
                    height: 199,
                    width: 344,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(28),
                      color: Color(cards[index].cardBackground),
                    ),
                    child: Stack(
                      children: <Widget>[
                        Positioned(
                          child: SvgPicture.asset(cards[index].cardElementTop,
                              height: 80, width: 80),
                        ),
                        Positioned(
                          bottom: 50,
                          right: 10,
                          child: SvgPicture.asset(
                              cards[index].cardElementBottom,
                              height: 80,
                              width: 80),
                        ),
                        Positioned(
                          left: 29,
                          top: 75,
                          child: Text(
                            cards[index].cardNumber,
                            style: GoogleFonts.inter(
                                fontSize: 20,
                                fontWeight: FontWeight.w700,
                                color: Colors.white),
                          ),
                        ),
                        Positioned(
                          top: 15,
                          left: 25,
                          child: SvgPicture.asset(cards[index].cardType,
                              height: 50, width: 50),
                        ),
                        Positioned(
                          left: 29,
                          top: 100,
                          child: Text(
                            cards[index].user,
                            style: GoogleFonts.inter(
                                fontSize: 20,
                                fontWeight: FontWeight.w700,
                                color: Colors.white),
                          ),
                        ),
                        Positioned(
                          bottom: 10,
                          right: 85,
                          child: Text(
                            cards[index].cardExpired,
                            style: GoogleFonts.inter(
                                fontSize: 15,
                                fontWeight: FontWeight.w400,
                                color: Colors.black45),
                          ),
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),
            Padding(
              padding:
                  EdgeInsets.only(left: 16, bottom: 13, top: 29, right: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Row(
                    children: map<Widget>(
                      datas,
                      (index, selected) {
                        return Container(
                          alignment: Alignment.center,
                          height: 9,
                          width: 9,
                          margin: EdgeInsets.only(right: 6),
                          decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: current == index
                                  ? kGreenColor
                                  : kTwentyBlueColor),
                        );
                      },
                    ),
                  )
                ],
              ),
            ),

            Container(
              height: 123,
              child: ListView.builder(
                itemCount: datas.length,
                padding: EdgeInsets.only(left: 16),
                scrollDirection: Axis.horizontal,
                itemBuilder: (context, index) {
                  return GestureDetector(
                    onTap: () {
                      setState(() {
                        current = index;
                      });
                    },
                    child: OperationCard(
                        operation: datas[index].name,
                        selectedIcon: datas[index].selectedIcon,
                        unselectedIcon: datas[index].unselectedIcon,
                        isSelected: current == index,
                        context: this),
                  );
                },
              ),
            ),

            Padding(
              padding: EdgeInsets.only(left: 16, bottom: 16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  TextField(
                    controller: nameController,
                    decoration: InputDecoration(
                      border: InputBorder.none,
                      labelText: 'Enter Name',
                    ),
                  ),
                  SizedBox(height: 11),
                  ElevatedButton(
                      onPressed: () async {
                        var name = nameController.text.toString();
                        var prefs = await SharedPreferences.getInstance();
                        prefs.setString("name", name);
                      },
                      child: Text('Save'))
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> getValue() async {
    var prefs = await SharedPreferences.getInstance();
    var getName = prefs.getString("name");
    nameValue = getName ?? "Name Here";
    setState(() {});
  }
}

class OperationCard extends StatefulWidget {
  final String operation;
  final String selectedIcon;
  final String unselectedIcon;
  final bool isSelected;
  _HomeScreenState context;

  OperationCard(
      {required this.operation,
      required this.selectedIcon,
      required this.unselectedIcon,
      required this.isSelected,
      required this.context});

  @override
  _OperationCardState createState() => _OperationCardState();
}

class _OperationCardState extends State<OperationCard> {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(right: 16),
      width: 123,
      height: 123,
      decoration: BoxDecoration(
          boxShadow: [
            BoxShadow(
              color: kTenBlackColor,
              blurRadius: 10,
              spreadRadius: 5,
              offset: Offset(8.0, 8.0),
            )
          ],
          borderRadius: BorderRadius.circular(15),
          color: widget.isSelected ? kGreenColor : kWhiteColor),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          SvgPicture.asset(
              widget.isSelected ? widget.selectedIcon : widget.unselectedIcon),
          SizedBox(
            height: 9,
          ),
          Text(
            widget.operation,
            textAlign: TextAlign.center,
            style: GoogleFonts.inter(
                fontSize: 15,
                fontWeight: FontWeight.w700,
                color: widget.isSelected ? kWhiteColor : kGreenColor),
          )
        ],
      ),
    );
  }
}
