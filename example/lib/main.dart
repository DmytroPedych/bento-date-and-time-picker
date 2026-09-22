import 'package:bento_datetime_picker_example/demos/bento_date_picker_demo.dart';
import 'package:flutter/material.dart';

import 'theme/demo_theme.dart';

void main() {
  runApp(const DemoApp());
}

class DemoApp extends StatelessWidget {
  const DemoApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(title: 'Demos ', theme: demoTheme, home: DemoListScreen());
  }
}

class DemoListScreen extends StatelessWidget {
  DemoListScreen({super.key});

  final demos = [_DemoPage(title: 'Date picker demo', demoWidget: BentoDatePickerDemo())];

  void _navigateTo(BuildContext context, {required Widget demoWidget}) async {
    await Navigator.of(context).push(MaterialPageRoute(builder: (context) => demoWidget));
  }

  @override
  Widget build(BuildContext context) {
    final ColorScheme colorScheme = Theme.of(context).colorScheme;
    return Scaffold(
      backgroundColor: colorScheme.surface,
      appBar: AppBar(title: const Text('Demo screens')),
      body: ListView.builder(
        itemCount: demos.length,
        itemBuilder: (context, index) {
          final demoScreen = demos[index];
          return ListTile(
            title: Text(demoScreen.title),
            trailing: Icon(Icons.arrow_forward_ios_outlined, color: colorScheme.onSurface),
            onTap: () => _navigateTo(context, demoWidget: demoScreen.demoWidget),
          );
        },
      ),
    );
  }
}

class _DemoPage {
  final String title;
  final Widget demoWidget;

  const _DemoPage({required this.title, required this.demoWidget});
}
