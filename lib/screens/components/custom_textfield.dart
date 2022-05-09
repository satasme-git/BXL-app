import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class CustomTextField extends StatefulWidget {
  const CustomTextField({
    Key? key,
    required this.size,
    required this.text,
    required this.hintest,
    required this.suffix,
    this.icon,
  }) : super(key: key);

  final Size size;
  final String text;
  final String hintest;
  final bool suffix;
  final Widget? icon;

  @override
  State<CustomTextField> createState() => _CustomTextFieldState();
}

class _CustomTextFieldState extends State<CustomTextField> {
  var _isObscure = true;
  @override
  Widget build(BuildContext context) {
    return Container(
      width: widget.size.width,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Row(
        children: [
          Container(
            decoration: const BoxDecoration(
              border: Border(
                  right: BorderSide(
                //                   <--- left side
                color: Colors.grey,
                width: 0.5,
              )),
            ),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 3),
              child: widget.icon,
            ),
          ),
          Container(
            width: widget.size.width / 1.4,
            child: Padding(
              padding: const EdgeInsets.only(left: 10.0),
              child: widget.suffix == true
                  ? TextFormField(
                      // cursorColor: Theme.of(context).cursorColor,

                      obscureText: _isObscure,
                      decoration: InputDecoration(
                        // icon: Icon(Icons.email),
                        hintText: widget.hintest,
                        labelText: widget.text,
                        labelStyle: GoogleFonts.poppins(
                                color: Colors.black,
                                fontSize: 14
                              ),
                        suffixIcon: IconButton(
                          padding: EdgeInsets.only(left: 15),
                          onPressed: () {
                            setState(() {
                              _isObscure = !_isObscure;
                            });
                          },
                          icon: Icon(_isObscure
                              ? Icons.visibility
                              : Icons.visibility_off),
                        ),
                        enabledBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color: Color(0xFFFFFF)),
                        ),
                      ),
                    )
                  : TextFormField(
                      // cursorColor: Theme.of(context).cursorColor,
                      decoration: InputDecoration(
                        // icon: Icon(Icons.email),
                        hintText: widget.hintest,
                        labelText: widget.text,
                        labelStyle: GoogleFonts.poppins(
                                color: Colors.black,
                                 fontSize: 14
                              ),

                        enabledBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color: Color(0xFFFFFF)),
                        ),
                      ),
                    ),
            ),
          ),
        ],
      ),
    );
  }
}
