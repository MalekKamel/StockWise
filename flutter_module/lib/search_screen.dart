import 'package:flutter/material.dart' hide DatePickerTheme;
import 'package:intl/intl.dart';
import 'package:yahoo_finance_data_reader/yahoo_finance_data_reader.dart';

class DTOSearch extends StatefulWidget {
  const DTOSearch({super.key});

  @override
  State<DTOSearch> createState() => _DTOSearchState();
}

class _DTOSearchState extends State<DTOSearch> {
  final TextEditingController controller = TextEditingController(
    text: 'GOOG',
  );
  late Future<YahooFinanceResponse> future;

  @override
  void initState() {
    super.initState();
    load();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          const Text('Ticker from yahoo finance'),
          TextField(
            controller: controller,
          ),
          MaterialButton(
            onPressed: load,
            child: const Text('Load'),
            color: Theme.of(context).primaryColor,
          ),
          Expanded(
            child: FutureBuilder(
              future: future,
              builder: (BuildContext context,
                  AsyncSnapshot<YahooFinanceResponse> snapshot) {
                if (snapshot.connectionState == ConnectionState.done) {
                  if (snapshot.data == null) {
                    return const Text('No data');
                  }

                  YahooFinanceResponse response = snapshot.data!;
                  return ListView.builder(
                      itemCount: response.candlesData.length,
                      itemBuilder: (BuildContext context, int index) {
                        YahooFinanceCandleData candle =
                            response.candlesData[index];

                        return _CandleCard(candle);
                      });
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
          ),
        ],
      ),
    );
  }

  void load() {
    future = const YahooFinanceDailyReader().getDailyDTOs(controller.text);
    setState(() {});
  }
}

class _CandleCard extends StatelessWidget {
  final YahooFinanceCandleData candle;

  const _CandleCard(this.candle);

  @override
  Widget build(BuildContext context) {
    final String date = candle.date.toIso8601String().split('T').first;

    return Card(
      child: Container(
        margin: const EdgeInsets.all(10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Text(date),
              ],
            ),
            const SizedBox(
              height: 10,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Text('open: ${candle.open.toStringAsFixed(2)}'),
                Text('close: ${candle.close.toStringAsFixed(2)}'),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Text('low: ${candle.low.toStringAsFixed(2)}'),
                Text('high: ${candle.high.toStringAsFixed(2)}'),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class YahooFinanceServiceWidget extends StatefulWidget {
  const YahooFinanceServiceWidget({super.key});

  @override
  State<YahooFinanceServiceWidget> createState() =>
      _YahooFinanceServiceWidgetState();
}

class _YahooFinanceServiceWidgetState extends State<YahooFinanceServiceWidget> {
  TextEditingController controller = TextEditingController(
    text: 'GOOG',
  );
  List<YahooFinanceCandleData> pricesList = [];
  List? cachedPrices;
  bool loading = true;
  DateTime? startDate;

  @override
  void initState() {
    super.initState();
    load();
  }

  void load() async {
    loading = false;
    setState(() {});

    // Get response for the first time
    pricesList = await YahooFinanceService()
        .getTickerData(controller.text, startDate: startDate);

    // Check if the cache was created
    cachedPrices = await YahooFinanceDAO().getAllDailyData(
      controller.text,
    );
    loading = false;
    setState(() {});
  }

  void deleteCache() async {
    loading = true;
    setState(() {});

    await YahooFinanceDAO().removeDailyData(controller.text);
    cachedPrices = await YahooFinanceDAO().getAllDailyData(controller.text);
    loading = false;
    setState(() {});
  }

  void refresh() async {
    cachedPrices = await YahooFinanceDAO().getAllDailyData(controller.text);
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    if (loading) {
      return const Center(
        child: CircularProgressIndicator(),
      );
    }

    return ListView.builder(
      itemCount: pricesList.length + 1,
      itemBuilder: (context, i) {
        if (i == 0) {
          final List<String> tickerOptions = [
            'GOOG',
            'ES=F, GC=F',
            'GOOG, AAPL',
          ];
          return Card(
            child: Container(
              margin: const EdgeInsets.all(10),
              child: Column(
                children: [
                  SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      children: tickerOptions
                          .map(
                            (option) => Container(
                              margin: const EdgeInsets.all(5),
                              child: MaterialButton(
                                child: Text(option),
                                onPressed: controller.text == option
                                    ? null
                                    : () => setState(() {
                                          controller.text = option;
                                        }),
                                color: Colors.amberAccent,
                              ),
                            ),
                          )
                          .toList(),
                    ),
                  ),
                  Row(
                    children: [
                      Text(
                        startDate != null
                            ? 'Selected Date: ${DateFormat('yyyy-MM-dd').format(startDate!)}'
                            : 'No Date Selected',
                      ),
                      MaterialButton(
                        onPressed: () async {
                          final selectedDate = await _selectDate(context);
                          if (selectedDate == null) {
                            return;
                          }
                          setState(() {
                            startDate = selectedDate;
                          });
                        },
                        child: Text(
                          'Select Date',
                          style: TextStyle(color: Colors.blue),
                        ),
                      ),
                    ],
                  ),
                  const Text('Ticker from yahoo finance:'),
                  TextField(
                    controller: controller,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      MaterialButton(
                        color: Theme.of(context).primaryColor,
                        onPressed: () => load(),
                        child: const Text('Load'),
                      ),
                      MaterialButton(
                        color: Theme.of(context).colorScheme.error,
                        onPressed: () => deleteCache(),
                        child: const Text('Delete Cache'),
                      ),
                      MaterialButton(
                        color: Theme.of(context).colorScheme.onPrimary,
                        onPressed: () => refresh(),
                        child: const Text('Refresh'),
                      ),
                    ],
                  ),
                  Text('Prices in the service ${pricesList.length}'),
                  Text('Prices in the cache ${cachedPrices?.length}'),
                  pricesList.isEmpty
                      ? const Text('No data')
                      : const SizedBox.shrink()
                ],
              ),
            ),
          );
        } else {
          final YahooFinanceCandleData candleData = pricesList[i - 1];
          return _CandleCard(
            candleData,
          );
        }
      },
    );
  }

  Future<DateTime?> _selectDate(BuildContext context) async {
    final DateTime currentDate = DateTime.now();
    final DateTime initialDate =
        DateTime(currentDate.year, currentDate.month + 1, currentDate.day);
    return showDatePicker(
      context: context,
      initialDate: initialDate,
      firstDate: initialDate,
      lastDate: DateTime(2100),
    );
  }
}
