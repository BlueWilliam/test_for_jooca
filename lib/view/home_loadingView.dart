import 'package:flutter/material.dart';


class LoadingView extends StatelessWidget {
  const LoadingView({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        color: const Color.fromRGBO(0, 0, 0, 0.6),
        child: const Center(
            child: SizedBox(
                height: 60.0,
                width: 60.0,
                child: CircularProgressIndicator(
                    valueColor: AlwaysStoppedAnimation(Colors.blue),
                    strokeWidth: 5.0)
            )
        )
    );
  }
}
