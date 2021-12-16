import 'package:flutter/material.dart';
import 'package:moonapp/src/views/components/others_components/status_components/loading_component.dart';

class LoadingScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: LoadingComponent(),
      ),
    );
  }
}
