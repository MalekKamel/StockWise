import 'package:flutter/material.dart' hide DatePickerTheme;
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:yahoo_finance_data_reader/yahoo_finance_data_reader.dart';

class SearchStockScreen extends StatefulWidget {
  const SearchStockScreen({super.key});

  @override
  State<SearchStockScreen> createState() => _SearchStockScreenState();
}

class _SearchStockScreenState extends State<SearchStockScreen> {
  final TextEditingController controller = TextEditingController(
    text: 'GOOG',
  );
  late Future<List<YahooFinanceCandleData>> future;
  DateTime? startDate;

  @override
  void initState() {
    super.initState();
    load();
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
          load();
        },
        color: Theme.of(context).primaryColor,
        textColor: Colors.white,
        child: const Text('Load'),
      ),
    );
  }

  Widget _chartView() {
    return Expanded(
      child: FutureBuilder(
        future: future,
        builder: (BuildContext context,
            AsyncSnapshot<List<YahooFinanceCandleData>> snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            if (snapshot.data == null) {
              return const Text('No data');
            }

            return _linearChartView(snapshot.data ?? []);
          } else {
            return const Center(
              child: SizedBox(
                height: 50,
                width: 50,
                child: CircularProgressIndicator(),
              ),
            );
          }
        },
      ),
    );
  }

  Widget _linearChartView(List<YahooFinanceCandleData> list) {
    return SfCartesianChart(
      primaryXAxis: DateTimeAxis(),
      series: <LineSeries<YahooFinanceCandleData, DateTime>>[
        LineSeries<YahooFinanceCandleData, DateTime>(
          dataSource: list,
          xValueMapper: (YahooFinanceCandleData data, _) => data.date,
          yValueMapper: (YahooFinanceCandleData data, _) => data.close,
        ),
      ],
    );
  }

  void load() async {
    future = YahooFinanceService().getTickerData(
      controller.text,
      useCache: false,
      startDate: startDate ??
          DateTime(
            DateTime.now().year,
            DateTime.now().month,
            DateTime.now().day,
          ),
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
}
