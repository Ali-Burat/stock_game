import '../models/player.dart';
import '../models/survival.dart';

// 行业列表
const List<String> INDUSTRIES = [
  '银行', '白酒', '家电', '医药', '新能源',
  '保险', '科技', '汽车', '地产', '零售',
  '传媒', '化工', '钢铁', '煤炭', '电力',
];

// 玩家身份
final List<Player> PLAYER_IDENTITIES = [
  Player(id: 'student', name: '大学生', icon: '🎓', description: '刚入市的年轻人', initialCash: 10000, stressResistance: 60, workEfficiency: 70, investmentSense: 40),
  Player(id: 'worker', name: '上班族', icon: '👔', description: '有稳定收入的白领', initialCash: 50000, stressResistance: 50, workEfficiency: 80, investmentSense: 50),
  Player(id: 'entrepreneur', name: '创业者', icon: '💼', description: '风险偏好高', initialCash: 200000, stressResistance: 80, workEfficiency: 60, investmentSense: 60),
  Player(id: 'retiree', name: '退休人员', icon: '👴', description: '追求稳定收益', initialCash: 100000, stressResistance: 30, workEfficiency: 40, investmentSense: 70),
  Player(id: 'trader', name: '职业交易员', icon: '📊', description: '专业技术分析', initialCash: 100000, stressResistance: 90, workEfficiency: 50, investmentSense: 90),
  Player(id: 'investor', name: '价值投资者', icon: '💰', description: '长期投资', initialCash: 500000, stressResistance: 70, workEfficiency: 30, investmentSense: 80),
  Player(id: 'housewife', name: '家庭主妇', icon: '👩', description: '精打细算', initialCash: 30000, stressResistance: 40, workEfficiency: 60, investmentSense: 60),
  Player(id: 'programmer', name: '程序员', icon: '💻', description: '逻辑思维强', initialCash: 80000, stressResistance: 60, workEfficiency: 90, investmentSense: 50),
  Player(id: 'doctor', name: '医生', icon: '👨‍⚕️', description: '收入高但繁忙', initialCash: 150000, stressResistance: 50, workEfficiency: 40, investmentSense: 40),
  Player(id: 'custom', name: '自定义', icon: '⚙️', description: '自定义属性', initialCash: 50000, stressResistance: 50, workEfficiency: 50, investmentSense: 50),
];

// 商店物品
final List<ShopItem> SHOP_ITEMS = [
  ShopItem(id: 'bread', name: '面包', icon: '🍞', description: '普通面包', price: 5, category: 'food', effects: {'hunger': 20}, shelfLife: 7),
  ShopItem(id: 'noodle', name: '方便面', icon: '🍜', description: '快速一餐', price: 8, category: 'food', effects: {'hunger': 30, 'thirst': -10}, shelfLife: 30),
  ShopItem(id: 'rice', name: '便当', icon: '🍱', description: '营养便当', price: 25, category: 'food', effects: {'hunger': 50, 'mood': 5}, shelfLife: 2),
  ShopItem(id: 'water', name: '矿泉水', icon: '💧', description: '解渴', price: 2, category: 'drink', effects: {'thirst': 20}, shelfLife: 365),
  ShopItem(id: 'cola', name: '可乐', icon: '🥤', description: '快乐水', price: 5, category: 'drink', effects: {'thirst': 30, 'mood': 10}, shelfLife: 365),
  ShopItem(id: 'coffee', name: '咖啡', icon: '☕', description: '提神', price: 15, category: 'drink', effects: {'thirst': 10, 'mood': 15}),
  ShopItem(id: 'medicine', name: '感冒药', icon: '💊', description: '治疗感冒', price: 20, category: 'medicine', effects: {'health': 30}, shelfLife: 365),
  ShopItem(id: 'vitamin', name: '维生素', icon: '🍊', description: '补充营养', price: 30, category: 'medicine', effects: {'health': 20, 'mood': 5}, shelfLife: 365),
];

// 工作
final List<Job> JOBS = [
  Job(id: 'delivery', name: '外卖配送', icon: '🛵', description: '送外卖', hourlyPay: 20, energyCost: 15, moodEffect: -5, requiredHealth: 30, workHours: [8,9,10,11,12,13,14,15,16,17,18,19,20,21,22]),
  Job(id: 'tutor', name: '家教', icon: '📖', description: '辅导功课', hourlyPay: 50, energyCost: 10, moodEffect: 5, requiredHealth: 40, workHours: [18,19,20,21]),
  Job(id: 'freelance', name: '自由职业', icon: '💻', description: '接项目', hourlyPay: 80, energyCost: 12, moodEffect: 0, requiredHealth: 50, workHours: [9,10,11,12,13,14,15,16,17,18,19,20,21,22]),
];

// 娱乐
final List<Entertainment> ENTERTAINMENTS = [
  Entertainment(id: 'tv', name: '看电视', icon: '📺', description: '放松', cost: 0, moodBoost: 10, timeCost: 2),
  Entertainment(id: 'exercise', name: '运动', icon: '🏃', description: '跑步', cost: 0, moodBoost: 15, timeCost: 1),
  Entertainment(id: 'gaming', name: '玩游戏', icon: '🎮', description: '打游戏', cost: 0, moodBoost: 20, timeCost: 3),
  Entertainment(id: 'shopping', name: '逛街', icon: '🛍️', description: '购物', cost: 50, moodBoost: 25, timeCost: 3),
];

const int MAX_SAVE_SLOTS = 100;
