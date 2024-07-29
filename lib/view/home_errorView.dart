import 'package:flutter/material.dart';

import '../utilities.dart';


class ErrorView extends StatelessWidget {
  const ErrorView({super.key, this.errorResponse});

  final Object? errorResponse;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: widthFactor * 15),
        child: Text('Error: $errorResponse'),
      ),
    );
  }
}