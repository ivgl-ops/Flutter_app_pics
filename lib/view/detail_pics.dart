import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:test_pics/widgets/custom_text.dart';
import 'package:test_pics/widgets/loading_indicator.dart';

import '../widget_model/pics_model.dart';
import 'contant_view.dart';

class DetailPics extends StatefulWidget {
  const DetailPics({super.key});

  @override
  State<DetailPics> createState() => _DetailPicsState();
}

class _DetailPicsState extends State<DetailPics> {
  bool loading = true;

  @override
  Widget build(BuildContext context) {
    final args = ModalRoute.of(context)!.settings.arguments as PicsArguments;
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.black,
          centerTitle: true,
          title: const CustomText(text: "Pics", fontWeight: FontWeight.bold,),
          actions: [
            IconButton(
                onPressed: () async {
                  setState(() {
                    Provider.of<PicsModel>(context, listen: false)
                        .removePic(args.index);
                  });
                  loading = false;
                  await Future.delayed(const Duration(milliseconds: 2000));
                  loading = true;
                  // ignore: use_build_context_synchronously
                  Navigator.pushNamed(context, '/contant');
                },
                icon: const Icon(Icons.delete))
          ],
        ),
        body: loading
            ? Center(
                child: Image(
                  filterQuality:FilterQuality.high ,
                  fit: BoxFit.contain,
                width: 250,
                height: 250,
                image: NetworkImage(args.urlPic),
              ))
            : const Center(
                child: LoadingIndicator(size: 120),
              ));
  }
}
