class MarketIndex {
  final String id;
  final String code;
  final String name;
  double currentValue;
  double previousClose;
  double dayChange;
  double dayChangePercent;
  final List<String> components;
  List<IndexHistory> history;

  MarketIndex({
    required this.id,
    required this.code,
    required this.name,
    required this.currentValue,
    this.previousClose = 0,
    this.dayChange = 0,
    this.dayChangePercent = 0,
    required this.components,
    List<IndexHistory>? history,
  }) : history = history ?? [];
}

class IndexHistory {
  final DateTime time;
  final double value;

  IndexHistory({required this.time, required this.value});
}
