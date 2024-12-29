import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Corner Radius Configurator',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const CornerRadiusConfigurator(),
    );
  }
}

class CornerRadiusConfigurator extends StatefulWidget {
  const CornerRadiusConfigurator({super.key});

  @override
  _CornerRadiusConfiguratorState createState() =>
      _CornerRadiusConfiguratorState();
}

class _CornerRadiusConfiguratorState extends State<CornerRadiusConfigurator> {
  double _topLeft = 0.0;
  double _topRight = 0.0;
  double _bottomLeft = 0.0;
  double _bottomRight = 0.0;

  void _updateRadius(String corner, double value) {
    setState(() {
      switch (corner) {
        case 'topLeft':
          _topLeft = value;
          break;
        case 'topRight':
          _topRight = value;
          break;
        case 'bottomLeft':
          _bottomLeft = value;
          break;
        case 'bottomRight':
          _bottomRight = value;
          break;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Corner Radius Configurator'),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Container(
              width: 150,
              height: 150,
              decoration: BoxDecoration(
                color: Colors.blue,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(_topLeft),
                  topRight: Radius.circular(_topRight),
                  bottomLeft: Radius.circular(_bottomLeft),
                  bottomRight: Radius.circular(_bottomRight),
                ),
              ),
            ),
            const SizedBox(height: 20),
            _buildSlider('Top Left', _topLeft, (value) {
              _updateRadius('topLeft', value);
            }),
            _buildSlider('Top Right', _topRight, (value) {
              _updateRadius('topRight', value);
            }),
            _buildSlider('Bottom Left', _bottomLeft, (value) {
              _updateRadius('bottomLeft', value);
            }),
            _buildSlider('Bottom Right', _bottomRight, (value) {
              _updateRadius('bottomRight', value);
            }),
          ],
        ),
      ),
    );
  }

  Widget _buildSlider(String label, double value, ValueChanged<double> onChanged) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          '$label: ${value.toStringAsFixed(1)}',
          style: const TextStyle(fontSize: 16),
        ),
        Slider(
          value: value,
          min: 0,
          max: 75,
          divisions: 15,
          label: value.toStringAsFixed(1),
          onChanged: onChanged,
        ),
        const SizedBox(height: 10),
      ],
    );
  }
}
