import 'package:flutter/material.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import 'package:google_fonts/google_fonts.dart';

class ConnectionScreen extends StatefulWidget {
  const ConnectionScreen({Key? key}) : super(key: key);

  @override
  _ConnectionScreenState createState() => _ConnectionScreenState();
}

class _ConnectionScreenState extends State<ConnectionScreen> {
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: const Color(0xFFECF3F9),
      // appBar: AppBar(
      //   backgroundColor: const Color(0xFFECF3F9),
      //   elevation: 0,
      //   centerTitle: true,
       
      //   leading: IconButton(
      //     onPressed: () {
      //       Navigator.pop(context);
      //     },
      //     icon: const Icon(
      //       MaterialCommunityIcons.chevron_left,
      //       size: 30,
      //     ),
      //     color: Colors.black,
      //   ),
      // ),
      body: SizedBox(
        width: size.width,
        height: size.height,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children:  [
            const Icon(
              MaterialCommunityIcons.wifi_off,
              color: Colors.grey,
              size: 90,
              semanticLabel: "wifi",
            ),
            const SizedBox(
              height: 10,
            ),
            Text(
              "Ooops!",
              style: GoogleFonts.poppins(fontSize: 20,color: Colors.blue),
            ),
            Text(
              "Slow or no onternet connection",
              style: GoogleFonts.poppins(fontSize: 12),
            ),
            Text(
              "please check your internet setting.",
              style: GoogleFonts.poppins(fontSize: 12),
            ),
          ],
        ),
      ),
    );
  }
}
