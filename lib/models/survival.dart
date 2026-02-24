class SurvivalStatus {
  double hunger;    // 饥饿 0-100
  double thirst;    // 口渴 0-100
  double health;    // 健康 0-100
  double mood;      // 心情 0-100

  SurvivalStatus({
    this.hunger = 100,
    this.thirst = 100,
    this.health = 100,
    this.mood = 100,
  });

  void decay(double rate) {
    hunger = (hunger - rate).clamp(0, 100);
    thirst = (thirst - rate * 1.2).clamp(0, 100);
    health = (health - rate * 0.3).clamp(0, 100);
    mood = (mood - rate * 0.5).clamp(0, 100);
  }

  bool get isCritical => hunger < 20 || thirst < 20 || health < 20;
  bool get isDead => hunger <= 0 || thirst <= 0 || health <= 0;
}

class ShopItem {
  final String id;
  final String name;
  final String icon;
  final String description;
  final double price;
  final String category;
  final Map<String, double> effects;
  final int shelfLife;

  const ShopItem({
    required this.id,
    required this.name,
    required this.icon,
    required this.description,
    required this.price,
    required this.category,
    required this.effects,
    this.shelfLife = 0,
  });
}

class InventoryItem {
  final ShopItem item;
  final DateTime purchaseDate;
  int quantity;

  InventoryItem({
    required this.item,
    required this.purchaseDate,
    required this.quantity,
  });

  bool get isExpired {
    if (item.shelfLife == 0) return false;
    return DateTime.now().difference(purchaseDate).inDays > item.shelfLife;
  }
}

class Job {
  final String id;
  final String name;
  final String icon;
  final String description;
  final double hourlyPay;
  final double energyCost;
  final double moodEffect;
  final double requiredHealth;
  final List<int> workHours;

  const Job({
    required this.id,
    required this.name,
    required this.icon,
    required this.description,
    required this.hourlyPay,
    required this.energyCost,
    required this.moodEffect,
    required this.requiredHealth,
    required this.workHours,
  });
}

class Entertainment {
  final String id;
  final String name;
  final String icon;
  final String description;
  final double cost;
  final double moodBoost;
  final int timeCost;

  const Entertainment({
    required this.id,
    required this.name,
    required this.icon,
    required this.description,
    required this.cost,
    required this.moodBoost,
    required this.timeCost,
  });
}
