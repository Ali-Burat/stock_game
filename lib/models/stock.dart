class Stock {
  final String id;
  final String code;
  final String name;
  final String industry;
  final double basePrice;
  double currentPrice;
  double previousPrice;
  double dayOpenPrice;
  double dayHighPrice;
  double dayLowPrice;
  double dayChange;
  double dayChangePercent;
  final double volatility;
  String trend;
  final String description;
  final int totalShares;
  final double marketCap;
  final double peRatio;
  final double dividendYield;
  final bool isSt;
  final String board;
  List<PriceHistory> history;

  Stock({
    required this.id,
    required this.code,
    required this.name,
    required this.industry,
    required this.basePrice,
    required this.currentPrice,
    this.previousPrice = 0,
    this.dayOpenPrice = 0,
    this.dayHighPrice = 0,
    this.dayLowPrice = 0,
    this.dayChange = 0,
    this.dayChangePercent = 0,
    required this.volatility,
    this.trend = 'stable',
    required this.description,
    this.totalShares = 100000000,
    this.marketCap = 0,
    this.peRatio = 0,
    this.dividendYield = 0,
    this.isSt = false,
    this.board = 'main',
    List<PriceHistory>? history,
  }) : history = history ?? [] {
    dayOpenPrice = currentPrice;
    dayHighPrice = currentPrice;
    dayLowPrice = currentPrice;
  }

  // 涨跌停限制
  double get limitUp {
    if (isSt) return basePrice * 1.05;
    if (board == 'gem' || board == 'star') return basePrice * 1.20;
    return basePrice * 1.10;
  }

  double get limitDown {
    if (isSt) return basePrice * 0.95;
    if (board == 'gem' || board == 'star') return basePrice * 0.80;
    return basePrice * 0.90;
  }

  void updatePrice(double newPrice) {
    previousPrice = currentPrice;
    
    // 应用涨跌停限制
    newPrice = newPrice.clamp(limitDown, limitUp);
    
    currentPrice = newPrice;
    dayChange = currentPrice - basePrice;
    dayChangePercent = (dayChange / basePrice) * 100;
    
    if (currentPrice > dayHighPrice) dayHighPrice = currentPrice;
    if (currentPrice < dayLowPrice) dayLowPrice = currentPrice;
    
    if (dayChangePercent > 2) {
      trend = 'up';
    } else if (dayChangePercent < -2) {
      trend = 'down';
    } else {
      trend = 'stable';
    }
    
    history.add(PriceHistory(
      time: DateTime.now(),
      price: newPrice,
    ));
    
    if (history.length > 100) {
      history.removeAt(0);
    }
  }

  bool get isLimitUp => currentPrice >= limitUp;
  bool get isLimitDown => currentPrice <= limitDown;
}

class PriceHistory {
  final DateTime time;
  final double price;

  PriceHistory({required this.time, required this.price});
}
