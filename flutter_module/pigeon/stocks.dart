import 'package:pigeon/pigeon.dart';

class Stock {
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

  Stock(
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
  void showStock(List<Stock> stocks);
}

@HostApi()
abstract class HostStocksApi {
  void loadStocks(String symbol, String date);
}