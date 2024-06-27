import 'package:flutter/material.dart';

import 'package:flutter_svg/flutter_svg.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}): super(key:key);
  
  @override
  Widget build(BuildContext context){
    return Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children:  [
              
              // Image.asset("assets/images/b_to_b_logo.jpg"),
              // SvgPicture.asset(
              //   "assets/images/b_to_b_logo.svg",
              //   // color: Colors.blue
              //   ),
              // FittedBox(
              //   fit: BoxFit.contain, // Ajuste l'image pour qu'elle rentre dans le widget sans déformation
              //   child: SvgPicture.asset(
              //     "assets/images/b_to_b_logo.svg",
              //   ),
              // ),
              SizedBox(
                width: 200, // Ajustez la largeur selon vos besoins
                height: 200, // Ajustez la hauteur selon vos besoins
                child: SvgPicture.asset(
                  "assets/images/b_to_b_logo.svg",
                ),
              ),
              
              const Text("B_TO_B Market 2024",
              style: TextStyle(
                 fontFamily: 'campus',
                 fontSize: 21,
                 ),
              ),
              
              const Text("Votre marché mois chère dans votre poche!",
              style: TextStyle(
                 fontFamily: 'comic',
                 fontSize: 13,
                 ),
                 textAlign: TextAlign.center,
              ),
              const Padding(padding: EdgeInsets.only(top: 10, right: 10, bottom:10, left: 10)),//marge entre les éléments d'un body
              // ignore: avoid_print
              ElevatedButton(
                style: ButtonStyle(
                  padding: MaterialStateProperty.all(const EdgeInsets.all(5)),//marge interne au boutton
                  backgroundColor: MaterialStateProperty.all(const Color.fromARGB(255, 255, 81, 0)),
                ),
                // ignore: avoid_print
                onPressed: () => print("click btn"),
                child: const Text(
                  "Liste des marchés",
                  style: TextStyle(
                    fontFamily: 'comic',
                    fontSize: 13,
                  ),
                  textAlign: TextAlign.center,
                ),
              )
              // ElevatedButton.icon(
              //   style: ButtonStyle(
              //     padding: MaterialStateProperty.all(const EdgeInsets.all(5)),//marge interne au boutton
              //     backgroundColor: MaterialStateProperty.all(const Color.fromARGB(255, 255, 81, 0)),
              //   ),
              //   onPressed: () {
              //     Navigator.push(
              //       context,
              //       PageRouteBuilder(
              //         pageBuilder: (_,__,___) =>MarketPage()
              //         )
              //     );
              //   }),
              //   label: const Text(
              //     "Liste des marchés",
              //     style: TextStyle(
              //       fontFamily: 'comic',
              //       fontSize: 13,
              //     ),
              //     textAlign: TextAlign.center,
              //   ),
              //   icon: const Icon(Icons.calendar_month),
              // ),
              // ElevatedButton.icon(
              //   style: ButtonStyle(
              //     padding: MaterialStateProperty.all(const EdgeInsets.all(5)), // marge interne au bouton
              //     backgroundColor: MaterialStateProperty.all(const Color.fromARGB(255, 255, 81, 0)),
              //   ),
              //   onPressed: () {
              //     Navigator.push(
              //       context,
              //       PageRouteBuilder(
              //         pageBuilder: (_, __, ___) => const MarketPage(),
              //       ),
              //     );
              //   },
              //   label: const Text(
              //     "Liste des marchés",
              //     style: TextStyle(
              //       fontFamily: 'comic',
              //       fontSize: 13,
              //     ),
              //     textAlign: TextAlign.center,
              //   ),
              //   icon: const Icon(Icons.calendar_month),
              // )
            ],
          ),
        );
    // return Scaffold(
    //     // Création de l'appBar
    //     appBar: AppBar(
    //       title: const Text(
    //                         "B_TO_B Market",
    //                         style: TextStyle(
    //                         fontFamily: 'papyrus',
    //                         fontSize: 21,
    //              )
    //                         ),
    //     ),

    //     body: 

    //   ); 
  }
}