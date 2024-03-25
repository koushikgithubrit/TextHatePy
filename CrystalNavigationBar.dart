import 'package:flutter/material.dart';

class CrystalNavigationBar extends StatelessWidget {
  final List<CrystalNavigationBarItem> items;
  final int currentIndex;
  final Function(int) onTap;

  const CrystalNavigationBar({super.key,
    required this.items,
    required this.currentIndex,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 60, // Adjust height as needed
      decoration: BoxDecoration(
        color: Colors.blueGrey, // Background color of the navigation bar
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.2),
            spreadRadius: 1,
            blurRadius: 3,
          ),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: items.map((item) {
          var index = items.indexOf(item);
          return GestureDetector(
            onTap: () => onTap(index),
            child: _buildNavItem(item, index == currentIndex),
          );
        }).toList(),
      ),
    );
  }

  Widget _buildNavItem(CrystalNavigationBarItem item, bool isSelected) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Icon(
          item.icon,
          color: isSelected ? Colors.white : Colors.grey,
        ),
        const SizedBox(height: 4),
        Text(
          item.label,
          style: TextStyle(
            color: isSelected ? Colors.white : Colors.grey,
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    );
  }
}

class CrystalNavigationBarItem {
  final IconData icon;
  final String label;

  CrystalNavigationBarItem({required this.icon, required this.label});
}
