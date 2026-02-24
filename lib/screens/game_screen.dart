import 'dart:async';
import 'package:flutter/material.dart';
import 'package:fluent_ui/fluent_ui.dart' as fluent;
import 'package:provider/provider.dart';
import '../providers/game_provider.dart';
import '../widgets/stock_card.dart';
import '../widgets/position_card.dart';
import '../widgets/news_card.dart';
import '../widgets/market_overview.dart';
import '../widgets/survival_panel.dart';

class GameScreen extends StatefulWidget {
  const GameScreen({super.key});

  @override
  State<GameScreen> createState() => _GameScreenState();
}

class _GameScreenState extends State<GameScreen> {
  int _selectedIndex = 0;
  Timer? _gameTimer;

  @override
  void initState() {
    super.initState();
    _startGameLoop();
  }

  void _startGameLoop() {
    _gameTimer = Timer.periodic(const Duration(seconds: 1), (_) {
      final game = context.read<GameProvider>();
      if (!game.isPaused) {
        game.updateStockPrices();
        game.advanceTime();
        game.generateNews();
        game.updateSurvival();
      }
    });
  }

  @override
  void dispose() {
    _gameTimer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return fluent.FluentApp(
      theme: fluent.FluentThemeData(accentColor: fluent.Colors.blue),
      home: fluent.NavigationView(
        appBar: fluent.NavigationAppBar(
          title: Consumer<GameProvider>(
            builder: (context, game, _) => Row(
              children: [
                const Text('📈 炒股人生'),
                const SizedBox(width: 20),
                Text('第 ${game.state.gameDay} 天'),
                const SizedBox(width: 10),
                Text('${game.state.gameTime.toString().padLeft(2, '0')}:00'),
                const SizedBox(width: 20),
                Text('💰 ¥${game.state.cash.toStringAsFixed(2)}'),
                const SizedBox(width: 10),
                Text('总资产: ¥${game.state.totalAssets.toStringAsFixed(2)}'),
                const SizedBox(width: 10),
                if (game.isPaused) Container(
                  padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                  decoration: BoxDecoration(
                    color: fluent.Colors.orange,
                    borderRadius: BorderRadius.circular(4),
                  ),
                  child: const Text('已暂停', style: TextStyle(color: Colors.white)),
                ),
              ],
            ),
          ),
          actions: Consumer<GameProvider>(
            builder: (context, game, _) => Row(
              children: [
                fluent.IconButton(
                  icon: Icon(game.isPaused ? fluent.FluentIcons.play : fluent.FluentIcons.pause),
                  onPressed: game.togglePause,
                ),
                const SizedBox(width: 8),
                ...[1, 2, 5, 10].map((speed) => Padding(
                  padding: const EdgeInsets.only(right: 4),
                  child: fluent.Button(
                    style: fluent.ButtonStyle(
                      backgroundColor: WidgetStateProperty.all(
                        game.gameSpeed == speed ? fluent.Colors.blue : null,
                      ),
                    ),
                    onPressed: () => game.setGameSpeed(speed),
                    child: Text('${speed}x', style: TextStyle(
                      color: game.gameSpeed == speed ? Colors.white : null,
                    )),
                  ),
                )),
                const SizedBox(width: 16),
              ],
            ),
          ),
        ),
        pane: fluent.NavigationPane(
          selected: _selectedIndex,
          onChanged: (i) => setState(() => _selectedIndex = i),
          displayMode: fluent.PaneDisplayMode.compact,
          items: [
            fluent.PaneItem(
              icon: const Icon(fluent.FluentIcons.stock_down),
              title: const Text('股票交易'),
              body: const StockList(),
            ),
            fluent.PaneItem(
              icon: const Icon(fluent.FluentIcons.news),
              title: const Text('财经新闻'),
              body: const NewsList(),
            ),
            fluent.PaneItem(
              icon: const Icon(fluent.FluentIcons.account_management),
              title: const Text('我的持仓'),
              body: const PositionList(),
            ),
            fluent.PaneItem(
              icon: const Icon(fluent.FluentIcons.chart),
              title: const Text('市场概览'),
              body: const MarketOverviewPanel(),
            ),
          ],
          footerItems: [
            fluent.PaneItem(
              icon: const Icon(fluent.FluentIcons.settings),
              title: const Text('设置'),
              body: const SettingsPanel(),
            ),
          ],
        ),
      ),
    );
  }
}

class StockList extends StatelessWidget {
  const StockList({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<GameProvider>(
      builder: (context, game, _) {
        final industries = game.state.stocks.map((s) => s.industry).toSet().toList();
        
        return Column(
          children: [
            // 行业筛选
            SizedBox(
              height: 40,
              child: ListView(
                scrollDirection: Axis.horizontal,
                children: [
                  fluent.Button(child: const Text('全部'), onPressed: () {}),
                  ...industries.map((i) => Padding(
                    padding: const EdgeInsets.only(left: 8),
                    child: fluent.Button(child: Text(i), onPressed: () {}),
                  )),
                ],
              ),
            ),
            const SizedBox(height: 8),
            // 股票列表
            Expanded(
              child: ListView.builder(
                padding: const EdgeInsets.all(8),
                itemCount: game.state.stocks.length,
                itemBuilder: (_, i) => StockCard(stock: game.state.stocks[i]),
              ),
            ),
          ],
        );
      },
    );
  }
}

class NewsList extends StatelessWidget {
  const NewsList({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<GameProvider>(
      builder: (context, game, _) {
        if (game.news.isEmpty) {
          return const Center(child: Text('暂无新闻'));
        }
        return ListView.builder(
          padding: const EdgeInsets.all(8),
          itemCount: game.news.length,
          itemBuilder: (_, i) => NewsCard(news: game.news[i]),
        );
      },
    );
  }
}

class PositionList extends StatelessWidget {
  const PositionList({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<GameProvider>(
      builder: (context, game, _) {
        if (game.state.positions.isEmpty) {
          return const Center(child: Text('暂无持仓'));
        }
        return ListView.builder(
          padding: const EdgeInsets.all(8),
          itemCount: game.state.positions.length,
          itemBuilder: (_, i) => PositionCard(position: game.state.positions[i]),
        );
      },
    );
  }
}

class MarketOverviewPanel extends StatelessWidget {
  const MarketOverviewPanel({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<GameProvider>(
      builder: (context, game, _) => MarketOverview(
        indices: game.indices,
        sentiment: game.marketSentiment,
        stocks: game.state.stocks,
      ),
    );
  }
}

class SettingsPanel extends StatelessWidget {
  const SettingsPanel({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<GameProvider>(
      builder: (context, game, _) => Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text('游戏设置', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
            const SizedBox(height: 16),
            Text('游戏模式: ${game.gameMode == 'normal' ? '普通模式' : '生存模式'}'),
            Text('难度: ${game.difficulty}'),
            const SizedBox(height: 16),
            fluent.FilledButton(
              onPressed: () {
                // 返回主菜单
              },
              child: const Text('返回主菜单'),
            ),
          ],
        ),
      ),
    );
  }
}
