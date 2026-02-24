enum NewsCategory {
  macro,      // 宏观经济
  industry,   // 行业动态
  company,    // 公司新闻
  policy,     // 政策法规
  international, // 国际形势
  sentiment,  // 市场情绪
  finance,    // 金融动态
}

enum NewsImportance {
  minor,    // 次要
  normal,   // 普通
  major,    // 重要
  critical, // 重大
}

class News {
  final String id;
  final String title;
  final String content;
  final NewsCategory category;
  final NewsImportance importance;
  final DateTime publishTime;
  final List<String> affectedIndustries;
  final List<String> affectedStocks;
  final double marketEffect;
  final bool isDigested;

  News({
    required this.id,
    required this.title,
    required this.content,
    required this.category,
    required this.importance,
    required this.publishTime,
    this.affectedIndustries = const [],
    this.affectedStocks = const [],
    this.marketEffect = 0,
    this.isDigested = false,
  });

  News copyWith({
    bool? isDigested,
  }) {
    return News(
      id: id,
      title: title,
      content: content,
      category: category,
      importance: importance,
      publishTime: publishTime,
      affectedIndustries: affectedIndustries,
      affectedStocks: affectedStocks,
      marketEffect: marketEffect,
      isDigested: isDigested ?? this.isDigested,
    );
  }
}

class NewsTemplate {
  final String title;
  final String content;
  final NewsCategory category;
  final NewsImportance importance;
  final List<String> industries;
  final double minEffect;
  final double maxEffect;

  const NewsTemplate({
    required this.title,
    required this.content,
    required this.category,
    required this.importance,
    this.industries = const [],
    this.minEffect = -5,
    this.maxEffect = 5,
  });
}
