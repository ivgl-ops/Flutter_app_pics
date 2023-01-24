import 'package:flutter/material.dart';

import 'package:flutter_spinkit/flutter_spinkit.dart';

//Кастомный индикатор
class LoadingIndicator extends StatefulWidget {
  const LoadingIndicator({super.key, required this.size});

  final double size;

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
