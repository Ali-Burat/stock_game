import 'package:flutter/material.dart';
import 'package:fluent_ui/fluent_ui.dart' as fluent;
import 'package:provider/provider.dart';
import '../models/stock.dart';
import '../providers/game_provider.dart';

class StockCard extends StatefulWidget {
  final Stock stock;

  const StockCard({super.key, required this.stock});

  @override
  State<StockCard> createState() => _StockCardState();
}

class _StockCardState extends State<StockCard> {
  int _shares = 100;
  bool _showTrade = false;

  @override
  Widget build(BuildContext context) {
    final isUp = widget.stock.dayChangePercent >= 0;
    final color = isUp ? fluent.Colors.red : fluent.Colors.green;

    return fluent.Card(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Text(
                    widget.stock.name,
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(width: 8),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                    decoration: BoxDecoration(
                      color: fluent.Colors.grey.withOpacity(0.1),
                      borderRadius: BorderRadius.circular(4),
                    ),
                    child: Text(widget.stock.code),
                  ),
                ],
              ),
              Icon(
                isUp ? fluent.FluentIcons.sort_up : fluent.FluentIcons.sort_down,
                color: color,
              ),
            ],
          ),
          const SizedBox(height: 8),
          Text(
            widget.stock.industry,
            style: TextStyle(
              color: Colors.grey[600],
              fontSize: 12,
            ),
          ),
          const SizedBox(height: 12),
          Row(
            children: [
              Text(
                '¥${widget.stock.currentPrice.toStringAsFixed(2)}',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: color,
                ),
              ),
              const SizedBox(width: 16),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                decoration: BoxDecoration(
                  color: color.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(4),
                ),
                child: Text(
                  '${isUp ? '+' : ''}${widget.stock.dayChangePercent.toStringAsFixed(2)}%',
                  style: TextStyle(color: color),
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          fluent.Button(
            onPressed: () => setState(() => _showTrade = !_showTrade),
            child: const Text('交易'),
          ),
          if (_showTrade) ...[
            const SizedBox(height: 16),
            const Divider(),
            const SizedBox(height: 12),
            Row(
              children: [
                const Text('数量: '),
                fluent.Slider(
                  value: _shares.toDouble(),
                  min: 100,
                  max: 10000,
                  divisions: 99,
                  onChanged: (value) => setState(() => _shares = value.toInt()),
                ),
                Text('$_shares 股'),
              ],
            ),
            const SizedBox(height: 8),
            Text('预计金额: ¥${(widget.stock.currentPrice * _shares).toStringAsFixed(2)}'),
            const SizedBox(height: 12),
            Row(
              children: [
                Expanded(
                  child: fluent.FilledButton(
                    onPressed: () {
                      final game = context.read<GameProvider>();
                      if (game.buyStock(widget.stock, _shares)) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(content: Text('买入成功')),
                        );
                      } else {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(content: Text('余额不足')),
                        );
                      }
                    },
                    child: const Text('买入'),
                  ),
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: fluent.Button(
                    onPressed: () {
                      final game = context.read<GameProvider>();
                      if (game.sellStock(widget.stock, _shares)) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(content: Text('卖出成功')),
                        );
                      } else {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(content: Text('持仓不足')),
                        );
                      }
                    },
                    child: const Text('卖出'),
                  ),
                ),
              ],
            ),
          ],
        ],
      ),
    );
  }
}
