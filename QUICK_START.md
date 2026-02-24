# 炒股人生 - 快速开始指南

## 项目概述
这是一个Flutter股市模拟游戏，支持Android、Windows和Web平台。

## 核心功能
- 30只股票，15个行业
- 涨跌停机制
- 大盘指数
- 新闻系统
- 市场情绪
- 生存模式
- 10种玩家身份

## 技术栈
- Flutter 3.24+
- Dart 3.5+
- Fluent UI
- Provider

## 快速开始

### 1. 安装依赖
```bash
flutter pub get
```

### 2. 运行项目
```bash
flutter run -d chrome    # Web
flutter run -d android   # Android
flutter run -d windows   # Windows
```

### 3. 构建发布版本
```bash
flutter build web --release      # Web
flutter build apk --release      # Android APK
flutter build windows --release  # Windows EXE
```

## 项目结构
```
lib/
├── main.dart           # 入口
├── models/             # 数据模型
├── providers/          # 状态管理
├── screens/            # 页面
├── widgets/            # 组件
├── constants/          # 常量
└── data/               # 数据
```

## 详细文档
请查看 PROJECT_SPEC.md 获取完整的项目文档。

## GitHub仓库
https://github.com/Ali-Burat/stock_game
