// レポジトリ情報を保持するクラス
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

@immutable
class RepositoryInfo {
  final String name;
  // final String iconUrl;
  final String language;
  final int starNum;
  final int watcherNum;

  const RepositoryInfo(this.name, this.language, this.starNum, this.watcherNum);
  // RepositoryInfo(
  //     this.name, this.language, this.starNum, this.watcherNum);

  RepositoryInfo.fromJson(Map<String, dynamic> json)
      : name = json['name'],
        // iconUrl = json['avatar_url'],
        // ignore: prefer_if_null_operators
        language = json['language'] == null ? '' : json['language'],
        starNum = json['stargazers_count'],
        watcherNum = json['watchers_count'];

  // デバッグ用
  void printInfo() {
    print(
        "name = $name, language = $language, starNum = $starNum, watcherNum=$watcherNum");
  }
}

class RepositoryInfoNotifier extends StateNotifier<List<RepositoryInfo>> {
  RepositoryInfoNotifier() : super([]);

  // リストの更新
  void update(List<RepositoryInfo> repositoryInfos) {
    state = repositoryInfos;
  }
}

final repositoryInfoProvider =
    StateNotifierProvider<RepositoryInfoNotifier, List<RepositoryInfo>>((ref) {
  return RepositoryInfoNotifier();
});
