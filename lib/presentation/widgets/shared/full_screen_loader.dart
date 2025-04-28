import 'package:flutter/material.dart';

class FullScreenLoader extends StatelessWidget {
  const FullScreenLoader({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
        child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
                const Text('Espere por favor'),
                const SizedBox(height: 10,),
                const CircularProgressIndicator(strokeWidth: 2),
                const SizedBox(height: 10,),
            ],
        ),
    );
  }
}