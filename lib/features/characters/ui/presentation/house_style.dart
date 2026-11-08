import 'package:flutter/material.dart';

const kBackground = Color(0xFF0E0E14);
const kSurface = Color(0xFF181822);
const kGold = Color(0xFFD4AF37);

Color houseColor(String house) {
  switch (house) {
    case 'Gryffindor':
      return const Color(0xFFAE0001);
    case 'Slytherin':
      return const Color(0xFF2A623D);
    case 'Ravenclaw':
      return const Color(0xFF2B4BA0);
    case 'Hufflepuff':
      return const Color(0xFFE0A91B);
    default:
      return const Color(0xFF555566);
  }
}

IconData houseIcon(String house) {
  switch (house) {
    case 'Gryffindor':
      return Icons.local_fire_department;
    case 'Slytherin':
      return Icons.water_drop;
    case 'Ravenclaw':
      return Icons.air;
    case 'Hufflepuff':
      return Icons.eco;
    default:
      return Icons.auto_awesome;
  }
}