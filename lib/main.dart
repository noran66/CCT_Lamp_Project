
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

void main() {
  runApp(const CCTLampApp());
}

class CCTLampApp extends StatelessWidget {
  const CCTLampApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'CCT Lamp Control',
      theme: ThemeData(
        brightness: Brightness.dark,
        primaryColor: Colors.amber,
        scaffoldBackgroundColor: const Color(0xFF1A1A1A),
        textTheme: GoogleFonts.latoTextTheme(
          ThemeData.dark().textTheme,
        ),
      ),
      home: const CCTLampHomePage(),
    );
  }
}

class CCTLampHomePage extends StatefulWidget {
  const CCTLampHomePage({super.key});

  @override
  _CCTLampHomePageState createState() => _CCTLampHomePageState();
}

class _CCTLampHomePageState extends State<CCTLampHomePage> {
  final ValueNotifier<bool> _isLampOn = ValueNotifier<bool>(true);
  final ValueNotifier<double> _brightness = ValueNotifier<double>(0.8);
  final ValueNotifier<double> _colorTemperature = ValueNotifier<double>(4500);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'CCT Lamp Control',
          style: GoogleFonts.lato(
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            ValueListenableBuilder<bool>(
              valueListenable: _isLampOn,
              builder: (context, isLampOn, child) {
                return ValueListenableBuilder<double>(
                  valueListenable: _brightness,
                  builder: (context, brightness, child) {
                    return ValueListenableBuilder<double>(
                      valueListenable: _colorTemperature,
                      builder: (context, colorTemperature, child) {
                        return Container(
                          width: 250,
                          height: 250,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: isLampOn
                                ? Color.lerp(
                                    const Color(0xFFFFDDBB),
                                    const Color(0xFFEBF4FF),
                                    (colorTemperature - 2700) / (6500 - 2700),
                                  )!.withOpacity(brightness)
                                : Colors.grey.shade800,
                            boxShadow: [
                              if (isLampOn)
                                BoxShadow(
                                  color: Color.lerp(
                                    const Color(0xFFFFDDBB),
                                    const Color(0xFFEBF4FF),
                                    (colorTemperature - 2700) / (6500 - 2700),
                                  )!.withOpacity(0.7),
                                  blurRadius: 40,
                                  spreadRadius: 15,
                                ),
                            ],
                          ),
                        );
                      },
                    );
                  },
                );
              },
            ),
            Column(
              children: [
                _buildSlider(
                  label: 'Brightness',
                  valueListenable: _brightness,
                  min: 0.0,
                  max: 1.0,
                  onChanged: (value) => _brightness.value = value,
                  valueFormatter: (value) => '${(value * 100).round()}%',
                ),
                const SizedBox(height: 20),
                _buildSlider(
                  label: 'Color Temperature',
                  valueListenable: _colorTemperature,
                  min: 2700,
                  max: 6500,
                  onChanged: (value) => _colorTemperature.value = value,
                  valueFormatter: (value) => '${value.round()}K',
                ),
              ],
            ),
            ValueListenableBuilder<bool>(
              valueListenable: _isLampOn,
              builder: (context, isLampOn, child) {
                return SwitchListTile(
                  title: Text(
                    'Power',
                    style: GoogleFonts.lato(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  value: isLampOn,
                  onChanged: (value) => _isLampOn.value = value,
                  secondary: Icon(
                    isLampOn ? Icons.lightbulb : Icons.lightbulb_outline,
                    size: 32,
                  ),
                  activeColor: Colors.amber,
                  tileColor: Colors.black.withOpacity(0.2),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSlider({
    required String label,
    required ValueNotifier<double> valueListenable,
    required double min,
    required double max,
    required ValueChanged<double> onChanged,
    required String Function(double) valueFormatter,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              label,
              style: GoogleFonts.lato(fontSize: 18),
            ),
            ValueListenableBuilder<double>(
              valueListenable: valueListenable,
              builder: (context, value, child) {
                return Text(
                  valueFormatter(value),
                  style: GoogleFonts.lato(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                );
              },
            ),
          ],
        ),
        ValueListenableBuilder<double>(
          valueListenable: valueListenable,
          builder: (context, value, child) {
            return Slider(
              value: value,
              min: min,
              max: max,
              onChanged: onChanged,
              activeColor: Colors.amber,
              inactiveColor: Colors.grey.shade700,
            );
          },
        ),
      ],
    );
  }
}
