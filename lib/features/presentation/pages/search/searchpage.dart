import "package:insta_cleanarchitecture/const.dart";
import 'package:flutter/material.dart';
import 'package:insta_cleanarchitecture/features/presentation/pages/search/widget/searchwidget.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({super.key});

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  TextEditingController _searchController = TextEditingController();
  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: backGroundColor,
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SearchWidget(
                  controller: _searchController,
                ),
                sizeVer(10),
                GridView.builder(
                    itemCount: 32,
                    physics: ScrollPhysics(),
                    shrinkWrap: true,
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 3,
                      crossAxisSpacing: 5,
                      mainAxisSpacing: 5,
                    ),
                    itemBuilder: (context, Index) {
                      return Container(
                        width: 100,
                        height: 100,
                        color: secondaryColor,
                      );
                    }),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
