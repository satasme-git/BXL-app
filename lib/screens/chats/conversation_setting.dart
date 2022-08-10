import 'package:binary_app/provider/chat_provider.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../utils/util_functions.dart';

class ConversationSettings extends StatefulWidget {
  const ConversationSettings({Key? key}) : super(key: key);

  @override
  State<ConversationSettings> createState() => _ConversationSettingsState();
}

class _ConversationSettingsState extends State<ConversationSettings> {
  var top = 0.0;
  late ScrollController _scrolController;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _scrolController = ScrollController();
    _scrolController.addListener(() {
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      body: Stack(
        children: [
          CustomScrollView(
            controller: _scrolController,
            slivers: [
              SliverAppBar(
                backgroundColor: HexColor("#283890"),
                pinned: true,
                leading: AnimatedOpacity(
                  opacity: top <= 130 ? 0.0 : 1.0,
                  child: IconButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    icon: Icon(Icons.arrow_back_ios, color: Colors.black),
                    color: Colors.black,
                  ),
                  duration: Duration(milliseconds: 300),
                ),
                expandedHeight: 250,
                flexibleSpace: Consumer<ChatProvider>(
                  builder: (context, value, child) {
                    return LayoutBuilder(
                      builder: (context, constraints) {
                        top = constraints.biggest.height;
                        return FlexibleSpaceBar(
                          centerTitle: true,
                          title: AnimatedOpacity(
                            opacity: top <= 130 ? 1.0 : 0.0,
                            duration: Duration(milliseconds: 300),
                            child: Row(
                              children: [
                                SizedBox(
                                  width: 12,
                                ),
                                CircleAvatar(
                                  minRadius: 10,
                                  maxRadius: 18,
                                  backgroundImage: NetworkImage(
                                    value.conv.image,
                                    // "https://images.pexels.com/photos/220453/pexels-photo-220453.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=1",
                                  ),
                                ),
                                SizedBox(
                                  width: 12,
                                ),
                                Text("Guest"),
                              ],
                            ),
                          ),
                          background: Hero(
                            tag: "profgroup",
                            child: Image.network(
                              value.conv.image,
                              // "https://images.pexels.com/photos/220453/pexels-photo-220453.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=1",
                              fit: BoxFit.cover,
                            ),
                          ),
                        );
                      },
                    );
                  },
                ),
              ),
              SliverToBoxAdapter(child: Consumer<ChatProvider>(
                builder: (context, value, child) {
                  return SizedBox(
                    height: size.height,
                    child: Column(
                      children: [
                        Card(
                          child: SingleChildScrollView(
                            child: Container(
                              padding: EdgeInsets.all(15),
                              width: size.width,
                              height: size.height / 6,
                              color: Colors.white,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text("info"),
                                  SizedBox(
                                    height: 10,
                                  ),
                                  value.conv.description != ""
                                      ? Text(value.conv.description)
                                      : Text(""),
                                ],
                              ),
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Card(
                          // color: Colors.red,
                          child: ListView.builder(
                            padding: EdgeInsets.all(0),
                            primary: false,
                            shrinkWrap: true,
                            itemCount: value.conv.userArray.length,
                            itemBuilder: (BuildContext context, index) =>
                                ListTile(
                              leading: value.conv.userArray[index].image ==
                                      "null"
                                  ? ClipRRect(
                                      borderRadius: BorderRadius.circular(45),
                                      child: Image.asset(
                                        "assets/avatar.jpg",
                                        height: 45,
                                        width: 45,
                                        fit: BoxFit.fill,
                                      ),
                                    )
                                  : ClipRRect(
                                      borderRadius: BorderRadius.circular(45),
                                      child: Image.network(
                                        value.conv.userArray[index].image,
                                        height: 45,
                                        width: 45,
                                        fit: BoxFit.fill,
                                      ),
                                    ),
                              title: Text(value.conv.userArray[index].fname
                                      .toString() +
                                  " " +
                                  value.conv.userArray[index].lname.toString()),
                              subtitle: Text(
                                  value.conv.userArray[index].email.toString()),
                              trailing: Wrap(
                                spacing: 12, // space between two icons
                                children: value.conv.userArray[index].roleid ==
                                        "2"
                                    ? <Widget>[
                                        GestureDetector(
                                          onTap: () {
                                            launch(
                                                "tel://${value.conv.userArray[index].phone}");
                                          },
                                          child: Icon(
                                            Icons.call,
                                            color: Color.fromARGB(
                                                255, 12, 156, 17),
                                          ),
                                        ), // icon-1

                                        Container(
                                          decoration: BoxDecoration(
                                            border:
                                                Border.all(color: Colors.green),
                                            borderRadius:
                                                BorderRadius.circular(10),
                                          ),
                                          child: Padding(
                                            padding: EdgeInsets.symmetric(
                                                horizontal: 5, vertical: 2),
                                            child: Text(
                                              'Admin',
                                              style: GoogleFonts.poppins(
                                                fontSize: 10,
                                                color: Colors.green[900],
                                              ),
                                            ),
                                          ),
                                        ), // icon-2
                                      ]
                                    : <Widget>[],
                              ),
                              // value.conv.userArray[index].roleid ==
                              //         "2"
                              //     ? Icon(
                              //         Icons.phone,
                              //         color: Color.fromARGB(255, 44, 202, 126),
                              //       )
                              //     : Text(">"),
                            ),
                          ),
                        ),
                      ],
                    ),
                  );
                },
              )),
            ],
          ),
          _buildFab(),
        ],
      ),
    );
  }

  Widget _buildFab() {
    final double defaultMargin = 265;
    final double defaultStart = 220;
    final double defaultEnd = defaultStart / 2;
    double top = defaultMargin;
    double scale = 1.0;
    if (_scrolController.hasClients) {
      double offset = _scrolController.offset;
      top -= offset;
      if (offset < defaultMargin - defaultStart) {
        scale = 1.0;
      } else if (offset < defaultStart - defaultEnd) {
        scale = (defaultMargin - defaultEnd - offset) / defaultEnd;
      } else {
        scale = 0.0;
      }
    }
    return Positioned(
      top: top,
      right: 16,
      child: Transform(
        alignment: Alignment.center,
        transform: Matrix4.identity()..scale(scale),
        child: SizedBox(
          width: 40,
          height: 40,
          child: FloatingActionButton(
            onPressed: () {},
            child: const Icon(Icons.camera_alt_outlined),
            backgroundColor: Colors.blue,
            splashColor: Colors.yellow,
          ),
        ),
      ),
    );
  }
}
