import '../../../../pigeon/api.dart';

class StockProfileData {
  final double overallPL;
  final double overallPLPercent;
  final double todayPl;
  final double todayPlPercent;
  final List<StockItemData> stocks;

  StockProfileData({
    required this.overallPL,
    required this.overallPLPercent,
    required this.todayPl,
    required this.todayPlPercent,
    required this.stocks,
  });

  static StockProfileData from(List<Stock> stock) {
    final items = stock.map((stock) => StockItemData.from(stock)).toList();

    final allInvestedAmount = items
        .map((e) => e.totalInvestedAmount)
        .reduce((value, element) => value + element);

    final allCurrentValues = items
        .map((e) => e.currentValue)
        .reduce((value, element) => value + element);

    final overallPL = allCurrentValues - allInvestedAmount;
    final overallPLPercent = (overallPL / allInvestedAmount) * 100;

    final todayPl = items
        .map((e) => e.pl)
        .reduce((value, element) => value + element);
    final todayPlPercent = (todayPl / allInvestedAmount) * 100;

    return StockProfileData(
      overallPL: overallPL,
      overallPLPercent: overallPLPercent,
      todayPl: todayPl,
      todayPlPercent: todayPlPercent,
      stocks: items,
    );
  }
}

class StockItemData {
  final String name;

  final double totalInvestedAmount;
  final double averagePrice;
  final double totalQuantity;
  final double lastTradedPrice;
  final double currentValue;
  final double pl;

  StockItemData({
    required this.name,
    required this.totalInvestedAmount,
    required this.averagePrice,
    required this.totalQuantity,
    required this.lastTradedPrice,
    required this.currentValue,
    required this.pl,
  });

  static StockItemData from(Stock stock) {
    final totalInvestedAmount = stock.quantity * stock.avgPrice;
    final quantity = stock.quantity;
    final lastTradedPrice = stock.ltp;
    final currentValue = quantity * lastTradedPrice;
    final pl = currentValue - totalInvestedAmount;
    final avgPrice = stock.avgPrice;

    return StockItemData(
      name: stock.companyName,
      totalInvestedAmount: totalInvestedAmount,
      averagePrice: avgPrice,
      totalQuantity: stock.quantity,
      lastTradedPrice: lastTradedPrice,
      currentValue: currentValue,
      pl: pl,
    );
  }
}
