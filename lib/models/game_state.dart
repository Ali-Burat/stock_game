import 'stock.dart';
import 'player.dart';

class GameState {
  final String playerName;
  final Player? player;
  final double cash;
  final List<Position> positions;
  final List<Transaction> transactions;
  final int gameDay;
  final int gameTime;
  final bool isPaused;
  final List<Stock> stocks;

  GameState({
    required this.playerName,
    this.player,
    this.cash = 0,
    this.positions = const [],
    this.transactions = const [],
    this.gameDay = 1,
    this.gameTime = 8,
    this.isPaused = false,
    this.stocks = const [],
  });

  GameState copyWith({
    String? playerName,
    Player? player,
    double? cash,
    List<Position>? positions,
    List<Transaction>? transactions,
    int? gameDay,
    int? gameTime,
    bool? isPaused,
    List<Stock>? stocks,
  }) {
    return GameState(
      playerName: playerName ?? this.playerName,
      player: player ?? this.player,
      cash: cash ?? this.cash,
      positions: positions ?? this.positions,
      transactions: transactions ?? this.transactions,
      gameDay: gameDay ?? this.gameDay,
      gameTime: gameTime ?? this.gameTime,
      isPaused: isPaused ?? this.isPaused,
      stocks: stocks ?? this.stocks,
    );
  }

  double get totalAssets {
    double total = cash;
    for (var pos in positions) {
      total += pos.currentPrice * pos.shares;
    }
    return total;
  }
}
