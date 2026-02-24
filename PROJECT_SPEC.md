# 炒股人生 - 股市模拟游戏项目文档

## 一、项目概述

### 1.1 项目名称
炒股人生 (Stock Game)

### 1.2 项目描述
一个跨平台股市模拟游戏，让玩家在虚拟环境中体验股票交易，学习投资理财知识。

### 1.3 目标平台
- **主要平台**: Android (APK)
- **次要平台**: Windows (EXE), Web

### 1.4 技术栈
- **框架**: Flutter 3.24+
- **语言**: Dart 3.5+
- **UI库**: Fluent UI (fluent_ui package)
- **状态管理**: Provider
- **图表**: fl_chart (可选)

---

## 二、功能需求

### 2.1 核心功能

#### 2.1.1 股票交易系统
- 30只股票，涵盖15个行业
- 实时价格波动（每秒更新）
- 涨跌停机制
- 买入/卖出交易
- 持仓管理
- 盈亏计算

#### 2.1.2 大盘指数系统
- 上证指数
- 深证成指
- 创业板指
- 沪深300
- 根据成分股实时计算

#### 2.1.3 新闻系统
- 7种新闻类型
- 新闻影响股票价格
- 新闻影响市场情绪

#### 2.1.4 市场情绪系统
- 恐慌/贪婪指数 (-100 到 100)
- 影响股票波动幅度

#### 2.1.5 玩家系统
- 10种玩家身份
- 5种难度等级
- 存档系统

#### 2.1.6 生存模式（可选）
- 饥饿、口渴、健康、心情
- 商店系统
- 工作系统
- 娱乐系统

### 2.2 游戏模式

#### 普通模式
- 专注股票交易
- 无生存压力

#### 生存模式
- 平衡生活与投资
- 管理生存状态

### 2.3 难度等级

| 难度 | 初始资金倍率 | 波动倍率 | 事件概率 |
|------|-------------|---------|---------|
| 简单 | 2x | 0.5x | 0.5x |
| 普通 | 1x | 1x | 1x |
| 困难 | 0.5x | 1.5x | 2x |
| 现实 | 1x | 2x | 1x |
| 作弊 | 999999x | 1x | 0x |

---

## 三、数据结构

### 3.1 股票 (Stock)

```dart
class Stock {
  final String id;              // 股票ID
  final String code;            // 股票代码
  final String name;            // 股票名称
  final String industry;        // 所属行业
  final double basePrice;       // 基准价格
  double currentPrice;          // 当前价格
  double previousPrice;         // 前一价格
  double dayOpenPrice;          // 今日开盘价
  double dayHighPrice;          // 今日最高价
  double dayLowPrice;           // 今日最低价
  double dayChange;             // 今日涨跌额
  double dayChangePercent;      // 今日涨跌幅%
  final double volatility;      // 波动率
  String trend;                 // 趋势: up/down/stable
  final String description;     // 描述
  final int totalShares;        // 总股本
  final bool isSt;              // 是否ST
  final String board;           // 板块: main/gem/star
  List<PriceHistory> history;   // 价格历史
}

// 涨跌停限制
double get limitUp {
  if (isSt) return basePrice * 1.05;      // ST股 5%
  if (board == 'gem' || board == 'star') return basePrice * 1.20;  // 创业板/科创板 20%
  return basePrice * 1.10;                // 主板 10%
}

double get limitDown {
  if (isSt) return basePrice * 0.95;
  if (board == 'gem' || board == 'star') return basePrice * 0.80;
  return basePrice * 0.90;
}
```

### 3.2 玩家身份 (Player)

```dart
class Player {
  final String id;
  final String name;
  final String icon;            // emoji图标
  final String description;
  final int initialCash;        // 初始资金
  final int stressResistance;   // 抗压能力 1-100
  final int workEfficiency;     // 工作效率 1-100
  final int investmentSense;    // 投资直觉 1-100
}
```

### 3.3 持仓 (Position)

```dart
class Position {
  final String stockId;
  final String stockCode;
  final String stockName;
  int shares;                   // 持股数量
  double averageCost;           // 平均成本
  double currentPrice;          // 当前价格
  double profit;                // 盈亏金额
  double profitPercent;         // 盈亏百分比
}
```

### 3.4 交易记录 (Transaction)

```dart
class Transaction {
  final String id;
  final String type;            // buy/sell
  final String stockId;
  final String stockCode;
  final String stockName;
  final int shares;
  final double price;
  final double totalAmount;
  final DateTime timestamp;
}
```

### 3.5 新闻 (News)

```dart
enum NewsCategory {
  macro,         // 宏观经济
  industry,      // 行业动态
  company,       // 公司新闻
  policy,        // 政策法规
  international, // 国际形势
  sentiment,     // 市场情绪
  finance,       // 金融动态
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
  final List<String> affectedIndustries;  // 影响的行业
  final double marketEffect;              // 市场影响 -10 到 +10
  final bool isDigested;                  // 是否已消化
}
```

### 3.6 大盘指数 (MarketIndex)

```dart
class MarketIndex {
  final String id;
  final String code;
  final String name;
  double currentValue;
  double previousClose;
  double dayChange;
  double dayChangePercent;
  final List<String> components;  // 成分股ID列表
  List<IndexHistory> history;
}
```

### 3.7 游戏状态 (GameState)

```dart
class GameState {
  final String playerName;
  final Player? player;
  final double cash;
  final List<Position> positions;
  final List<Transaction> transactions;
  final int gameDay;           // 游戏天数
  final int gameTime;          // 游戏小时 0-23
  final bool isPaused;
  final List<Stock> stocks;
  
  double get totalAssets {
    double total = cash;
    for (var pos in positions) {
      total += pos.currentPrice * pos.shares;
    }
    return total;
  }
}
```

### 3.8 生存状态 (SurvivalStatus) - 生存模式

```dart
class SurvivalStatus {
  double hunger;   // 饥饿 0-100
  double thirst;   // 口渴 0-100
  double health;   // 健康 0-100
  double mood;     // 心情 0-100
  
  void decay(double rate) {
    hunger = (hunger - rate).clamp(0, 100);
    thirst = (thirst - rate * 1.2).clamp(0, 100);
    health = (health - rate * 0.3).clamp(0, 100);
    mood = (mood - rate * 0.5).clamp(0, 100);
  }
}
```

---

## 四、初始数据

### 4.1 股票列表 (30只)

```dart
// 银行股
{id: '1', code: '600000', name: '浦发银行', industry: '银行', basePrice: 10.5, volatility: 0.02}
{id: '2', code: '600036', name: '招商银行', industry: '银行', basePrice: 35.8, volatility: 0.025}
{id: '3', code: '601318', name: '中国平安', industry: '保险', basePrice: 48.5, volatility: 0.02}
{id: '4', code: '000001', name: '平安银行', industry: '银行', basePrice: 12.8, volatility: 0.022}

// 白酒股
{id: '5', code: '600519', name: '贵州茅台', industry: '白酒', basePrice: 1850.0, volatility: 0.03}
{id: '6', code: '000858', name: '五粮液', industry: '白酒', basePrice: 168.5, volatility: 0.028}
{id: '7', code: '000568', name: '泸州老窖', industry: '白酒', basePrice: 235.0, volatility: 0.032}

// 家电股
{id: '8', code: '000333', name: '美的集团', industry: '家电', basePrice: 58.2, volatility: 0.022}
{id: '9', code: '000651', name: '格力电器', industry: '家电', basePrice: 38.5, volatility: 0.025}
{id: '10', code: '600690', name: '海尔智家', industry: '家电', basePrice: 25.8, volatility: 0.02}

// 医药股
{id: '11', code: '600276', name: '恒瑞医药', industry: '医药', basePrice: 45.8, volatility: 0.035}
{id: '12', code: '000538', name: '云南白药', industry: '医药', basePrice: 92.5, volatility: 0.028}
{id: '13', code: '300760', name: '迈瑞医疗', industry: '医药', basePrice: 320.0, volatility: 0.032, board: 'gem'}

// 新能源股
{id: '14', code: '300750', name: '宁德时代', industry: '新能源', basePrice: 215.0, volatility: 0.04, board: 'gem'}
{id: '15', code: '002594', name: '比亚迪', industry: '新能源', basePrice: 268.0, volatility: 0.038}
{id: '16', code: '601012', name: '隆基绿能', industry: '新能源', basePrice: 42.5, volatility: 0.035}

// 科技股
{id: '17', code: '002415', name: '海康威视', industry: '科技', basePrice: 35.2, volatility: 0.03}
{id: '18', code: '002475', name: '立讯精密', industry: '科技', basePrice: 32.8, volatility: 0.032}
{id: '19', code: '600588', name: '用友网络', industry: '科技', basePrice: 28.5, volatility: 0.028}

// 汽车股
{id: '20', code: '600104', name: '上汽集团', industry: '汽车', basePrice: 18.5, volatility: 0.022}
{id: '21', code: '601238', name: '广汽集团', industry: '汽车', basePrice: 12.8, volatility: 0.025}

// 地产股
{id: '22', code: '000002', name: '万科A', industry: '地产', basePrice: 15.8, volatility: 0.035}
{id: '23', code: '001979', name: '招商蛇口', industry: '地产', basePrice: 18.2, volatility: 0.032}

// 零售股
{id: '24', code: '601933', name: '永辉超市', industry: '零售', basePrice: 4.2, volatility: 0.028}
{id: '25', code: '002024', name: '苏宁易购', industry: '零售', basePrice: 2.8, volatility: 0.04}

// 传媒股
{id: '26', code: '300059', name: '东方财富', industry: '传媒', basePrice: 18.5, volatility: 0.038, board: 'gem'}
{id: '27', code: '603444', name: '吉比特', industry: '传媒', basePrice: 285.0, volatility: 0.032}

// 化工股
{id: '28', code: '600309', name: '万华化学', industry: '化工', basePrice: 98.5, volatility: 0.028}
{id: '29', code: '002648', name: '卫星化学', industry: '化工', basePrice: 18.2, volatility: 0.032}

// 电力股
{id: '30', code: '600900', name: '长江电力', industry: '电力', basePrice: 28.5, volatility: 0.015}
```

### 4.2 玩家身份 (10种)

```dart
{id: 'student', name: '大学生', icon: '🎓', initialCash: 10000}
{id: 'worker', name: '上班族', icon: '👔', initialCash: 50000}
{id: 'entrepreneur', name: '创业者', icon: '💼', initialCash: 200000}
{id: 'retiree', name: '退休人员', icon: '👴', initialCash: 100000}
{id: 'trader', name: '职业交易员', icon: '📊', initialCash: 100000}
{id: 'investor', name: '价值投资者', icon: '💰', initialCash: 500000}
{id: 'housewife', name: '家庭主妇', icon: '👩', initialCash: 30000}
{id: 'programmer', name: '程序员', icon: '💻', initialCash: 80000}
{id: 'doctor', name: '医生', icon: '👨‍⚕️', initialCash: 150000}
{id: 'custom', name: '自定义', icon: '⚙️', initialCash: 50000}
```

### 4.3 新闻模板

```dart
// 宏观经济
{title: '央行宣布降准', category: macro, importance: major, industries: ['银行', '保险'], effect: 3-8%}
{title: 'GDP增速超预期', category: macro, importance: major, effect: 2-6%}

// 行业动态
{title: '新能源汽车销量创新高', category: industry, importance: major, industries: ['新能源', '汽车'], effect: 5-12%}
{title: '白酒行业提价潮', category: industry, importance: normal, industries: ['白酒'], effect: 3-8%}
{title: '医药集采结果公布', category: industry, importance: major, industries: ['医药'], effect: -8-3%}

// 政策法规
{title: '房地产政策调整', category: policy, importance: major, industries: ['地产'], effect: -5-5%}

// 国际形势
{title: '美联储加息', category: international, importance: critical, effect: -5-3%}

// 市场情绪
{title: '市场情绪高涨', category: sentiment, importance: normal, effect: 1-4%}
{title: '市场恐慌情绪蔓延', category: sentiment, importance: normal, effect: -4--1%}
```

---

## 五、游戏逻辑

### 5.1 价格更新算法

```dart
void updateStockPrices() {
  for (var stock in stocks) {
    // 1. 基础随机波动
    var change = (random.nextDouble() - 0.5) * 2 * stock.volatility;
    
    // 2. 市场情绪影响
    change += marketSentiment * 0.001;
    
    // 3. 新闻影响
    for (var news in activeNews) {
      if (news.affectedIndustries.contains(stock.industry)) {
        change += news.marketEffect * 0.005;
      }
    }
    
    // 4. 计算新价格
    double newPrice = stock.currentPrice * (1 + change);
    
    // 5. 应用涨跌停限制
    newPrice = newPrice.clamp(stock.limitDown, stock.limitUp);
    
    // 6. 更新股票
    stock.updatePrice(newPrice);
  }
}
```

### 5.2 大盘指数计算

```dart
void updateIndices() {
  for (var index in indices) {
    double totalChange = 0;
    int count = 0;
    
    for (var stock in stocks) {
      if (index.components.contains(stock.id)) {
        totalChange += stock.dayChangePercent;
        count++;
      }
    }
    
    index.dayChangePercent = totalChange / count;
    index.currentValue += index.currentValue * index.dayChangePercent / 100;
  }
}
```

### 5.3 买入逻辑

```dart
bool buyStock(Stock stock, int shares) {
  double totalCost = stock.currentPrice * shares;
  
  // 检查资金
  if (totalCost > cash) return false;
  
  // 更新持仓
  if (hasPosition(stock.id)) {
    // 加仓：重新计算平均成本
    position.averageCost = (position.averageCost * position.shares + totalCost) / (position.shares + shares);
    position.shares += shares;
  } else {
    // 新建仓位
    positions.add(new Position(stock, shares, stock.currentPrice));
  }
  
  // 扣除资金
  cash -= totalCost;
  
  // 记录交易
  transactions.add(new Transaction('buy', stock, shares, stock.currentPrice));
  
  return true;
}
```

### 5.4 卖出逻辑

```dart
bool sellStock(Stock stock, int shares) {
  Position position = findPosition(stock.id);
  
  // 检查持仓
  if (position == null || position.shares < shares) return false;
  
  double totalAmount = stock.currentPrice * shares;
  
  // 更新持仓
  if (position.shares == shares) {
    positions.remove(position);
  } else {
    position.shares -= shares;
  }
  
  // 增加资金
  cash += totalAmount;
  
  // 记录交易
  transactions.add(new Transaction('sell', stock, shares, stock.currentPrice));
  
  return true;
}
```

### 5.5 新闻生成

```dart
void generateNews() {
  // 10%概率生成新闻
  if (random.nextDouble() > 0.1) return;
  
  // 随机选择模板
  template = randomChoice(newsTemplates);
  
  // 创建新闻
  news = News(
    title: template.title,
    category: template.category,
    importance: template.importance,
    affectedIndustries: template.industries,
    marketEffect: randomInRange(template.minEffect, template.maxEffect),
  );
  
  // 添加到新闻列表
  newsList.insert(0, news);
  
  // 更新市场情绪
  marketSentiment += news.marketEffect * 2;
  marketSentiment = marketSentiment.clamp(-100, 100);
}
```

### 5.6 游戏时间

```dart
void advanceTime() {
  gameTime++;
  
  if (gameTime >= 24) {
    gameTime = 0;
    gameDay++;
    
    // 每日重置
    for (var stock in stocks) {
      stock.dayOpenPrice = stock.currentPrice;
      stock.dayHighPrice = stock.currentPrice;
      stock.dayLowPrice = stock.currentPrice;
    }
  }
}
```

---

## 六、UI设计

### 6.1 页面结构

```
┌─────────────────────────────────────────┐
│ 顶部栏: 游戏名称 | 天数时间 | 资金 | 暂停 │
├─────────────────────────────────────────┤
│ 侧边栏 │                               │
│ ┌─────┐ │                               │
│ │股票 │ │        主内容区域             │
│ │新闻 │ │                               │
│ │持仓 │ │                               │
│ │市场 │ │                               │
│ │设置 │ │                               │
│ └─────┘ │                               │
└─────────────────────────────────────────┘
```

### 6.2 开始界面

```
┌─────────────────────────────────────────┐
│           📈 炒股人生                    │
│        体验股市风云，感悟人生百态         │
├─────────────────────────────────────────┤
│  请输入您的名称: [________________]      │
├─────────────────────────────────────────┤
│  游戏模式:                               │
│  ┌─────────────┐ ┌─────────────┐        │
│  │📊 普通模式  │ │🏠 生存模式  │        │
│  │专注交易     │ │平衡生活     │        │
│  └─────────────┘ └─────────────┘        │
├─────────────────────────────────────────┤
│  难度选择:                               │
│  [简单] [普通] [困难] [现实] [作弊]      │
├─────────────────────────────────────────┤
│  选择身份:                               │
│  ┌─────┐ ┌─────┐ ┌─────┐ ┌─────┐       │
│  │🎓   │ │👔   │ │💼   │ │📊   │       │
│  │大学生│ │上班族│ │创业者│ │交易员│       │
│  │¥1万 │ │¥5万 │ │¥20万│ │¥10万│       │
│  └─────┘ └─────┘ └─────┘ └─────┘       │
├─────────────────────────────────────────┤
│          [  开始游戏  ]                  │
└─────────────────────────────────────────┘
```

### 6.3 股票列表界面

```
┌─────────────────────────────────────────┐
│ 行业筛选: [全部] [银行] [白酒] [家电]... │
├─────────────────────────────────────────┤
│ ┌─────────────────────────────────────┐ │
│ │ 浦发银行  600000        ↑           │ │
│ │ 银行                                │ │
│ │ ¥10.52          +2.15%             │ │
│ │ ─────────────────────────────────  │ │
│ │ [交易]                              │ │
│ │ 数量: ────●──────── 100股           │ │
│ │ 预计: ¥1,052                        │ │
│ │ [买入]              [卖出]          │ │
│ └─────────────────────────────────────┘ │
│ ┌─────────────────────────────────────┐ │
│ │ 招商银行  600036        ↓           │ │
│ │ 银行                                │ │
│ │ ¥35.42          -1.28%             │ │
│ │ [交易]                              │ │
│ └─────────────────────────────────────┘ │
└─────────────────────────────────────────┘
```

### 6.4 持仓界面

```
┌─────────────────────────────────────────┐
│              我的持仓                    │
├─────────────────────────────────────────┤
│ ┌─────────────────────────────────────┐ │
│ │ 贵州茅台              +5.23%        │ │
│ │ 持仓: 100股        盈利: +¥9,680    │ │
│ │ 成本: ¥1,850.00    现价: ¥1,946.80  │ │
│ └─────────────────────────────────────┘ │
│ ┌─────────────────────────────────────┐ │
│ │ 宁德时代              -2.15%        │ │
│ │ 持仓: 200股        亏损: -¥924      │ │
│ │ 成本: ¥215.00      现价: ¥210.38    │ │
│ └─────────────────────────────────────┘ │
└─────────────────────────────────────────┘
```

### 6.5 市场概览界面

```
┌─────────────────────────────────────────┐
│              大盘指数                    │
├─────────────────────────────────────────┤
│ ┌──────────┐ ┌──────────┐              │
│ │上证指数   │ │深证成指   │              │
│ │3,125.68  │ │9,542.15  │              │
│ │+0.82%    │ │-0.35%    │              │
│ └──────────┘ └──────────┘              │
├─────────────────────────────────────────┤
│              市场情绪                    │
│ 恐慌 ─────────●────────── 贪婪          │
│ 情绪指数: 25                           │
├─────────────────────────────────────────┤
│              市场统计                    │
│ ┌────┐ ┌────┐ ┌────┐ ┌────┐           │
│ │ 18 │ │ 10 │ │ 2  │ │ 0  │           │
│ │上涨│ │下跌│ │涨停│ │跌停│           │
│ └────┘ └────┘ └────┘ └────┘           │
└─────────────────────────────────────────┘
```

### 6.6 颜色规范

```dart
// 涨跌颜色（中国股市习惯）
上涨: Colors.red      // 红色
下跌: Colors.green    // 绿色
平盘: Colors.grey     // 灰色

// 状态颜色
正常: Colors.green    // >= 70%
警告: Colors.orange   // 40-70%
危险: Colors.red      // < 40%

// 新闻重要性
次要: Colors.grey
普通: Colors.blue
重要: Colors.orange
重大: Colors.red
```

---

## 七、文件结构

```
stock_game/
├── lib/
│   ├── main.dart                    # 应用入口
│   │
│   ├── models/                      # 数据模型
│   │   ├── stock.dart               # 股票模型
│   │   ├── player.dart              # 玩家/持仓模型
│   │   ├── news.dart                # 新闻模型
│   │   ├── market_index.dart        # 大盘指数模型
│   │   ├── survival.dart            # 生存系统模型
│   │   └── game_state.dart          # 游戏状态模型
│   │
│   ├── providers/                   # 状态管理
│   │   └── game_provider.dart       # 游戏状态Provider
│   │
│   ├── screens/                     # 页面
│   │   ├── start_screen.dart        # 开始界面
│   │   └── game_screen.dart         # 游戏主界面
│   │
│   ├── widgets/                     # 组件
│   │   ├── stock_card.dart          # 股票卡片
│   │   ├── position_card.dart       # 持仓卡片
│   │   ├── news_card.dart           # 新闻卡片
│   │   ├── market_overview.dart     # 市场概览
│   │   └── survival_panel.dart      # 生存面板
│   │
│   ├── constants/                   # 常量
│   │   └── game_constants.dart      # 游戏常量
│   │
│   └── data/                        # 数据
│       ├── stocks_data.dart         # 股票数据
│       └── news_data.dart           # 新闻模板数据
│
├── android/                         # Android项目
├── windows/                         # Windows项目
├── web/                             # Web项目
│
├── pubspec.yaml                     # 依赖配置
└── README.md                        # 项目说明
```

---

## 八、依赖配置

### pubspec.yaml

```yaml
name: stock_game
description: 炒股人生 - 股市模拟游戏
version: 1.0.0+1

environment:
  sdk: '>=3.4.0 <4.0.0'

dependencies:
  flutter:
    sdk: flutter
  fluent_ui: ^4.8.6          # Fluent UI组件库
  provider: ^6.1.1           # 状态管理
  shared_preferences: ^2.2.2  # 本地存储（存档）
  fl_chart: ^0.68.0          # 图表（可选）
  uuid: ^4.4.0               # UUID生成
  intl: ^0.19.0              # 国际化/日期格式

dev_dependencies:
  flutter_test:
    sdk: flutter
  flutter_lints: ^4.0.0

flutter:
  uses-material-design: true
```

---

## 九、构建说明

### 9.1 开发环境

```bash
# 安装依赖
flutter pub get

# 运行开发版本
flutter run -d chrome      # Web
flutter run -d android     # Android
flutter run -d windows     # Windows
```

### 9.2 构建生产版本

```bash
# Web
flutter build web --release

# Android APK
flutter build apk --release

# Windows
flutter build windows --release
```

### 9.3 GitHub Actions自动构建

```yaml
# .github/workflows/build.yml
name: Build Flutter App

on:
  push:
    branches: [main]

jobs:
  build-web:
    runs-on: ubuntu-latest
    steps:
      - uses: actions/checkout@v4
      - uses: subosito/flutter-action@v2
        with:
          flutter-version: '3.24.0'
      - run: flutter pub get
      - run: flutter build web --release
      - uses: actions/upload-artifact@v4
        with:
          name: web-build
          path: build/web/

  build-android:
    runs-on: ubuntu-latest
    steps:
      - uses: actions/checkout@v4
      - uses: actions/setup-java@v4
        with:
          java-version: '17'
      - uses: subosito/flutter-action@v2
        with:
          flutter-version: '3.24.0'
      - run: flutter pub get
      - run: flutter build apk --release
      - uses: actions/upload-artifact@v4
        with:
          name: android-apk
          path: build/app/outputs/flutter-apk/app-release.apk

  build-windows:
    runs-on: windows-latest
    steps:
      - uses: actions/checkout@v4
      - uses: subosito/flutter-action@v2
        with:
          flutter-version: '3.24.0'
      - run: flutter pub get
      - run: flutter build windows --release
      - uses: actions/upload-artifact@v4
        with:
          name: windows-build
          path: build/windows/x64/runner/Release/
```

---

## 十、存档系统

### 10.1 存档数据结构

```dart
class SaveData {
  final String playerName;
  final String playerId;
  final double cash;
  final List<PositionData> positions;
  final int gameDay;
  final int gameTime;
  final String gameMode;
  final String difficulty;
  final DateTime saveTime;
  final SurvivalData? survival;
}

class PositionData {
  final String stockId;
  final int shares;
  final double averageCost;
}
```

### 10.2 存档管理

```dart
// 保存游戏
Future<void> saveGame(int slot) async {
  final prefs = await SharedPreferences.getInstance();
  final saveData = SaveData(
    playerName: state.playerName,
    cash: state.cash,
    positions: state.positions.map((p) => PositionData(...)).toList(),
    gameDay: state.gameDay,
    ...
  );
  await prefs.setString('save_$slot', jsonEncode(saveData.toJson()));
}

// 加载游戏
Future<void> loadGame(int slot) async {
  final prefs = await SharedPreferences.getInstance();
  final json = prefs.getString('save_$slot');
  if (json != null) {
    final saveData = SaveData.fromJson(jsonDecode(json));
    // 恢复游戏状态
  }
}

// 获取存档列表
Future<List<SaveSlot>> getSaveSlots() async {
  final prefs = await SharedPreferences.getInstance();
  final slots = <SaveSlot>[];
  for (int i = 0; i < 100; i++) {
    final json = prefs.getString('save_$i');
    if (json != null) {
      slots.add(SaveSlot.fromJson(jsonDecode(json)));
    }
  }
  return slots;
}
```

---

## 十一、注意事项

### 11.1 性能优化

1. **股票价格更新**: 使用定时器每秒更新，避免过于频繁
2. **列表渲染**: 使用ListView.builder进行懒加载
3. **状态管理**: 只在必要时调用notifyListeners()

### 11.2 用户体验

1. **涨跌颜色**: 使用中国股市习惯（红涨绿跌）
2. **交易确认**: 大额交易时显示确认对话框
3. **错误提示**: 资金不足、持仓不足时显示友好提示

### 11.3 数据持久化

1. **自动保存**: 每隔5分钟自动保存
2. **退出保存**: 退出游戏时自动保存
3. **多存档**: 支持100个存档槽位

---

## 十二、扩展功能（可选）

### 12.1 技术指标

- MA均线
- MACD
- KDJ
- RSI

### 12.2 成就系统

- 首次盈利
- 翻倍收益
- 连续盈利天数
- 完美交易

### 12.3 排行榜

- 本地排行榜
- 在线排行榜（需要后端）

### 12.4 更多股票

- 港股
- 美股
- 基金

---

## 十三、联系方式

如有问题，请联系项目负责人。

---

**文档版本**: 1.0
**最后更新**: 2024年
