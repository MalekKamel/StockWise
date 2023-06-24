import 'package:pigeon/pigeon.dart';

class Stock {
  final String symbol;
  final String companyName;
  final double avgPrice;
  final double quantity;
  final double ltp;

  Stock({
    required this.symbol,
    required this.companyName,
    required this.avgPrice,
    required this.quantity,
    required this.ltp,
  });
}

class StockChartData {
  final String date;

  /// Open price
  final double open;

  /// High price
  final double high;

  /// Low price
  final double low;

  /// Close price
  final double close;

  /// Volume
  final int volume;

  /// Adjusted close price, by splits and dividends
  final double adjClose;

  StockChartData(
    this.date,
    this.open,
    this.high,
    this.low,
    this.close,
    this.volume,
    this.adjClose,
  );
}

@FlutterApi()
abstract class FlutterStocksApi {
}

@HostApi()
abstract class HostStocksApi {
  @async
  List<StockChartData> loadStockChart(String symbol, String date);

  @async
  List<Stock> loadStocks();
}
