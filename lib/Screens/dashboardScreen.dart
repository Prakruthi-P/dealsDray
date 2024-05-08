import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
class DashBoardScreen extends StatefulWidget {
  const DashBoardScreen({super.key});

  @override
  State<DashBoardScreen> createState() => _DashBoardScreenState();
}

class _DashBoardScreenState extends State<DashBoardScreen> {
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      appBar: AppBar(
        elevation: 10.0,
        leading: Icon(Icons.menu),
        title:  Container(
          decoration: BoxDecoration(
              color: Colors.grey[200],
              borderRadius: BorderRadius.circular(10)
          ),
          padding: EdgeInsets.symmetric(horizontal: 10.0),
          child: Row(
            children: [
              Container(
               width: MediaQuery.of(context).size.width*0.08,
               height:  MediaQuery.of(context).size.height*0.08,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10)
                ),
                  child: Image.asset("assets/images/img.png",width: MediaQuery.of(context).size.width*0.08,height:  MediaQuery.of(context).size.height*0.08,)),
              Flexible(
                child: TextField(
                  decoration: InputDecoration(
                    hintText: 'Search here',
                    border: InputBorder.none,
                    hintStyle: TextStyle(color: Colors.grey),
                  ),
                  style: TextStyle(color: Colors.white),
                ),
              ),
              Icon(Icons.search),
            ],
          ),
        ),
        actions: [
          Icon(Icons.notifications_none_outlined)
        ],
      ),
      body: SingleChildScrollView(
        child: Container(
          child: Column(
            children: [
              Container(
                height: MediaQuery.of(context).size.height*0.4 ,
                width: MediaQuery.of(context).size.width,
                margin: EdgeInsets.symmetric(horizontal: 10),
                padding: EdgeInsets.all(30),

                child:ListView(
                  scrollDirection: Axis.horizontal,
                  children: [
                    Padding(
                      padding: EdgeInsets.all(8.0), // Add padding between cards
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(10),
                        child: Image.asset("assets/images/img_1.png"),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.all(8.0), // Add padding between cards
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(10),
                        child: Image.asset("assets/images/img_1.png"),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.all(8.0), // Add padding between cards
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(10),
                        child: Image.asset("assets/images/img_1.png"),
                      ),
                    ),


                  ],
                ),
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height*0.3,
                width: MediaQuery.of(context).size.width,
                child: Image.asset("assets/images/img3.png"),

              ),
              Container(
                height: MediaQuery.of(context).size.height*0.4 ,
                width: MediaQuery.of(context).size.width,
                margin: EdgeInsets.all(10),
                padding: EdgeInsets.all(10),
                color: Colors.lightBlueAccent,
                child:ListView(
                  scrollDirection: Axis.horizontal,
                  children: [
                    Padding(
                      padding: EdgeInsets.all(3.0), // Add padding between cards
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(10),
                        child: Image.asset("assets/images/img_2.png"),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.all(3.0), // Add padding between cards
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(10),
                        child: Image.asset("assets/images/img_3.png"),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.all(3.0), // Add padding between cards
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(10),
                        child: Image.asset("assets/images/img_4.png"),
                      ),
                    ),


                  ],
                ),
              ),


            ],

          ),
        ),
      )
    );
  }
}
