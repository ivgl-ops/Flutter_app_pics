import 'package:flutter/material.dart';

import 'package:flutter_spinkit/flutter_spinkit.dart';

class LoadingIndicator extends StatefulWidget {
  final double size;
  const LoadingIndicator({super.key, required this.size});

  @override
  State<LoadingIndicator> createState() => _LoadingIndicatorState();
}

class _LoadingIndicatorState extends State<LoadingIndicator> {

  @override
  Widget build(BuildContext context) {
    return SpinKitSpinningLines(
      color: Colors.black,
      size: widget.size,
    );
  }
}
