import 'package:flutter/material.dart';
import 'package:b_to_b/pages/add_market_page.dart';
import 'package:b_to_b/models/market_model.dart';
import 'package:b_to_b/models/db_helper.dart';

class MarketPage extends StatefulWidget {
  const MarketPage({Key? key}) : super(key: key);

  @override
  State<MarketPage> createState() => _MarketPageState();
}

class _MarketPageState extends State<MarketPage> {
  late Future<List<Market>> markets;
  final DBHelper dbHelper = DBHelper();

  @override
  void initState() {
    super.initState();
    markets = dbHelper.getMarkets();
  }

  Future<void> showMarketDetailDialog(String avatar, String owner, String hours, String description) async {
    return showDialog(
      context: context,
      barrierDismissible: true,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(description),
          backgroundColor: const Color.fromARGB(234, 158, 158, 158),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                Image.asset("assets/images/$avatar.png", height: 200),
                Text("Titre : $description"),
                Text("Le Propriétaire est $owner"),
                Text("Heures D'ouverture: $hours"),
              ],
            ),
          ),
          actions: <Widget>[
            ElevatedButton.icon(
              onPressed: () {
                Navigator.of(context).pop();
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text(
                      "Votre marché est enregistré dans votre agenda...",
                      style: TextStyle(
                        fontFamily: 'comic',
                        fontSize: 13,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                );
              },
              icon: const Icon(Icons.calendar_month_outlined),
              label: const Text("Ajouter calendrier"),
            ),
            const SizedBox(width: 50,),
            TextButton(
              child: const Text("Valider"),
              onPressed: () {
                Navigator.of(context).pop();
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text(
                      "Votre marché est en cours de validation...",
                      style: TextStyle(
                        fontFamily: 'comic',
                        fontSize: 13,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                );
              },
            ),
          ],
        );
      },
    );
  }

  Future<void> showMarketCreateDialog() async {
    return showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text("Ajouter un marché"),
          content: MarketForm(
            onSave: () {
              setState(() {
                markets = dbHelper.getMarkets();
              });
            },
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: FutureBuilder<List<Market>>(
          future: markets,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const CircularProgressIndicator();
            } else if (snapshot.hasError) {
              return Text('Error: ${snapshot.error}');
            } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
              return const Text('No markets available');
            } else {
              return ListView.builder(
                itemCount: snapshot.data!.length,
                itemBuilder: (context, index) {
                  final market = snapshot.data![index];
                  return Card(
                    child: ListTile(
                      leading: Image.asset("assets/images/${market.avatar}.png"),
                      title: Text("${market.owner} (${market.hours})"),
                      subtitle: Text(market.description),
                      trailing: IconButton(
                        onPressed: () {
                          showMarketDetailDialog(market.avatar, market.owner, market.hours, market.description);
                        },
                        icon: const Icon(Icons.more_vert),
                      ),
                    ),
                  );
                },
              );
            }
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showMarketCreateDialog();
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}