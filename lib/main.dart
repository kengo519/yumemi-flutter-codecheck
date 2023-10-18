import 'dart:convert';
import 'dart:math' as Math;

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:http/http.dart' as http;
import 'repositoryInfo.dart';

const String url = 'https://api.github.com/search/repositories?q=';
const int maxSize = 30;

void main() {
  runApp(const ProviderScope(child: MyApp()));
}

class MyApp extends ConsumerWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends ConsumerStatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  MyHomePageState createState() => MyHomePageState();
}

class MyHomePageState extends ConsumerState<MyHomePage> {
  void onSubmitted(String val) async {
    // githubAPIへのリクエスト
    http.Response res = await http.get(Uri.parse(url + val),
        headers: <String, String>{'X-GitHub-Api-Version': '2022-11-28'});
    // List<RepositoryInfo> list = <RepositoryInfo>[];

    if (res.statusCode == 200) {
      final Map<String, dynamic> body = jsonDecode(res.body);
      // int totalCount = Math.min(body['total_count'], maxSize);
      // print(totalCount);
      List<RepositoryInfo> list = (body['items'] as List)
          .map((e) => RepositoryInfo.fromJson(e))
          .toList();
      ref.read(repositoryInfoProvider.notifier).update(list);
      List<RepositoryInfo> repos = ref.watch(repositoryInfoProvider);
      for (final repo in repos) {
        repo.printInfo();
      }
      // for (int i = 0; i < totalCount; i++) {
      //   // print(body);
      //   // print(jsonDecode(body['items'][i]));
      //   print(body['items'][i]['avatar_url']);
      //   list.add(RepositoryInfo.fromJson(body['items'][i]));
      // }
    }
  }

  @override
  Widget build(BuildContext context) {
    List<RepositoryInfo> repositoryInfos = ref.watch(repositoryInfoProvider);

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(
              vertical: 12,
              horizontal: 36,
            ),
            // 検索窓
            child: TextField(
              style: const TextStyle(
                fontSize: 18,
                color: Colors.black,
              ),
              decoration: const InputDecoration(
                hintText: 'Enter a search term',
              ),
              onSubmitted: onSubmitted,
            ),
          ),
          Expanded(
            child: Column(
              children: [
                Expanded(
                  child: ListView.builder(
                    itemCount: repositoryInfos.length,
                    itemBuilder: (BuildContext context, int index) {
                      return ListTile(
                        title: Text(repositoryInfos[index].name),
                        subtitle: Text("${repositoryInfos[index].language}, ${repositoryInfos[index].starNum}, ${repositoryInfos[index].watcherNum}"),
                        // onTap: ,
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
