import 'package:flutter/material.dart' hide DatePickerTheme;
import 'package:flutter_module/screens/search/search_stocks_vm.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

import '../../pigeon/api.dart';
import '../../shared/core/localization/localizations.dart';

class SearchStockScreen extends StatefulWidget {
  SearchStockScreen({super.key, required this.vm});

  SearchStocksVM vm;

  @override
  State<SearchStockScreen> createState() => _SearchStockScreenState();

  static SearchStockScreen build() {
    final vm = SearchStocksVM();
    return SearchStockScreen(vm: vm);
  }
}

class _SearchStockScreenState extends State<SearchStockScreen> {
  final controller = TextEditingController(
    text: 'TSLA',
  );

  @override
  void initState() {
    super.initState();
    _loadChartData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(localizations.appName),
      ),
      body: _bodyView(),
    );
  }

  Widget _bodyView() {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            _searchTextField(),
            _searchButton(),
            _chartView(),
          ],
        ),
      ),
    );
  }

  Widget _searchTextField() {
    return TextField(
      controller: controller,
      onChanged: (text) {
        widget.vm.symbol = text;
      },
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
            widget.vm.startDate = selectedDate;
          });
          _loadChartData();
        },
        color: Theme.of(context).primaryColor,
        textColor: Colors.white,
        child: Text(localizations.search),
      ),
    );
  }

  Widget _chartView() {
    return SfCartesianChart(
      primaryXAxis: DateTimeAxis(),
      series: <LineSeries<StockChartData, DateTime>>[
        LineSeries<StockChartData, DateTime>(
          dataSource: widget.vm.stockChartData,
          xValueMapper: (StockChartData data, _) => DateTime.parse(data.date),
          yValueMapper: (StockChartData data, _) => data.close,
        ),
      ],
    );
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

  void _loadChartData() async {
    await widget.vm.loadChartData();
    setState(() {});
  }
}
