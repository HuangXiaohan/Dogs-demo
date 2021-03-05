import 'package:dogs_bloc/resources/dogListBlocProvider.dart';
import 'package:dogs_bloc/ui/dogList.dart';
import 'package:dogs_bloc/ui/login.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _HomePage();
}

class _HomePage extends State<HomePage> {
  int _selectedIndex = 0;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    DogListBlocProvider.of(context).getDogList.add("");
  }

  Widget body(int index) {
    switch (index) {
      case 0:
        return Login();
        break;
      case 1:
        return DogList();
        break;
      default:
        return Login();
    }
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Dogs demo'),
      ),
      body: Center(child: body(_selectedIndex)),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Login',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.list_alt),
            label: 'Dogs Breeds',
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.amber[800],
        onTap: _onItemTapped,
      ),
    );
  }
}
