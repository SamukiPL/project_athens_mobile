import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:project_athens/athens_core/navigation/bottom_navigation_bloc.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:project_athens/main/presentation/main_widget.dart';
import 'package:provider/provider.dart';

class BottomNavigationWidget extends StatelessWidget {

  final BottomNavItem currentItem;

  const BottomNavigationWidget({Key key, @required this.currentItem}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Hero(
      tag: "BottomBarTest",
      child: Consumer<BottomNavigationBloc>(
        builder: (context, bloc, _) => BottomNavigationBar(
          type: BottomNavigationBarType.fixed,
          currentIndex: currentItem.index,
          onTap: (item) {
            bloc.pickItem(item);
            refreshMainWidget(context);
          },
          items: [
            BottomNavigationBarItem(
                icon: Icon(Icons.timeline),
                label: "Wydarzenia"
            ),
            BottomNavigationBarItem(
                icon: Icon(Icons.person),
                label: "Posłowie"
            ),
            BottomNavigationBarItem(
                icon: Icon(Icons.record_voice_over),
                label: "Przemowy"
            ),
            BottomNavigationBarItem(
                icon: Icon(MdiIcons.vote),
                label: "Głosowania"
            ),
            BottomNavigationBarItem(
                icon: Icon(Icons.settings),
                label: "Ustawienia"
            ),
          ],
        ),
      ),
    );
  }

  void refreshMainWidget(BuildContext context) {
    Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(
        builder: (context) => MainWidget()
      ),
      (Route<dynamic> route) => false
    );
  }

}