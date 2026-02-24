import 'package:flutter/material.dart';
import 'package:fluent_ui/fluent_ui.dart' as fluent;
import '../models/stock.dart';
import '../models/market_index.dart';

class MarketOverview extends StatelessWidget {
  final List<MarketIndex> indices;
  final double sentiment;
  final List<Stock> stocks;

  const MarketOverview({
    super.key,
    required this.indices,
    required this.sentiment,
    required this.stocks,
  });

  @override
  Widget build(BuildContext context) {
    final upCount = stocks.where((s) => s.dayChangePercent > 0).length;
    final downCount = stocks.where((s) => s.dayChangePercent < 0).length;
    final limitUpCount = stocks.where((s) => s.isLimitUp).length;
    final limitDownCount = stocks.where((s) => s.isLimitDown).length;

    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text('大盘指数', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
          const SizedBox(height: 12),
          Wrap(
            spacing: 16,
            runSpacing: 16,
            children: indices.map((index) => _indexCard(index)).toList(),
          ),
          
          const SizedBox(height: 24),
          
          const Text('市场情绪', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
          const SizedBox(height: 12),
          fluent.Card(
            padding: const EdgeInsets.all(16),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text('恐慌'),
                    Text(
                      sentiment >= 0 ? '贪婪' : '恐慌',
                      style: TextStyle(
                        color: sentiment >= 0 ? Colors.green : Colors.red,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const Text('贪婪'),
                  ],
                ),
                const SizedBox(height: 8),
                LinearProgressIndicator(
                  value: (sentiment + 100) / 200,
                  backgroundColor: Colors.grey.withOpacity(0.2),
                ),
                const SizedBox(height: 8),
                Text('情绪指数: ${sentiment.toStringAsFixed(1)}'),
              ],
            ),
          ),
          
          const SizedBox(height: 24),
          
          const Text('市场统计', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
          const SizedBox(height: 12),
          Row(
            children: [
              Expanded(
                child: fluent.Card(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    children: [
                      Text('$upCount', style: const TextStyle(fontSize: 32, color: Colors.red)),
                      const Text('上涨'),
                    ],
                  ),
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: fluent.Card(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    children: [
                      Text('$downCount', style: const TextStyle(fontSize: 32, color: Colors.green)),
                      const Text('下跌'),
                    ],
                  ),
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: fluent.Card(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    children: [
                      Text('$limitUpCount', style: const TextStyle(fontSize: 32, color: Colors.red)),
                      const Text('涨停'),
                    ],
                  ),
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: fluent.Card(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    children: [
                      Text('$limitDownCount', style: const TextStyle(fontSize: 32, color: Colors.green)),
                      const Text('跌停'),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _indexCard(MarketIndex index) {
    final isUp = index.dayChangePercent >= 0;
    final color = isUp ? Colors.red : Colors.green;

    return fluent.Card(
      padding: const EdgeInsets.all(16),
      child: SizedBox(
        width: 200,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(index.name, style: const TextStyle(fontWeight: FontWeight.bold)),
            const SizedBox(height: 8),
            Text(
              index.currentValue.toStringAsFixed(2),
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: color),
            ),
            Row(
              children: [
                Text(
                  '${isUp ? '+' : ''}${index.dayChange.toStringAsFixed(2)}',
                  style: TextStyle(color: color),
                ),
                const SizedBox(width: 8),
                Text(
                  '${isUp ? '+' : ''}${index.dayChangePercent.toStringAsFixed(2)}%',
                  style: TextStyle(color: color),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
