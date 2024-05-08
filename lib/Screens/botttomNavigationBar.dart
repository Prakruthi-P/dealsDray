import 'package:dealsdray/Screens/cartScreen.dart';
import 'package:dealsdray/Screens/categoriesScreen.dart';
import 'package:dealsdray/Screens/dashboardScreen.dart';
import 'package:dealsdray/Screens/dealsScreen.dart';
import 'package:dealsdray/Screens/profileScreen.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';


class BottomNavigation extends StatefulWidget {
  @override
  _BottomNavigationState createState() => _BottomNavigationState();
}

class _BottomNavigationState extends State<BottomNavigation> {
  int _selectedIndex = 0;

  final List<Widget> _pages = [
    DashBoardScreen(),
    CategoriesScreen(),
    DealsScreen(),
    CartScreen(),
    ProfileScreen(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _pages[_selectedIndex],
      floatingActionButton: SizedBox(
        width: MediaQuery.sizeOf(context).width*0.2,
        child: FloatingActionButton(
          backgroundColor: Colors.red,
          onPressed: () {  },
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(30)
            ),
            padding: EdgeInsets.symmetric(horizontal: 5,vertical: 5),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Icon(FontAwesomeIcons.commentDots,color: Colors.white,),
                Text("Chat",
                style: TextStyle(
                  color: Colors.white
                ),)
              ],
            ),
          ),

        ),
      ),
      bottomNavigationBar: _buildBottomNavigationBar(),
    );
  }

  BottomNavigationBar _buildBottomNavigationBar() {

    return BottomNavigationBar(
      currentIndex: _selectedIndex,
      selectedItemColor: Colors.red,
      onTap: _onItemTapped,
      items: [
        BottomNavigationBarItem(
          icon: Icon(
            Icons.home,
            size: 25,
            color: _selectedIndex == 0 ? Colors.red : Colors.grey,
          ),
          label: 'Home',

        ),
        BottomNavigationBarItem(
          icon: Icon(
            Icons.category_outlined,
            size: 25,
            color: _selectedIndex == 1 ? Colors.red : Colors.grey,
          ),
          label: 'Categories',
        ),
        BottomNavigationBarItem(
          icon: Icon(
            Icons.circle_rounded,
            size: 25,
            color: _selectedIndex == 2 ? Colors.red : Colors.grey,
          ),
          label: 'Deals',
        ),
        BottomNavigationBarItem(
          icon: Icon(
            Icons.shopping_cart,
            size: 25,
            color: _selectedIndex == 3 ? Colors.red : Colors.grey,
          ),
          label: 'Cart',
        ),
        BottomNavigationBarItem(
          icon: Icon(
            Icons.person_2_outlined,
            size: 25,
            color: _selectedIndex == 4 ? Colors.red : Colors.grey,
          ),
          label: 'Profile',
        ),
      ],
    );
  }
}
