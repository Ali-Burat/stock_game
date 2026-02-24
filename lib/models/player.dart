class Player {
  final String id;
  final String name;
  final String icon;
  final String description;
  final int initialCash;
  final int stressResistance;
  final int workEfficiency;
  final int investmentSense;

  const Player({
    required this.id,
    required this.name,
    required this.icon,
    required this.description,
    required this.initialCash,
    this.stressResistance = 50,
    this.workEfficiency = 50,
    this.investmentSense = 50,
  });
}

class Position {
  final String stockId;
  final String stockCode;
  final String stockName;
  int shares;
  double averageCost;
  double currentPrice;
  double profit;
  double profitPercent;

  Position({
    required this.stockId,
    required this.stockCode,
    required this.stockName,
    required this.shares,
    required this.averageCost,
    required this.currentPrice,
    this.profit = 0,
    this.profitPercent = 0,
  });

  void updateProfit(double newPrice) {
    currentPrice = newPrice;
    profit = (currentPrice - averageCost) * shares;
    profitPercent = ((currentPrice - averageCost) / averageCost) * 100;
  }
}

class Transaction {
  final String id;
  final String type;
  final String stockId;
  final String stockCode;
  final String stockName;
  final int shares;
  final double price;
  final double totalAmount;
  final DateTime timestamp;

  Transaction({
    required this.id,
    required this.type,
    required this.stockId,
    required this.stockCode,
    required this.stockName,
    required this.shares,
    required this.price,
    required this.totalAmount,
    required this.timestamp,
  });
}
