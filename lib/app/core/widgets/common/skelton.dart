import 'package:flutter/material.dart';
import 'package:loading_skeleton_niu/loading_skeleton.dart';

class skelton extends StatelessWidget{
  double width, height;
  skelton({required this.height, required this.width});
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 5),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(15),
        child: LoadingSkeleton(
          width: width,
          height: height,
        ),
      ),
    );
  }
}