import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class BottomNavigationBarWidget extends StatelessWidget {
  final int currentIndex;

  const BottomNavigationBarWidget({
    Key? key,
    required this.currentIndex,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 75,
      child: BottomNavigationBar(
        backgroundColor: Color(0xFF003049),
        selectedItemColor: Colors.white,
        unselectedItemColor: Colors.white,
        selectedFontSize: 16,
        unselectedFontSize: 16,
        selectedLabelStyle:
            const TextStyle(fontFamily: 'Roboto', fontWeight: FontWeight.bold),
        type: BottomNavigationBarType.fixed,
        currentIndex: currentIndex,
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.home,
                size: 40,
                color: currentIndex == 0 ? Colors.white : Colors.white54),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.show_chart,
                size: 40,
                color: currentIndex == 1 ? Colors.white : Colors.white54),
            label: 'Data',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.settings,
                size: 40,
                color: currentIndex == 2 ? Colors.white : Colors.white54),
            label: 'Settings',
          ),
        ],
        onTap: (index) {
          switch (index) {
            case 0:
              context.go('/');
              break;
            case 1:
              context.go('/data');
              break;
            case 2:
              context.go('/settings');
              break;
          }
        },
      ),
    );
  }
}
