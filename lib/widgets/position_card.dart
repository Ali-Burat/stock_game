import 'package:flutter/material.dart';
import 'package:fluent_ui/fluent_ui.dart' as fluent;
import '../models/player.dart';

class PositionCard extends StatelessWidget {
  final Position position;

  const PositionCard({super.key, required this.position});

  @override
  Widget build(BuildContext context) {
    final isProfit = position.profit >= 0;
    final color = isProfit ? fluent.Colors.red : fluent.Colors.green;

    return fluent.Card(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                position.stockName,
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                decoration: BoxDecoration(
                  color: color.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(4),
                ),
                child: Text(
                  '${isProfit ? '+' : ''}${position.profitPercent.toStringAsFixed(2)}%',
                  style: TextStyle(color: color),
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('持仓: ${position.shares}股'),
                  Text('成本: ¥${position.averageCost.toStringAsFixed(2)}'),
                ],
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text('现价: ¥${position.currentPrice.toStringAsFixed(2)}'),
                  Text(
                    '${isProfit ? '盈利' : '亏损'}: ¥${position.profit.abs().toStringAsFixed(2)}',
                    style: TextStyle(color: color),
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}
