import 'package:flutter/material.dart';
import 'package:mathilde/models/voiceItemModel.dart';

import 'categoryModel.dart';
import 'chatModel.dart';
import 'historyModel.dart';

List<CategoryItemModel> category1Data = [
  CategoryItemModel(
      title: "Rent a House",
      query:
          "What are the rent prices near Covent Garden,${WidgetsBinding.instance.window.locale.countryCode}?",
      bgColor: Color(0XFFdae1d1)),
  CategoryItemModel(
      title: "Ticket Purchase",
      query:
          "Can I buy tickets for Orlando Disney World at the gate when I get there?",
      bgColor: Color(0xFF9bd6d2)),
  CategoryItemModel(
      title: "Restaurant Advices",
      query:
          "What are the top 5 famous restaurants to visit in ${WidgetsBinding.instance.window.locale.countryCode}?",
      bgColor: Color(0xFFafafc9)),
  CategoryItemModel(
      title: "Seven Wonders",
      query: "What are the seven wonders of the earth?",
      bgColor: Color(0xFF7797c0)),
  CategoryItemModel(
      title: "Places to Visit",
      query:
          "Assume that I have only 5 days to stay in NY advice me must-see places.",
      bgColor: Color(0xFFc0d3d9))
];
List<CategoryItemModel> category2Data = [
  CategoryItemModel(
      title: "Name Generator",
      query:
          "Generate product name suggestion for details below:Product description: A home milkshake maker Seed words:fast, healthy, compact.",
      bgColor: Color(0xFFfff2ad)),
  CategoryItemModel(
      title: "Relationship Advices",
      query: "What are some romantic ideas to propose to my girlfriend?",
      bgColor: Color(0xFFf4dfc4)),
  CategoryItemModel(
      title: "Caption Ideas",
      query: "Do you have Instagram caption ideas for a travel photo in Bali?",
      bgColor: Color(0xFFd7c3c2)),
  CategoryItemModel(
      title: "Poem Generator",
      query: "Write a poem about love.",
      bgColor: Color(0xFFc2acc3)),
  CategoryItemModel(
      title: "Job Posting",
      query:
          "Can you write a template of job posting for the 'Jr. QA Engineer' position?",
      bgColor: Color(0xFF9793b4))
];
List<CategoryItemModel> category3Data = [
  CategoryItemModel(
      title: "Organnelles of Cell",
      query: "What are the organelles of an eukaryotic cell?",
      bgColor: Color(0xFFe6edf3)),
  CategoryItemModel(
      title: "Climate Change",
      query: "How does climate change affect the planet?",
      bgColor: Color(0XFFe3e2e0)),
  CategoryItemModel(
      title: "Evolutionary Theory",
      query: "What is the process of evolution and how does it work?",
      bgColor: Color(0XFFb5c7dd)),
  CategoryItemModel(
      title: "Human Brain",
      query:
          "How do our brains process information and create thoughts and emotions?",
      bgColor: Color(0XFFc7dfdf)),
  CategoryItemModel(
      title: "Secret of Universe",
      query: "What is the structure of universe and how did it form?",
      bgColor: Color(0XFFf0e7e0))
];

List<CategoryItemModel> category4Data = [
  CategoryItemModel(
      title: "Hair Growth",
      query: "What are some ways for promoting hair growth?",
      bgColor: Color(0XFFfae6e5)),
  CategoryItemModel(
      title: "Sleep Better",
      query: "What are some tips that can help me sleep better?",
      bgColor: Color(0xFFeabcbe)),
  CategoryItemModel(
      title: "Morning Routine",
      query: "What are some tips to establish a morning routine?",
      bgColor: Color(0XFFcbb18c)),
  CategoryItemModel(
      title: "Recommended Books",
      query:
          "What are the books you can recommend for someone interested in 'mindfullness'?",
      bgColor: Color(0XFFcf9b9d)),
];
List<HistoryItemModel> historyData = [
  HistoryItemModel(
      id: 0,
      botMsg: "Bonjour que puis-je pour vous aujourd'hui",
      userMsg: "Bonjour comment tu vas ?",
      date_sended: DateTime(2023, 1, 23, 23, 33, 25, 45, 56)),
  HistoryItemModel(
      id: 1,
      botMsg:
          "La capitale du Burkina Faso est Ouagadougou .Son actuel président est Rock mark christian Kaboré",
      userMsg: "Quelle est la capitale du Burkina Faso",
      date_sended: DateTime(2023, 4, 04, 12, 21, 56, 33, 56)),
  HistoryItemModel(
      id: 2,
      botMsg: "Je m'appelle Mathilde ton assistante virtuelle",
      userMsg: "Comment t'appelle tu ?",
      date_sended: DateTime(2023, 2, 56, 23, 1, 25, 67, 78))
];

List<ChatModel> newDiscussion = [
  ChatModel(
      id: 0,
      historiItemId: 0,
      date: DateTime.now(),
      text: "Hi, How can I help you ?",
      user: "bot"),
];

List<ChatModel> chatList = [
  ChatModel(
      id: 1,
      historiItemId: 0,
      date: DateTime.now(),
      text: "Bonjour comment tu vas ?",
      user: "user"),
  ChatModel(
      id: 0,
      historiItemId: 1,
      date: DateTime.now(),
      text: "Je vais bien et toi que puis je pour vous aujourd'hui ?",
      user: "bot"),
  ChatModel(
      id: 1,
      historiItemId: 1,
      date: DateTime.now(),
      text: "Parle moi du Burkina Faso",
      user: "user"),
  ChatModel(
      id: 0,
      historiItemId: 2,
      date: DateTime.now(),
      text:
          "Le Burkina Faso est un pays d'Afrique de l'Ouest, situé au centre du continent et entouré par six autres pays : le Mali au nord, le Niger à l'est, le Bénin au sud-est, le Togo et le Ghana au sud et la Côte d'Ivoire au sud-ouest. Sa capitale est Ouagadougou.Le Burkina Faso a une population d'environ 21 millions d'habitants, composée de nombreuses ethnies et langues. La langue officielle est le français, mais la plupart des Burkinabè parlent également une langue locale, principalement le mooré.Le pays est principalement rural, avec une économie basée sur l'agriculture et l'élevage. Les principales cultures sont le coton, le maïs, le mil, le sorgho, le riz et les arachides. L'industrie minière, notamment l'exploitation de l'or, est également importante pour l'économie du pays.Le Burkina Faso a une histoire riche et complexe. Le pays a été colonisé par la France au XIXe siècle, avant d'obtenir son indépendance en 1960. Depuis lors, il a connu des périodes de stabilité et de développement, ainsi que des périodes de troubles politiques et de conflits armés.Le pays est connu pour ses danses et ses festivals traditionnels, notamment le FESPACO, le plus grand festival de cinéma africain, qui se tient tous les deux ans à Ouagadougou. Le Burkina Faso est également réputé pour sa musique, notamment le genre musical populaire appelé 'musique mandingue'.",
      user: "bot"),
  ChatModel(
      id: 1,
      historiItemId: 2,
      date: DateTime.now(),
      text: "Le Burkina Faso est un pays d'Afrique de l'Ouest.",
      user: "bot")
];
