import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';

class CustomListTile extends StatelessWidget {
  const CustomListTile({
    required this.text,
    required this.iconleading,
    required this.onTap,
    Key? key,
  }) : super(key: key);

  final String text;
  final IconData iconleading;
  final Function() onTap;
  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        splashColor: Colors.white24,
        onTap: onTap,
        child: ListTile(
          dense: true,
          leading: Icon(iconleading,color: Colors.white54,),
          title: Text(text,style: TextStyle(color: Colors.white,)),
          
          trailing: Icon(MaterialCommunityIcons.chevron_right,color: Colors.white60,),
        ),
      ),
    );
  }
}
