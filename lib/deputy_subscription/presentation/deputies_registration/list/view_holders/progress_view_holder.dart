import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ProgressViewHolder extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      widthFactor: 25,
      heightFactor: 25,
      child: CircularProgressIndicator(),
    );
  }
}
