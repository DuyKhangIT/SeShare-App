import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:instagram_app/assets/assets.dart';
import 'package:instagram_app/config/theme_service.dart';

import '../../config/share_preferences.dart';
import '../onboarding/start_up.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

const moonIcon = CupertinoIcons.moon_stars;

class _HomeState extends State<Home> {
  int _selectedIndex = 0;

  static List<Widget> _widgetOptions = <Widget>[
    HomeScreen(),
    SearchScreen(),
    NotificationScreen(),
    ProfileScreen(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    final FirebaseAuth auth = FirebaseAuth.instance;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        title: Text(
          'Images',
          style: Theme.of(context).textTheme.headline6?.copyWith(
              color: Theme.of(context).textTheme.headline6?.color,
              fontSize: 22),
        ),
        actions: [
          GestureDetector(
            onTap: (){
              ThemeService().changeTheme();
            },
            child: Container(
              width: 20,
              height: 20,
              margin: const EdgeInsets.only(right: 20),
              child: ColorFiltered(
                colorFilter: ColorFilter.mode(
                  Theme.of(context).brightness == Brightness.dark
                      ? Colors.white
                      : Colors.black,
                  BlendMode.srcIn,
                ),
                child: const Icon(
                  moonIcon,
                ),
              ),
            ),
          ),
          GestureDetector(
            onTap: (){
              auth.signOut();
              ConfigSharedPreferences().setStringValue(
                  SharedData.USER_ID.toString(), "");
              Navigator.pushNamedAndRemoveUntil(
                  context, 'login', (route) => false);
            },
            child: Container(
              width: 20,
              height: 20,
              margin: const EdgeInsets.only(right: 20),
              child: ColorFiltered(
                colorFilter: ColorFilter.mode(
                  Theme.of(context).brightness == Brightness.dark
                      ? Colors.white
                      : Colors.black,
                  BlendMode.srcIn,
                ),
                child: Image.asset(IconsAssets.icMessage),
              ),
            ),
          )
        ],
        elevation: 0,
      ),
      body: _widgetOptions.elementAt(_selectedIndex),
      bottomNavigationBar: BottomNavigationBar(
        items: <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: IconTheme(
                data: IconThemeData(
                  color: Theme.of(context).brightness == Brightness.dark
                      ? Colors.white
                      : Colors.black,
                ),
                child: Icon(Icons.home)),
            label: '',
          ),
          BottomNavigationBarItem(
            icon: IconTheme(
                data: IconThemeData(
                  color: Theme.of(context).brightness == Brightness.dark
                      ? Colors.white
                      : Colors.black,
                ),
                child: Icon(Icons.search)),
            label: '',
          ),
          BottomNavigationBarItem(
            icon: IconTheme(
                data: IconThemeData(
                  color: Theme.of(context).brightness == Brightness.dark
                      ? Colors.white
                      : Colors.black,
                ),
                child: Icon(
                  CupertinoIcons.heart,
                )),
            label: '',
          ),
          BottomNavigationBarItem(
            icon: IconTheme(
                data: IconThemeData(
                  color: Theme.of(context).brightness == Brightness.dark
                      ? Colors.white
                      : Colors.black,
                ),
                child: Icon(Icons.person)),
            label: '',
          ),
        ],
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
      ),
    );
  }
}

class HomeScreen extends StatelessWidget {
  final FirebaseAuth auth = FirebaseAuth.instance;
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(auth.currentUser!.uid),
    );
  }
}

class SearchScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text('Search Screen'),
    );
  }
}

class NotificationScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text('Notification Screen'),
    );
  }
}

class ProfileScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text('Profile Screen'),
    );
  }
}
