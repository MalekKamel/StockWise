import 'package:flutter/material.dart' hide DatePickerTheme;
import 'package:flutter_module/shared/core/date/app_date.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

import '../../pigeon/api.dart';

class SearchStockScreen extends StatefulWidget {
  SearchStockScreen({super.key});

  late HostStocksApi hostApi;
  List<StockChartData> stockChartData = [];
  List<Stock> stocks = [];

  @override
  State<SearchStockScreen> createState() => _SearchStockScreenState();
}

class _SearchStockScreenState extends State<SearchStockScreen>
    implements FlutterStocksApi {
  final TextEditingController controller = TextEditingController(
    text: 'TSLA',
  );
  DateTime? startDate;

  @override
  void initState() {
    super.initState();
    _setup();
    loadStocks();
  }

  _setup() {
    widget.hostApi = HostStocksApi();
    FlutterStocksApi.setup(this);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('StockWise'),
      ),
      body: _bodyView(),
    );
  }

  Widget _bodyView() {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        children: [
          _searchTextField(),
          _searchButton(),
          _chartView(),
        ],
      ),
    );
  }

  Widget _searchTextField() {
    return TextField(
      controller: controller,
    );
  }

  Widget _searchButton() {
    return Align(
      alignment: Alignment.centerRight,
      child: MaterialButton(
        onPressed: () async {
          // TODO: validate the date is not after end date
          final selectedDate = await _selectDate(context);
          if (selectedDate == null) {
            return;
          }
          setState(() {
            startDate = selectedDate;
          });
          loadChartData();
        },
        color: Theme.of(context).primaryColor,
        textColor: Colors.white,
        child: const Text('Load'),
      ),
    );
  }

  Widget _chartView() {
    return Expanded(
        child: SfCartesianChart(
      primaryXAxis: DateTimeAxis(),
      series: <LineSeries<StockChartData, DateTime>>[
        LineSeries<StockChartData, DateTime>(
          dataSource: widget.stockChartData,
          xValueMapper: (StockChartData data, _) => DateTime.parse(data.date),
          yValueMapper: (StockChartData data, _) => data.close,
        ),
      ],
    ));
  }

  void loadChartData() async {
    final response = await widget.hostApi.loadStockChart(
        controller.text, AppDate.format(startDate ?? DateTime.now()));
    widget.stockChartData = response.nonNulls.toList();
  }

  void loadStocks() async {
    final response = await widget.hostApi.loadStocks();
    widget.stocks = response.nonNulls.toList();
    setState(() {});
  }

  Future<DateTime?> _selectDate(BuildContext context) async {
    final DateTime currentDate = DateTime.now();
    final DateTime initialDate =
        DateTime(currentDate.year, currentDate.month, currentDate.day);
    return showDatePicker(
      context: context,
      initialDate: initialDate,
      firstDate: DateTime(2015, 8),
      lastDate: DateTime(2100),
    );
  }

}
