import 'package:flutter/cupertino.dart';

abstract class StatelessListWidget<ITEM> extends StatelessWidget {

  @protected
  final double leftPadding = 8;
  @protected
  final double topPadding = 8;
  @protected
  final double rightPadding = 8;
  @protected
  final double bottomPadding = 8;

  @protected
  final List<ITEM> items;

  const StatelessListWidget(this.items, {Key? key}) : super(key: key);

  Widget build(BuildContext context) {
    return getList();
  }

  @protected
  Widget getList() {
    return ListView.separated(
        separatorBuilder: (context, index) => buildSeparator(context, index),
        padding: EdgeInsets.only(left: leftPadding, top: topPadding, right: rightPadding, bottom: bottomPadding),
        itemCount: items.length,
        itemBuilder: (_, index) => _itemBuilder(items, index)
    );
  }

  Widget _itemBuilder(List<ITEM> items, int index) {
    return getItemViewHolder(items[index], index, items.length);
  }

  @protected
  Widget getItemViewHolder(ITEM item, int index, int length);

  @protected
  StatelessWidget buildSeparator(context, index) => Container();

}