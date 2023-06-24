import 'package:flutter/material.dart' hide DatePickerTheme;
import 'package:flutter_module/screens/profile_/profile_vm.dart';

import '../../shared/data/model/stock/stock_data.dart';

class ProfileScreen extends StatefulWidget {
  ProfileScreen({super.key, required this.vm});

  ProfileVM vm;

  @override
  State<ProfileScreen> createState() => _SearchStockScreenState();

  static ProfileScreen build() {
    final vm = ProfileVM();
    return ProfileScreen(vm: vm);
  }
}

class _SearchStockScreenState extends State<ProfileScreen> {
  @override
  void initState() {
    super.initState();
    _loadStocks();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Profile'),
      ),
      body: _bodyView(),
    );
  }

  Widget _bodyView() {
    if (widget.vm.stockData == null) {
      return const SizedBox.shrink();
    }
    return _contentView(widget.vm.stockData!);
  }

  Widget _contentView(StockProfileData data) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Overall P/L: ${data.overallPL} (${data.overallPLPercent}%)'),
            Text('Today P/L: ${data.todayPl} (${data.todayPlPercent}%)'),
            const SizedBox(height: 16),
            const Text('Stocks:',
                style: TextStyle(fontWeight: FontWeight.bold)),
            ListView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: data.stocks.length,
              itemBuilder: (BuildContext context, int index) {
                final stock = data.stocks[index];
                return ListTile(
                  title: Text(stock.name),
                  subtitle: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                          'Total Invested Amount: ${stock.totalInvestedAmount}'),
                      Text('Average Price: ${stock.averagePrice}'),
                      Text('Total Quantity: ${stock.totalQuantity}'),
                      Text('Last Traded Price: ${stock.lastTradedPrice}'),
                      Text('Current Value: ${stock.currentValue}'),
                      Text('P/L: ${stock.pl}'),
                    ],
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }

  void _loadStocks() async {
    await widget.vm.loadStocks();
    setState(() {});
  }
}
