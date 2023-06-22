// Copyright 2019 The Flutter team. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'package:flutter/material.dart';
import 'package:flutter_module/search_screen.dart';
import 'package:yahoo_finance_data_reader/yahoo_finance_data_reader.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'api.dart';


void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        primaryColor: const Color(0xff6200ee),
        useMaterial3: true,
      ),
      home: const DTOSearch(),
    );
  }
}

typedef StockReceived = void Function(List<Stock?> stock);

class FlutterStockApiHandler extends FlutterStocksApi {
  FlutterStockApiHandler(this.callback);

  final StockReceived callback;

  @override
  void showStocks(List<Stock?> stocks) {
    callback(stocks);
  }
}

class StocksScreen extends StatefulWidget {
  StocksScreen({super.key, this.hostApi, this.flutterApi});

  // These are the outgoing and incoming APIs that are here for injection for
  // tests.
  final HostStocksApi? hostApi;
  final FlutterStocksApi? flutterApi;
  final List<Stock?> stocks = [];

  @override
  State<StocksScreen> createState() => _StocksScreenState();
}

class _StocksScreenState extends State<StocksScreen> {
  List<Stock?> stocks = [];

  late HostStocksApi hostApi;

  @override
  void initState() {
    super.initState();
    stocks = widget.stocks;
    hostApi = widget.hostApi ?? HostStocksApi();
    FlutterStocksApi.setup(FlutterStockApiHandler((stocks) {
      setState(() {
        this.stocks = stocks;
      });
    }));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Stock Details'),
        leading: IconButton(
          icon: const Icon(Icons.clear),
          onPressed: () {},
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.check),
            // Pressing save sends the updated stock to the platform.
            onPressed: () {},
          ),
        ],
      ),
      body: const Text(''),
    );
  }
}

class BottomSelectionWidget extends StatefulWidget {
  const BottomSelectionWidget({super.key});

  @override
  State<BottomSelectionWidget> createState() => _BottomSelectionWidgetState();
}

class _BottomSelectionWidgetState extends State<BottomSelectionWidget> {
  int _selectedIndex = 0;
  final PageController _pageController = PageController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Yahoo Finance Example'),
      ),
      body: Container(
        padding: const EdgeInsets.all(20.0),
        child: PageView(
          physics: const NeverScrollableScrollPhysics(),
          controller: _pageController,
          onPageChanged: _onItemSelected,
          children: const [
            YahooFinanceServiceWidget(),
            DTOSearch(),
            RawSearch(),
          ],
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        onTap: _onItemSelected,
        currentIndex: _selectedIndex,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.storage),
            label: 'Service',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.format_list_numbered),
            label: 'DTO',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.raw_on),
            label: 'Raw',
          ),
        ],
      ),
    );
  }

  void _onItemSelected(int index) {
    setState(() {
      _pageController.animateToPage(index,
          duration: const Duration(milliseconds: 200), curve: Curves.easeOut);
      _selectedIndex = index;
    });
    debugPrint(index.toString());
  }
}

class RawSearch extends StatefulWidget {
  const RawSearch({
    super.key,
  });

  @override
  State<RawSearch> createState() => _RawSearchState();
}

class _RawSearchState extends State<RawSearch> {
  @override
  Widget build(BuildContext context) {
    String ticker = 'GOOG';
    YahooFinanceDailyReader yahooFinanceDataReader =
    const YahooFinanceDailyReader();

    Future<Map<String, dynamic>> future =
    yahooFinanceDataReader.getDailyData(ticker);

    return FutureBuilder(
      future: future,
      builder:
          (BuildContext context, AsyncSnapshot<Map<String, dynamic>> snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          if (snapshot.data == null) {
            return const Text('No data');
          }

          Map<String, dynamic> historicalData = snapshot.data!;
          return SingleChildScrollView(
            child: Text(historicalData.toString()),
          );
        } else if (snapshot.hasError) {
          return Text('Error ${snapshot.error}');
        }

        return const Center(
          child: SizedBox(
            height: 50,
            width: 50,
            child: CircularProgressIndicator(),
          ),
        );
      },
    );
  }

  String generateDescription(DateTime date, Map<String, dynamic> day) {
    return '''$date
open: ${day['open']}
close: ${day['close']}
high: ${day['high']}
low: ${day['low']}
adjclose: ${day['adjclose']}
''';
  }
}

/*
class StockChartScreen extends StatefulWidget {
  @override
  _StockChartState createState() => _StockChartState();
}

class _StockChartState extends State<StockChartScreen> {
  String _stockSymbol = 'AAPL'; // Default stock symbol

  // List to store stock data for chart
  List<StockChart> _prices = [];
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Stock Chart',
      home: Scaffold(
        appBar: AppBar(
          title: Text('Stock Chart'),
        ),
        body: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: TextField(
                decoration: const InputDecoration(
                  labelText: 'Enter stock symbol',
                ),
                onChanged: (value) {
                  setState(() {
                    _stockSymbol = value.toUpperCase();
                  });
                },
              ),
            ),
            ElevatedButton(
              child: Text('Fetch Data'),
              onPressed: () async {
                await _fetchStockData();
              },
            ),
            Expanded(
              child: SfCartesianChart(
                title: ChartTitle(text: 'Stock Chart'),
                legend: Legend(isVisible: false),
                series: <ChartSeries<StockChart, DateTime>>[
                  CandleSeries<StockChart, DateTime>(
                      dataSource: chartData,
                      xValueMapper: (StockChart data, _) => data.x,
                      openValueMapper: (StockChart data, _) => data.open,
                      closeValueMapper: (StockChart data, _) =>
                      data.close,
                      highValueMapper: (StockChart data, _) => data.high,
                      lowValueMapper: (StockChart data, _) => data.low),
                  ColumnSeries<StockChart, DateTime>(
                      dataSource: chartData,
                      xValueMapper: (StockChart data, _) => data.x,
                      yValueMapper: (StockChart data, _) => data.volume)
                ],
                primaryXAxis: DateTimeAxis(),
                primaryYAxis: NumericAxis(),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _fetchStockData() async {
    var yfin = YahooFin();
    StockHistory hist = yfin.initStockHistory(ticker: "GOOG");
    StockChart chart = await yfin.getChartQuotes(
        stockHistory: hist,
        interval: StockInterval.oneDay,
        period: StockRange.fiveYear);
    chart.chartQuotes?.low?[0];
    setState(() {
      _prices = chart;
    });
  }
}

class StockData {
  final DateTime time;
  final double close;

  StockData(this.time, this.close);
}
*/
