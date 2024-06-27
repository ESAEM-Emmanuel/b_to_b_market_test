import 'package:flutter/material.dart';
import 'package:date_field/date_field.dart';
import 'package:b_to_b/models/market_model.dart'; // Import du modèle Market
import 'package:b_to_b/models/db_helper.dart'; // Import de DBHelper

class MarketForm extends StatefulWidget {
  final Function onSave;

  const MarketForm({super.key, required this.onSave});

  @override
  State<MarketForm> createState() => _MarketFormState();
}

class _MarketFormState extends State<MarketForm> {
  final _formKey = GlobalKey<FormState>();
  final marketNameController = TextEditingController();
  final ownerController = TextEditingController();
  String selectedAvatar = "boy";
  DateTime selectedMarketDate = DateTime.now();

  @override
  void dispose() {
    super.dispose();
    marketNameController.dispose();
    ownerController.dispose();
  }

  String _formatDateTime(DateTime dateTime) {
    // Fonction pour formater la date en chaîne de caractères
    return "${dateTime.year}-${dateTime.month}-${dateTime.day} ${dateTime.hour}:${dateTime.minute}";
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            margin: const EdgeInsets.only(bottom: 10),
            child: TextFormField(
              decoration: const InputDecoration(
                labelText: "Nom marché",
                hintText: "Saisir le nom du marché",
                border: OutlineInputBorder(),
              ),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return "Vous devez compléter ce champ!";
                }
                return null;
              },
              controller: marketNameController,
            ),
          ),
          Container(
            margin: const EdgeInsets.only(bottom: 10),
            child: TextFormField(
              decoration: const InputDecoration(
                labelText: "Nom du propriétaire",
                hintText: "Saisir le nom du propriétaire",
                border: OutlineInputBorder(),
              ),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return "Vous devez compléter ce champ!";
                }
                return null;
              },
              controller: ownerController,
            ),
          ),
          Container(
            margin: const EdgeInsets.only(bottom: 10),
            child: DropdownButtonFormField<String>(
              items: const [
                DropdownMenuItem(value: "boy", child: Text("Boy")),
                DropdownMenuItem(value: "girl", child: Text("Girl")),
                DropdownMenuItem(value: "vue", child: Text("Vue")),
                DropdownMenuItem(value: "croise", child: Text("Croise")),
              ],
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
              ),
              value: selectedAvatar,
              onChanged: (value) {
                setState(() {
                  selectedAvatar = value!;
                });
              },
            ),
          ),
          Container(
            margin: const EdgeInsets.only(bottom: 10),
            child: DateTimeFormField(
              decoration: const InputDecoration(
                hintStyle: TextStyle(color: Colors.black45),
                errorStyle: TextStyle(color: Colors.redAccent),
                border: OutlineInputBorder(),
                suffixIcon: Icon(Icons.event_note),
                labelText: 'Entrez une date Date',
              ),
              mode: DateTimeFieldPickerMode.dateAndTime,
              autovalidateMode: AutovalidateMode.always,
              validator: (e) => (e?.day ?? 0) == 1 ? "s'il vous plaît, pas un jour probable" : null,
              onDateSelected: (DateTime value) {
                setState(() {
                  selectedMarketDate = value;
                });
              },
            ),
          ),
          SizedBox(
            width: double.infinity,
            height: 33,
            child: ElevatedButton.icon(
              onPressed: () async {
                if (_formKey.currentState!.validate()) {
                  final marketName = marketNameController.text;
                  final owner = ownerController.text;
                  final avatar = selectedAvatar;
                  final hours = _formatDateTime(selectedMarketDate);

                  // Création de l'objet Market
                  Market market = Market(
                    description: marketName,
                    owner: owner,
                    avatar: avatar,
                    hours: hours,
                  );

                  // Sauvegarde dans la base de données
                  await DBHelper().save(market);

                  // Appel du callback onSave
                  widget.onSave();

                  // Fermer le dialogue en utilisant le contexte après l'opération asynchrone
                  if (!mounted) return;
                  Navigator.of(context).pop();
                }
              },
              icon: const Icon(Icons.send),
              label: const Text(
                "Soumettre",
                style: TextStyle(
                  fontFamily: 'comic',
                  fontSize: 13,
                ),
                textAlign: TextAlign.center,
              ),
            ),
          )
        ],
      ),
    );
  }
}