import 'package:flutter/material.dart' hide DatePickerTheme;
import 'package:flutter_module/screens/profile_/profile_vm.dart';
import 'package:flutter_module/shared/core/localization/localizations.dart';

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
            Text(
                '${localizations.overallPl}: ${data.overallPL} (${data.overallPLPercent}%)'),
            Text(
                '${localizations.todayPl}: ${data.todayPl} (${data.todayPlPercent}%)'),
            const SizedBox(height: 16),
            Text(localizations.stocks,
                style: const TextStyle(fontWeight: FontWeight.bold)),
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
                          '${localizations.totalInvestedAmount}: ${stock.totalInvestedAmount}'),
                      Text(
                          '${localizations.averagePrice}: ${stock.averagePrice}'),
                      Text(
                          '${localizations.totalQuantity}: ${stock.totalQuantity}'),
                      Text(
                          '${localizations.lastTradedPrice}: ${stock.lastTradedPrice}'),
                      Text(
                          '${localizations.currentValue}: ${stock.currentValue}'),
                      Text('${localizations.pl}: ${stock.pl}'),
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
