import '../../pigeon/api.dart';
import '../../shared/core/date/app_date.dart';
import '../../shared/data/model/stock/stock_data.dart';

class SearchStocksVM implements FlutterStocksApi {
  final hostApi = HostStocksApi();
  List<StockChartData> stockChartData = [];
  DateTime? startDate;
  String symbol = 'TSLA';

  SearchStocksVM() {
    FlutterStocksApi.setup(this);
  }

  Future<void> loadChartData() async {
    final response = await hostApi.loadStockChart(
        symbol, AppDate.format(startDate ?? DateTime.now()));
    stockChartData = response.nonNulls.toList();
  }

}
