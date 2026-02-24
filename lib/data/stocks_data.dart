import '../models/stock.dart';

final List<Stock> INITIAL_STOCKS = [
  // 银行股
  Stock(id: '1', code: '600000', name: '浦发银行', industry: '银行', basePrice: 10.5, currentPrice: 10.5, volatility: 0.02, description: '全国性股份制商业银行'),
  Stock(id: '2', code: '600036', name: '招商银行', industry: '银行', basePrice: 35.8, currentPrice: 35.8, volatility: 0.025, description: '中国领先的零售银行'),
  Stock(id: '3', code: '601318', name: '中国平安', industry: '保险', basePrice: 48.5, currentPrice: 48.5, volatility: 0.02, description: '综合金融服务集团'),
  Stock(id: '4', code: '000001', name: '平安银行', industry: '银行', basePrice: 12.8, currentPrice: 12.8, volatility: 0.022, description: '平安集团旗下银行'),
  
  // 白酒股
  Stock(id: '5', code: '600519', name: '贵州茅台', industry: '白酒', basePrice: 1850.0, currentPrice: 1850.0, volatility: 0.03, description: '中国高端白酒龙头'),
  Stock(id: '6', code: '000858', name: '五粮液', industry: '白酒', basePrice: 168.5, currentPrice: 168.5, volatility: 0.028, description: '浓香型白酒代表'),
  Stock(id: '7', code: '000568', name: '泸州老窖', industry: '白酒', basePrice: 235.0, currentPrice: 235.0, volatility: 0.032, description: '国窖1573生产商'),
  
  // 家电股
  Stock(id: '8', code: '000333', name: '美的集团', industry: '家电', basePrice: 58.2, currentPrice: 58.2, volatility: 0.022, description: '全球家电龙头'),
  Stock(id: '9', code: '000651', name: '格力电器', industry: '家电', basePrice: 38.5, currentPrice: 38.5, volatility: 0.025, description: '空调行业龙头'),
  Stock(id: '10', code: '600690', name: '海尔智家', industry: '家电', basePrice: 25.8, currentPrice: 25.8, volatility: 0.02, description: '智能家居领军者'),
  
  // 医药股
  Stock(id: '11', code: '600276', name: '恒瑞医药', industry: '医药', basePrice: 45.8, currentPrice: 45.8, volatility: 0.035, description: '创新药龙头企业'),
  Stock(id: '12', code: '000538', name: '云南白药', industry: '医药', basePrice: 92.5, currentPrice: 92.5, volatility: 0.028, description: '中药龙头企业'),
  Stock(id: '13', code: '300760', name: '迈瑞医疗', industry: '医药', basePrice: 320.0, currentPrice: 320.0, volatility: 0.032, description: '医疗器械龙头', board: 'gem'),
  
  // 新能源股
  Stock(id: '14', code: '300750', name: '宁德时代', industry: '新能源', basePrice: 215.0, currentPrice: 215.0, volatility: 0.04, description: '全球动力电池龙头', board: 'gem'),
  Stock(id: '15', code: '002594', name: '比亚迪', industry: '新能源', basePrice: 268.0, currentPrice: 268.0, volatility: 0.038, description: '新能源汽车领军者'),
  Stock(id: '16', code: '601012', name: '隆基绿能', industry: '新能源', basePrice: 42.5, currentPrice: 42.5, volatility: 0.035, description: '光伏龙头'),
  
  // 科技股
  Stock(id: '17', code: '002415', name: '海康威视', industry: '科技', basePrice: 35.2, currentPrice: 35.2, volatility: 0.03, description: '安防监控龙头'),
  Stock(id: '18', code: '002475', name: '立讯精密', industry: '科技', basePrice: 32.8, currentPrice: 32.8, volatility: 0.032, description: '苹果供应链龙头'),
  Stock(id: '19', code: '600588', name: '用友网络', industry: '科技', basePrice: 28.5, currentPrice: 28.5, volatility: 0.028, description: '企业管理软件龙头'),
  
  // 汽车股
  Stock(id: '20', code: '600104', name: '上汽集团', industry: '汽车', basePrice: 18.5, currentPrice: 18.5, volatility: 0.022, description: '国内汽车龙头'),
  Stock(id: '21', code: '601238', name: '广汽集团', industry: '汽车', basePrice: 12.8, currentPrice: 12.8, volatility: 0.025, description: '华南汽车龙头'),
  
  // 地产股
  Stock(id: '22', code: '000002', name: '万科A', industry: '地产', basePrice: 15.8, currentPrice: 15.8, volatility: 0.035, description: '房地产龙头企业'),
  Stock(id: '23', code: '001979', name: '招商蛇口', industry: '地产', basePrice: 18.2, currentPrice: 18.2, volatility: 0.032, description: '园区开发龙头'),
  
  // 零售股
  Stock(id: '24', code: '601933', name: '永辉超市', industry: '零售', basePrice: 4.2, currentPrice: 4.2, volatility: 0.028, description: '生鲜超市龙头'),
  Stock(id: '25', code: '002024', name: '苏宁易购', industry: '零售', basePrice: 2.8, currentPrice: 2.8, volatility: 0.04, description: '家电零售'),
  
  // 传媒股
  Stock(id: '26', code: '300059', name: '东方财富', industry: '传媒', basePrice: 18.5, currentPrice: 18.5, volatility: 0.038, description: '互联网金融平台', board: 'gem'),
  Stock(id: '27', code: '603444', name: '吉比特', industry: '传媒', basePrice: 285.0, currentPrice: 285.0, volatility: 0.032, description: '游戏开发商'),
  
  // 化工股
  Stock(id: '28', code: '600309', name: '万华化学', industry: '化工', basePrice: 98.5, currentPrice: 98.5, volatility: 0.028, description: 'MDI龙头'),
  Stock(id: '29', code: '002648', name: '卫星化学', industry: '化工', basePrice: 18.2, currentPrice: 18.2, volatility: 0.032, description: '丙烯酸龙头'),
  
  // 电力股
  Stock(id: '30', code: '600900', name: '长江电力', industry: '电力', basePrice: 28.5, currentPrice: 28.5, volatility: 0.015, description: '水电龙头'),
];
