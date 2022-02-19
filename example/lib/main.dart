import 'package:action_indicators/actions_indicator.dart';
import 'package:action_indicators/single_indicator.dart';
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
  bool _indicators = false;

  void _toggle() {
    setState(() {
      _indicators = !_indicators;
    });
  }

  @override
  Widget build(BuildContext context) {
    Color containerColor = Theme.of(context).primaryColorLight;
    Color arrowColor = Theme.of(context).primaryColorDark;

    return Scaffold(
      body: Center(
          child: _indicators
              ? ActionsIndicator(
                  color: arrowColor,
                  indicators: IndicatorInsets(
                    top: Indicator(color: Colors.blue),
                    left: Indicator(color: Colors.purple),
                    bottom: Indicator(color: Colors.lightGreen),
                    right: Indicator(color: Colors.pink),
                    topLeft: Indicator(color: Colors.orange),
                    topRight: Indicator(color: Colors.teal),
                    bottomLeft: Indicator(color: Colors.amber),
                    bottomRight: Indicator(color: Colors.red),
                  ),
                  child: Container(
                    color: containerColor,
                    width: 200,
                    height: 300,
                  ))
              : SingleIndicator(
                  indicator: IndicatorInsets(
                      bottom: Indicator(color: Colors.blueAccent)),
                  color: arrowColor)),
      floatingActionButton: FloatingActionButton(
        onPressed: _toggle,
        child: const Text("🕹", style: TextStyle(fontSize: 32)),
      ),
    );
  }
}
