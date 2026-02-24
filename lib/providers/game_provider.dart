import 'dart:math';
import 'package:flutter/foundation.dart';
import '../models/stock.dart';
import '../models/player.dart';
import '../models/news.dart';
import '../models/market_index.dart';
import '../models/survival.dart';
import '../models/game_state.dart';
import '../data/stocks_data.dart';
import '../data/news_data.dart';

class GameProvider extends ChangeNotifier {
  GameState _state = GameState(playerName: '');
  final Random _random = Random();
  
  // 市场状态
  double _marketSentiment = 0;
  List<News> _news = [];
  List<MarketIndex> _indices = [];
  
  // 生存状态
  SurvivalStatus _survival = SurvivalStatus();
  List<InventoryItem> _inventory = [];
  
  // 游戏设置
  String _gameMode = 'normal';
  String _difficulty = 'normal';
  bool _isPaused = false;
  int _gameSpeed = 1;

  GameState get state => _state;
  double get marketSentiment => _marketSentiment;
  List<News> get news => _news;
  List<MarketIndex> get indices => _indices;
  SurvivalStatus get survival => _survival;
  List<InventoryItem> get inventory => _inventory;
  String get gameMode => _gameMode;
  String get difficulty => _difficulty;
  bool get isPaused => _isPaused;
  int get gameSpeed => _gameSpeed;

  // 初始化游戏
  void startGame(String name, Player player, {String mode = 'normal', String difficulty = 'normal'}) {
    _gameMode = mode;
    _difficulty = difficulty;
    
    _state = GameState(
      playerName: name,
      player: player,
      cash: player.initialCash.toDouble(),
      stocks: INITIAL_STOCKS.map((s) => Stock(
        id: s.id,
        code: s.code,
        name: s.name,
        industry: s.industry,
        basePrice: s.basePrice,
        currentPrice: s.currentPrice,
        volatility: s.volatility,
        description: s.description,
        board: s.board,
      )).toList(),
    );
    
    _initMarketIndices();
    _survival = SurvivalStatus();
    _news = [];
    _inventory = [];
    _marketSentiment = 0;
    
    notifyListeners();
  }

  // 初始化大盘指数
  void _initMarketIndices() {
    _indices = [
      MarketIndex(id: 'sh', code: '000001', name: '上证指数', currentValue: 3100, components: ['1','2','3','4','5','6','7','8','9','10']),
      MarketIndex(id: 'sz', code: '399001', name: '深证成指', currentValue: 9500, components: ['11','12','13','14','15','16','17','18','19','20']),
      MarketIndex(id: 'cy', code: '399006', name: '创业板指', currentValue: 1900, components: ['13','14','26']),
      MarketIndex(id: 'hs300', code: '000300', name: '沪深300', currentValue: 3800, components: ['1','2','3','5','6','8','14','15','17','22']),
    ];
  }

  // 更新股票价格
  void updateStockPrices() {
    if (_isPaused) return;

    for (var stock in _state.stocks) {
      // 基础波动
      var change = (_random.nextDouble() - 0.5) * 2 * stock.volatility;
      
      // 市场情绪影响
      change += _marketSentiment * 0.001;
      
      // 新闻影响
      for (var n in _news.where((n) => !n.isDigested)) {
        if (n.affectedIndustries.contains(stock.industry)) {
          change += n.marketEffect * 0.005;
        }
      }
      
      final newPrice = max(0.01, stock.currentPrice * (1 + change));
      stock.updatePrice(newPrice);
    }
    
    // 更新持仓
    for (var pos in _state.positions) {
      final stock = _state.stocks.firstWhere((s) => s.id == pos.stockId);
      pos.updateProfit(stock.currentPrice);
    }
    
    // 更新大盘指数
    _updateIndices();
    
    notifyListeners();
  }

  // 更新大盘指数
  void _updateIndices() {
    for (var index in _indices) {
      double totalChange = 0;
      int count = 0;
      
      for (var stock in _state.stocks) {
        if (index.components.contains(stock.id)) {
          totalChange += stock.dayChangePercent;
          count++;
        }
      }
      
      if (count > 0) {
        index.dayChangePercent = totalChange / count;
        index.dayChange = index.currentValue * index.dayChangePercent / 100;
        index.currentValue += index.dayChange;
        
        index.history.add(IndexHistory(time: DateTime.now(), value: index.currentValue));
        if (index.history.length > 100) index.history.removeAt(0);
      }
    }
  }

  // 生成新闻
  void generateNews() {
    if (_random.nextDouble() > 0.1) return; // 10%概率生成新闻
    
    final template = NEWS_TEMPLATES[_random.nextInt(NEWS_TEMPLATES.length)];
    final newsItem = News(
      id: DateTime.now().millisecondsSinceEpoch.toString(),
      title: template.title,
      content: template.content,
      category: template.category,
      importance: template.importance,
      publishTime: DateTime.now(),
      affectedIndustries: template.industries,
      marketEffect: template.minEffect + _random.nextDouble() * (template.maxEffect - template.minEffect),
    );
    
    _news.insert(0, newsItem);
    
    // 更新市场情绪
    _marketSentiment += newsItem.marketEffect * 2;
    _marketSentiment = _marketSentiment.clamp(-100, 100);
    
    notifyListeners();
  }

  // 消化新闻
  void digestNews(String newsId) {
    final index = _news.indexWhere((n) => n.id == newsId);
    if (index >= 0) {
      _news[index] = _news[index].copyWith(isDigested: true);
      notifyListeners();
    }
  }

  // 买入股票
  bool buyStock(Stock stock, int shares) {
    final totalCost = stock.currentPrice * shares;
    if (totalCost > _state.cash) return false;

    final existingPosition = _state.positions.where((p) => p.stockId == stock.id).firstOrNull;

    if (existingPosition != null) {
      final totalShares = existingPosition.shares + shares;
      final newAvgCost = (existingPosition.averageCost * existingPosition.shares + totalCost) / totalShares;
      existingPosition.shares = totalShares;
      existingPosition.averageCost = newAvgCost;
      existingPosition.currentPrice = stock.currentPrice;
      existingPosition.updateProfit(stock.currentPrice);
    } else {
      _state.positions.add(Position(
        stockId: stock.id,
        stockCode: stock.code,
        stockName: stock.name,
        shares: shares,
        averageCost: stock.currentPrice,
        currentPrice: stock.currentPrice,
      ));
    }

    _state.transactions.add(Transaction(
      id: DateTime.now().millisecondsSinceEpoch.toString(),
      type: 'buy',
      stockId: stock.id,
      stockCode: stock.code,
      stockName: stock.name,
      shares: shares,
      price: stock.currentPrice,
      totalAmount: totalCost,
      timestamp: DateTime.now(),
    ));

    _state = _state.copyWith(cash: _state.cash - totalCost);
    notifyListeners();
    return true;
  }

  // 卖出股票
  bool sellStock(Stock stock, int shares) {
    final position = _state.positions.where((p) => p.stockId == stock.id).firstOrNull;
    if (position == null || position.shares < shares) return false;

    final totalAmount = stock.currentPrice * shares;

    if (position.shares == shares) {
      _state.positions.removeWhere((p) => p.stockId == stock.id);
    } else {
      position.shares -= shares;
      position.updateProfit(stock.currentPrice);
    }

    _state.transactions.add(Transaction(
      id: DateTime.now().millisecondsSinceEpoch.toString(),
      type: 'sell',
      stockId: stock.id,
      stockCode: stock.code,
      stockName: stock.name,
      shares: shares,
      price: stock.currentPrice,
      totalAmount: totalAmount,
      timestamp: DateTime.now(),
    ));

    _state = _state.copyWith(cash: _state.cash + totalAmount);
    notifyListeners();
    return true;
  }

  // 生存模式相关
  void updateSurvival() {
    if (_gameMode != 'survival' || _isPaused) return;
    
    _survival.decay(0.5);
    
    if (_survival.isDead) {
      // 游戏结束
    }
    
    notifyListeners();
  }

  void consumeItem(String itemId) {
    final index = _inventory.indexWhere((i) => i.item.id == itemId);
    if (index >= 0) {
      final item = _inventory[index];
      
      item.item.effects.forEach((key, value) {
        switch (key) {
          case 'hunger':
            _survival.hunger = (_survival.hunger + value).clamp(0, 100);
            break;
          case 'thirst':
            _survival.thirst = (_survival.thirst + value).clamp(0, 100);
            break;
          case 'health':
            _survival.health = (_survival.health + value).clamp(0, 100);
            break;
          case 'mood':
            _survival.mood = (_survival.mood + value).clamp(0, 100);
            break;
        }
      });
      
      item.quantity--;
      if (item.quantity <= 0) {
        _inventory.removeAt(index);
      }
      
      notifyListeners();
    }
  }

  // 暂停/继续
  void togglePause() {
    _isPaused = !_isPaused;
    notifyListeners();
  }

  // 设置游戏速度
  void setGameSpeed(int speed) {
    _gameSpeed = speed.clamp(1, 10);
    notifyListeners();
  }

  // 推进时间
  void advanceTime() {
    if (_isPaused) return;

    int newTime = _state.gameTime + 1;
    int newDay = _state.gameDay;

    if (newTime >= 24) {
      newTime = 0;
      newDay++;
      
      // 每日重置
      for (var stock in _state.stocks) {
        stock.dayOpenPrice = stock.currentPrice;
        stock.dayHighPrice = stock.currentPrice;
        stock.dayLowPrice = stock.currentPrice;
      }
    }

    _state = _state.copyWith(gameTime: newTime, gameDay: newDay);
    notifyListeners();
  }
}
