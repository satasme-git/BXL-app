import 'package:binary_app/provider/chat_provider.dart';
import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:provider/provider.dart';

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
    return Scaffold(
      body: Stack(
        children: [
          CustomScrollView(
            controller: _scrolController,
            slivers: [
              SliverAppBar(
                backgroundColor:   HexColor("#283890"),
                pinned: true,
                leading: AnimatedOpacity(
                  opacity: top <= 130 ? 0.0 : 1.0,
                  child: IconButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    icon: Icon(Icons.arrow_back_ios, color: Colors.white),
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
                              children:  [
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
              SliverToBoxAdapter(
                child: ListView.builder(
                  primary: false,
                  shrinkWrap: true,
                  itemCount: 10,
                  itemBuilder: (ctx, i) => Card(
                    child: ListTile(
                      leading: Icon(Icons.edit),
                      title: Text("title"),
                      subtitle: Text("subtitle"),
                      trailing: Icon(
                        Icons.edit,
                        color: Colors.red,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
          _buildFab(),
        ],
      ),
    );
  }

  Widget _buildFab() {
    final double defaultMargin = 260;
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
          child: FloatingActionButton(onPressed: () {})),
    );
  }
}
