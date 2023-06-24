import 'package:flutter/material.dart' hide DatePickerTheme;
import 'package:flutter_module/shared/core/date/app_date.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

import '../../pigeon/api.dart';
import '../../main.dart';

class SearchStockScreen extends StatefulWidget {
  SearchStockScreen({super.key});

  late HostStocksApi hostApi;
  List<Stock> stocks = [];

  @override
  State<SearchStockScreen> createState() => _SearchStockScreenState();
}

class _SearchStockScreenState extends State<SearchStockScreen> {
  final TextEditingController controller = TextEditingController(
    text: 'GOOG',
  );
  DateTime? startDate;

  @override
  void initState() {
    super.initState();
    _setup();
  }

  _setup() {
    widget.hostApi = HostStocksApi();
    FlutterStocksApi.setup(FlutterStockApiHandler((stocks) {
      setState(() {
        widget.stocks = stocks.nonNulls.toList();
      });
    }));
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
      series: <LineSeries<Stock, DateTime>>[
        LineSeries<Stock, DateTime>(
          dataSource: widget.stocks,
          xValueMapper: (Stock data, _) => DateTime.parse(data.date),
          yValueMapper: (Stock data, _) => data.close,
        ),
      ],
    ));
  }

  void loadChartData() async {
    widget.hostApi.loadStocks(
        controller.text, AppDate.format(startDate ?? DateTime.now()));
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
