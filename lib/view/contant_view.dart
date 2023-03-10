import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:test_pics/widgets/custom_text.dart';
import 'package:test_pics/widgets/loading_indicator.dart';
import 'package:test_pics/widget_model/pics_model.dart';
import 'package:test_pics/data/user_data.dart';


//Страница с контентом
class ContantView extends StatefulWidget {
  const ContantView({Key? key}) : super(key: key);

  @override
  State<ContantView> createState() => _ContantViewState();
}

class _ContantViewState extends State<ContantView> {
  late List<String> items;
  bool loading = false, allLoaded = false;
  late List<String> pics;
  final ScrollController scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    mockFetch(context);
    scrollController.addListener(() {
      if (scrollController.position.pixels >=
              scrollController.position.maxScrollExtent &&
          !loading) {
        if (kDebugMode) {
          print("New data call");
        }
        mockFetch(context);
      }
    });

    @override
    // ignore: unused_element
    void dispose() {
      super.dispose();
      scrollController.dispose();
    }
  }

  mockFetch(BuildContext context) async {
    items = Provider.of<PicsModel>(context, listen: false).items;
    pics = Provider.of<PicsModel>(context, listen: false).pics;
    if (allLoaded) {
      return;
    }
    setState(() {
      loading = true;
    });
    await Future.delayed(const Duration(milliseconds: 2000));
    Iterable<String> newData = [];
    if (items.length <= pics.length) {
      newData = pics.take(10);
      items.addAll(newData);
      //проверка на пустой список
      if (pics.isNotEmpty) {
        if (pics.length < 10) {
          pics.removeRange(0, pics.length);
        } else {
          pics.removeRange(0, 10);
        }
      } else {
        items.clear();
      }
    } else {
      items.addAll(newData);
      items.addAll(pics);
      pics.removeRange(0, pics.length);
    }
    setState(() {
      loading = false;
      allLoaded = pics.isEmpty;
    });
  }

  @override
  Widget build(BuildContext context) {
    String userNumber = UserData.getUserNumber() ?? 'None';
    return WillPopScope(
      onWillPop: () async {
        return false;
      },
      child: Scaffold(
          appBar: AppBar(
            backgroundColor: Colors.black,
            title: CustomText(
              text: userNumber,
              fontWeight: FontWeight.bold,
            ),
            centerTitle: true,
            automaticallyImplyLeading: false,
            actions: [
              IconButton(
                  onPressed: () async {
                    Navigator.pushNamed(context, '/login');
                    await UserData.setLogin(false);
                  },
                  icon: const Icon(Icons.logout))
            ],
          ),
          body: LayoutBuilder(
            builder: (context, constraints) {
              if (items.isNotEmpty) {
                return Stack(
                  children: [
                    ListView.separated(
                        itemBuilder: (context, index) {
                          if (index < items.length) {
                            return Center(
                              child: GestureDetector(
                                child: Image(
                                  height: 150,
                                  width: 160,
                                  image: NetworkImage(items[index]),
                                ),
                                onTap: () {
                                  Navigator.pushNamed(context, '/detail_pics',
                                      arguments: PicsArguments(
                                          items[index], index, pics));
                                },
                              ),
                            );
                          } else {
                            return const SizedBox(
                              height: 50,
                              child: Center(
                                  child: CustomText(text: "Данных больше нет")),
                            );
                          }
                        },
                        controller: scrollController,
                        separatorBuilder: (context, index) {
                          return const Divider();
                        },
                        itemCount: items.length + (allLoaded ? 1 : 0)),
                    if (loading) ...[
                      Positioned(
                        left: 0,
                        bottom: 0,
                        child: Container(
                          padding: const EdgeInsets.only(top: 30, bottom: 15),
                          width: constraints.maxWidth,
                          height: 80,
                          child: const Center(
                              child: LoadingIndicator(
                            size: 60.0,
                          )),
                        ),
                      )
                    ]
                  ],
                );
              } else {
                return Center(
                    child: context.watch<PicsModel>().pics.isEmpty
                        ? const CustomText(text: "Данные отсутвуют")
                        : const LoadingIndicator(
                            size: 120.0,
                          ));
              }
            },
          )),
    );
  }
}

class PicsArguments {
  PicsArguments(this.urlPic, this.index, this.listPics);

  final int index;
  final List<String> listPics;
  final String urlPic;
}
