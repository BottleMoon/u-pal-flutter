import 'package:flutter/material.dart';
import 'package:u_pal/view/chat_view.dart';
import 'package:u_pal/view/mypage_view.dart';
import 'package:u_pal/view/recommend_view.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  int _selectedIndex = 0;

  List<Widget> _widgetOptions = [RecommendView(), ChatView(), MypageView()];

  void _onItemTapped(int value) {
    setState(() {
      _selectedIndex = value;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: _widgetOptions.elementAt(_selectedIndex),
        bottomNavigationBar: BottomNavigationBar(
          items: [
            BottomNavigationBarItem(
                icon: Icon(Icons.people), label: "Recommend"),
            BottomNavigationBarItem(icon: Icon(Icons.chat), label: "Chat"),
            BottomNavigationBarItem(
                icon: Icon(Icons.settings), label: "My Page"),
          ],
          currentIndex: _selectedIndex,
          onTap: _onItemTapped,
        ));
  }
}
