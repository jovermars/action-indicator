import 'package:action_indicators/action_indicators.dart';
import 'package:action_indicators/indicator_insets.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  bool _enabled = true;

  void _toggle() {
    setState(() {
      _enabled = !_enabled;
    });
  }

  @override
  Widget build(BuildContext context) {
    Color containerColor = Theme.of(context).primaryColorLight;
    Color arrowColor = Theme.of(context).primaryColorDark;

    return Scaffold(
      body: Center(
        child: ActionIndicators(
          color: arrowColor,
          enabled: _enabled,
          indicators: IndicatorInsets.all(),
          child: Container(color: containerColor, width: 200, height: 300),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _toggle,
        child: Text(!_enabled ? "On" : "Off"),
      ),
    );
  }
}
