import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:instagram_app/config/theme_service.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

const moonIcon = CupertinoIcons.moon_stars;

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Images',
          style: Theme.of(context).textTheme.headline6?.copyWith(
              color: Theme.of(context).textTheme.headline6?.color,
              fontSize: 22),
        ),
        actions: [
          IconButton(
            icon: const Icon(
              moonIcon,
              color: Colors.black,
            ),
            onPressed: () {
              ThemeService().changeTheme();
            },
          ),
          IconButton(
            icon: const Icon(
              CupertinoIcons.heart,
              color: Colors.black,
            ),
            onPressed: () {},
          ),
        ],
      ),
    );
  }
}
