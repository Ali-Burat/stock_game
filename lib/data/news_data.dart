import '../models/news.dart';

final List<NewsTemplate> NEWS_TEMPLATES = [
  // 宏观经济
  NewsTemplate(title: '央行宣布降准', content: '中国人民银行决定下调存款准备金率0.5个百分点', category: NewsCategory.macro, importance: NewsImportance.major, industries: ['银行', '保险'], minEffect: 3, maxEffect: 8),
  NewsTemplate(title: 'GDP增速超预期', content: '国家统计局公布GDP增速超出市场预期', category: NewsCategory.macro, importance: NewsImportance.major, minEffect: 2, maxEffect: 6),
  NewsTemplate(title: 'CPI数据公布', content: '消费者物价指数同比上涨', category: NewsCategory.macro, importance: NewsImportance.normal, minEffect: -2, maxEffect: 3),
  
  // 行业动态
  NewsTemplate(title: '新能源汽车销量创新高', content: '新能源汽车月销量突破百万辆', category: NewsCategory.industry, importance: NewsImportance.major, industries: ['新能源', '汽车'], minEffect: 5, maxEffect: 12),
  NewsTemplate(title: '白酒行业提价潮', content: '多家白酒企业宣布提价', category: NewsCategory.industry, importance: NewsImportance.normal, industries: ['白酒'], minEffect: 3, maxEffect: 8),
  NewsTemplate(title: '医药集采结果公布', content: '新一轮药品集中采购结果出炉', category: NewsCategory.industry, importance: NewsImportance.major, industries: ['医药'], minEffect: -8, maxEffect: 3),
  NewsTemplate(title: '光伏装机量大增', content: '光伏新增装机容量同比增长', category: NewsCategory.industry, importance: NewsImportance.normal, industries: ['新能源'], minEffect: 2, maxEffect: 6),
  
  // 公司新闻
  NewsTemplate(title: '某公司发布新品', content: '公司召开新品发布会，推出创新产品', category: NewsCategory.company, importance: NewsImportance.normal, minEffect: -3, maxEffect: 5),
  NewsTemplate(title: '某公司业绩超预期', content: '公司公布季度业绩超出市场预期', category: NewsCategory.company, importance: NewsImportance.major, minEffect: 3, maxEffect: 10),
  NewsTemplate(title: '某公司高管变动', content: '公司宣布高管人事变动', category: NewsCategory.company, importance: NewsImportance.minor, minEffect: -3, maxEffect: 2),
  
  // 政策法规
  NewsTemplate(title: '房地产政策调整', content: '多地出台房地产调控新政策', category: NewsCategory.policy, importance: NewsImportance.major, industries: ['地产'], minEffect: -5, maxEffect: 5),
  NewsTemplate(title: '科技行业监管加强', content: '监管部门加强对科技行业监管', category: NewsCategory.policy, importance: NewsImportance.normal, industries: ['科技'], minEffect: -6, maxEffect: 2),
  NewsTemplate(title: '消费刺激政策出台', content: '政府出台消费刺激政策', category: NewsCategory.policy, importance: NewsImportance.normal, industries: ['零售', '家电'], minEffect: 2, maxEffect: 5),
  
  // 国际形势
  NewsTemplate(title: '美联储加息', content: '美联储宣布加息25个基点', category: NewsCategory.international, importance: NewsImportance.critical, minEffect: -5, maxEffect: 3),
  NewsTemplate(title: '国际贸易局势变化', content: '国际贸易谈判取得进展', category: NewsCategory.international, importance: NewsImportance.major, minEffect: -3, maxEffect: 5),
  NewsTemplate(title: '汇率波动', content: '人民币汇率出现较大波动', category: NewsCategory.international, importance: NewsImportance.normal, minEffect: -4, maxEffect: 4),
  
  // 市场情绪
  NewsTemplate(title: '市场情绪高涨', content: '投资者信心指数上升', category: NewsCategory.sentiment, importance: NewsImportance.normal, minEffect: 1, maxEffect: 4),
  NewsTemplate(title: '市场恐慌情绪蔓延', content: '投资者避险情绪上升', category: NewsCategory.sentiment, importance: NewsImportance.normal, minEffect: -4, maxEffect: -1),
  
  // 金融动态
  NewsTemplate(title: '北向资金大幅流入', content: '北向资金今日净流入超百亿', category: NewsCategory.finance, importance: NewsImportance.major, minEffect: 2, maxEffect: 5),
  NewsTemplate(title: '两融余额创新高', content: '融资融券余额突破新高', category: NewsCategory.finance, importance: NewsImportance.normal, minEffect: 1, maxEffect: 3),
];
