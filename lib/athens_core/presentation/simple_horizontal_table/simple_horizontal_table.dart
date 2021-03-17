import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:project_athens/athens_core/presentation/simple_horizontal_table/simple_horizontal_table_cell.dart';

class SimpleHorizontalTable extends StatelessWidget {
  final List<SimpleHorizontalTableCell> cells;
  final Border border;


  SimpleHorizontalTable({@required this.cells, this.border});

  Widget buildCell(IconData icon, String upperText, String lowerText,
      ThemeData theme, Border border) {
    return Expanded(
      child: Container(
        padding: EdgeInsets.only(top: 8, bottom: 8),
        decoration: BoxDecoration(border: border != null ? border : Border()),
        child: Column(
          children: [
            icon != null
                ? Icon(
              icon,
              color: theme.dividerColor,
              size: 30,
            )
                : Text(
              upperText,
              style: TextStyle(
                  color: theme.dividerColor,
                  fontSize: 15,
                  fontWeight: FontWeight.w300),
              textAlign: TextAlign.center,
            ),
            Text(
              lowerText,
              style: TextStyle(
                  color: Colors.black,
                  fontSize: 19,
                  fontWeight: FontWeight.w300),
              textAlign: TextAlign.center,
            )
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    final currBorder = this.border != null ? this.border : Border(
        right: BorderSide(
            color: theme.dividerColor.withOpacity(0.4), width: 1)
    );

    int mapIdx = 0;

    return Container(
      padding: EdgeInsets.only(top: 8),
      child: Row(
        children: cells.map((e) {
          final isLast = mapIdx == cells.length - 1;
          return buildCell(e.icon, e.upperText, e.lowerText, theme,
              isLast ? Border(right: BorderSide(width: 0)) : currBorder);
        }).toList(),
      ),
    );
  }
}
