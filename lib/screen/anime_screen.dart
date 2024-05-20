import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../provider/provider.dart';

class AnimeScreen extends StatefulWidget {
  const AnimeScreen({Key? key}) : super(key: key);

  @override
  State<AnimeScreen> createState() => _AnimeScreenState();
}

class _AnimeScreenState extends State<AnimeScreen> {
  @override
  void initState() {
    super.initState();
    animeData();
  }

  void animeData() async {
    final animeProvider = Provider.of<UserProvider>(context, listen: false);
    await animeProvider.getAnimeData();
    print("========${animeProvider.animeList}");
  }

  @override
  Widget build(BuildContext context) {
    final animeProvider = Provider.of<UserProvider>(context);
    return Scaffold(
      body: Column(
        children: [
          Expanded(
            child: Consumer<UserProvider>(
              builder: (context, value, child) {
                if (value.loading) {
                  return const Center(
                    child: CupertinoActivityIndicator(
                      radius: 20,
                    ),
                  );
                }
                return ListView.builder(
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            animeProvider.animeList?.data?[index].title
                                    .toString() ??
                                '',
                            style: const TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.bold),
                          ),
                          const SizedBox(height: 10),
                          Text(
                            animeProvider.animeList?.data?[index].titleJapanese
                                    .toString() ??
                                '',
                          ),
                          const Divider(
                            thickness: 2,
                          ),
                        ],
                      ),
                    );
                  },
                  itemCount: animeProvider.animeList?.data?.length,
                );
              },
            ),
          )
        ],
      ),
    );
  }
}
