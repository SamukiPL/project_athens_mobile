import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ProgressViewHolder extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      widthFactor: 10,
      heightFactor: 10,
      child: CircularProgressIndicator(),
    );
  }
}
