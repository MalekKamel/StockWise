import '../../pigeon/api.dart';
import '../../shared/core/date/app_date.dart';
import '../../shared/data/model/stock/stock_data.dart';

class ProfileVM implements FlutterStocksApi {
  final hostApi = HostStocksApi();
  List<Stock> stocks = [];
  StockProfileData? stockData;

  ProfileVM() {
    FlutterStocksApi.setup(this);
  }

  Future<void> loadStocks() async {
    final response = await hostApi.loadStocks();
    stocks = response.nonNulls.toList();
    stockData = StockProfileData.from(stocks);
  }
}
