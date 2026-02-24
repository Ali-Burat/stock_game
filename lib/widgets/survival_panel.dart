import 'package:flutter/material.dart';
import 'package:fluent_ui/fluent_ui.dart' as fluent;
import '../models/survival.dart';

class SurvivalPanel extends StatelessWidget {
  final SurvivalStatus survival;

  const SurvivalPanel({super.key, required this.survival});

  @override
  Widget build(BuildContext context) {
    return fluent.Card(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text('生存状态', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
          const SizedBox(height: 12),
          _statusBar('🍖 饥饿', survival.hunger),
          const SizedBox(height: 8),
          _statusBar('💧 口渴', survival.thirst),
          const SizedBox(height: 8),
          _statusBar('❤️ 健康', survival.health),
          const SizedBox(height: 8),
          _statusBar('😊 心情', survival.mood),
        ],
      ),
    );
  }

  Widget _statusBar(String label, double value) {
    Color color;
    if (value >= 70) {
      color = Colors.green;
    } else if (value >= 40) {
      color = Colors.orange;
    } else {
      color = Colors.red;
    }

    return Row(
      children: [
        SizedBox(width: 80, child: Text(label)),
        Expanded(
          child: LinearProgressIndicator(
            value: value / 100,
            backgroundColor: Colors.grey.withOpacity(0.2),
            valueColor: AlwaysStoppedAnimation<Color>(color),
          ),
        ),
        const SizedBox(width: 8),
        SizedBox(width: 40, child: Text('${value.toStringAsFixed(0)}%')),
      ],
    );
  }
}
