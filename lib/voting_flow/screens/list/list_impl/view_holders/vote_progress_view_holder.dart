import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class VoteProgressViewHolder extends StatelessWidget {
  @override
  Widget build(BuildContext context) => Container(
    height: 75,
    child: Center(
      widthFactor: 10,
      heightFactor: 10,
      child: CircularProgressIndicator(),
    ),
  );

}