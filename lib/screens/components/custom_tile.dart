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
          visualDensity: const VisualDensity(vertical: -4),
          // style: ,
          dense: true,
          leading: Icon(
            iconleading,
            color: Colors.grey[500],
          ),
          title: Text(text,
              style: const TextStyle(
                color: Colors.black87,
              )),

          trailing: Icon(
            MaterialCommunityIcons.chevron_right,
            color: Colors.grey[400],
          ),
        ),
      ),
    );
  }
}
