import 'package:flutter/material.dart';

class AppShadows {
  const AppShadows._();

  static const List<BoxShadow> lightLow = <BoxShadow>[
    BoxShadow(color: Color(0x14171A2B), blurRadius: 16, offset: Offset(0, 4)),
  ];

  static const List<BoxShadow> lightMedium = <BoxShadow>[
    BoxShadow(color: Color(0x1A171A2B), blurRadius: 28, offset: Offset(0, 10)),
  ];

  static const List<BoxShadow> darkLow = <BoxShadow>[
    BoxShadow(color: Color(0x66000000), blurRadius: 18, offset: Offset(0, 6)),
  ];

  static const List<BoxShadow> darkMedium = <BoxShadow>[
    BoxShadow(color: Color(0x80000000), blurRadius: 30, offset: Offset(0, 12)),
  ];
}
