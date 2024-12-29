import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'container_config.dart'; // імпортуємо наш клас конфігурації

void main() {
  runApp(
    ChangeNotifierProvider(
      create: (_) => ContainerConfig(),
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Container Configurator',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const FirstScreen(),
    );
  }
}

class FirstScreen extends StatelessWidget {
  const FirstScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Container Configurator'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const SizedBox(height: 20),
            // Секція для слайдерів
            const ContainerConfigSection(),
            const SizedBox(height: 20),
            // Червоний контейнер
            Consumer<ContainerConfig>(
              builder: (context, config, child) {
                return Container(
                  width: config.width,
                  height: config.height,
                  decoration: BoxDecoration(
                    color: Colors.red,
                    borderRadius: BorderRadius.only(
                      topRight: Radius.circular(config.borderRadius),
                    ),
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}

class ContainerConfigSection extends StatelessWidget {
  const ContainerConfigSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<ContainerConfig>(
      builder: (context, config, child) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text('Width'),
            Slider(
              value: config.width,
              min: 50.0,
              max: 400.0,
              onChanged: (value) {
                config.updateWidth(value);
              },
            ),
            Text('Height: ${config.height.round()}'),
            Slider(
              value: config.height,
              min: 50.0,
              max: 400.0,
              onChanged: (value) {
                config.updateHeight(value);
              },
            ),
            Text('Border Radius: ${config.borderRadius.round()}'),
            Slider(
              value: config.borderRadius,
              min: 0.0,
              max: 100.0,
              onChanged: (value) {
                config.updateBorderRadius(value);
              },
            ),
          ],
        );
      },
    );
  }
}
