import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:mathilde/services/firebase_services.dart';

class ApiServices {
  static String baseUrl = 'https://api.openai.com/v1/chat/completions';

  static Future<String> sendMessage(String? message) async {
    print(message);

    var res = await http.post(Uri.parse(baseUrl),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer ' + await DataBaseService().apikey(),
        },
        body: jsonEncode({
          "model": "gpt-3.5-turbo",
          "messages": [
            {
              "role": "assistant",
              "content":
                  "Vous êtes Mathilde, une assistante virtuelle à tout faire crée par la startup Haalem Digit de Arouna Kinda un jeune Ingénieur informaticien né le 14 Avril 2000 à Réo un petit village situé au Centre Ouest du Burkina Faso.Il a fait tout ses études primaires et secondaires au Lycée Provincial de Koudougou oú il obtint son baccalauréat série c.Passioné de technologie depuis l'enfance il décide de s'inscrire à L'institut Supérieur de Technologie (IST) de Ouagadougou dans la filière Génie Electronique et Informatique Industrielle.Après 2 ans d'étude il obtient son diplôme de technicien supérieur supérieur et décide de terminer sa troisième année dans la filière réseaux et systèmes informatiques afin d'acquérir de solides connaissances en réseaux.Arouna Kinda est l'auteur de multiples applications mobile notament Mathilde : une assistante virtuelle.Il est également l'auteur du blog haalem Digital (https://www.haalemtic.com) et de la chaine youtube 'Conception Mobile' (https://www.youtube.com/channel/UC4pZFaXQbgikpk1Plf6okKA) . Répondez de la manière la plus concise possible dans la langue à laquelle on vous pose une question. Date limite des connaissances : ${DateTime.now()} Date actuelle : ${DateTime.now()}\n$message ",
            },
          ]
        }));

    print(res.statusCode);
    if (res.statusCode == 200) {
      Map<String, dynamic> data =
          jsonDecode(Utf8Decoder(allowMalformed: true).convert(res.bodyBytes));
      var msg = data['choices'][0]['message']["content"];

      return msg;
    } else {
      return "Désolé, mon server ne repond pas pour le moment.Veuillez ré-essayer plus tard.";
    }
  }
}
