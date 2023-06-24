import '../../pigeon/api.dart';
import '../../shared/core/date/app_date.dart';

class SearchStocksVM implements FlutterStocksApi {
  final hostApi = HostStocksApi();
  List<StockChartData> stockChartData = [];
  List<Stock> stocks = [];
  DateTime? startDate;
  String symbol = 'TSLA';

  SearchStocksVM() {
    FlutterStocksApi.setup(this);
  }

  void loadChartData() async {
    final response = await hostApi.loadStockChart(
        symbol, AppDate.format(startDate ?? DateTime.now()));
    stockChartData = response.nonNulls.toList();
  }

  void loadStocks() async {
    final response = await hostApi.loadStocks();
    stocks = response.nonNulls.toList();
  }
}
