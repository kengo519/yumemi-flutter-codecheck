import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:yumemi_flutter_codecheck/repositoryInfo.dart';

// class SelectedPage extends ConsumerStatefulWidget {
//   const SelectedPage({super.key});

//   @override
//   SelectedPage createState() => const SelectedPage();
// }

class SelectedPage extends StatelessWidget {
  final RepositoryInfo repositoryInfo;
  const SelectedPage({super.key, required this.repositoryInfo});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Theme.of(context).colorScheme.inversePrimary,
          title: const Text("selected page"),
        ),
        body: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(
              width: 5,
            ),
            Image.network(
              repositoryInfo.iconUrl,
              width: 50,
              height: 50,
            ),
            const SizedBox(
              width: 10,
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text("name      : ${repositoryInfo.name}"),
                Text("language  : ${repositoryInfo.language}"),
                Text("starNum   : ${repositoryInfo.starNum}"),
                Text("wacherNum : ${repositoryInfo.watcherNum}"),
              ],
            ),
          ],
        ));
  }
}
