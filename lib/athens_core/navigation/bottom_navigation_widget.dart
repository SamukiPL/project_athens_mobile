import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:project_athens/athens_core/navigation/bottom_navigation_bloc.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:provider/provider.dart';

class BottomNavigationWidget extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Consumer<BottomNavigationBloc>(
      builder: (context, bloc, _) => BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        currentIndex: bloc.currentItem.index,
        onTap: bloc.pickItem,
        items: [
          BottomNavigationBarItem(
              icon: Icon(Icons.timeline),
              title: Text("Wydarzenia")
          ),
          BottomNavigationBarItem(
              icon: Icon(Icons.person),
              title: Text("Posłowie")
          ),
          BottomNavigationBarItem(
              icon: Icon(Icons.search),
              title: Text("Szukaj")
          ),
          BottomNavigationBarItem(
              icon: Icon(MdiIcons.vote),
              title: Text("Głosowania")
          ),
          BottomNavigationBarItem(
              icon: Icon(Icons.settings),
              title: Text("Ustawienia")
          ),
        ],
      ),
    );
  }

}