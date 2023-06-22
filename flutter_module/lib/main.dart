// Copyright 2019 The Flutter team. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'package:flutter/material.dart';
import 'package:flutter_module/search_screen.dart';

import 'api.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primaryColor: const Color(0xff3886e0),
        useMaterial3: true,
      ),
      home: const SearchStockScreen(),
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
