import 'package:pigeon/pigeon.dart';

class Stock {
  String? title;
}

@FlutterApi()
abstract class FlutterStocksApi {
  void showStocks(List<Stock> stocks);
}

@HostApi()
abstract class HostStocksApi {
  void loadStocks(Stock stock);
}

