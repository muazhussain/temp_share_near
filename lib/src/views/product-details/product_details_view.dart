import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:share_near/src/models/product_model.dart';
import 'package:share_near/src/utils/constants.dart';
import 'package:share_near/src/utils/size_config.dart';
import 'package:share_near/src/views/global-components/default_button.dart';

class ProductDetailsView extends StatefulWidget {
  const ProductDetailsView({super.key});

  @override
  State<ProductDetailsView> createState() => _ProductDetailsViewState();
}

class _ProductDetailsViewState extends State<ProductDetailsView> {
  int selectedImage = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        leading: InkWell(
          borderRadius: BorderRadius.circular(40),
          onTap: () {
            Get.back();
          },
          child: const Padding(
            padding: EdgeInsets.all(8),
            child: CircleAvatar(
              backgroundColor: Colors.transparent,
              child: BackButton(
                color: Colors.black,
              ),
            ),
          ),
        ),
        actions: [
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 5),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(14),
            ),
            child: Row(
              children: [
                const Text(
                  '4.5',
                  style: TextStyle(
                    fontWeight: FontWeight.w600,
                    color: Colors.black,
                  ),
                ),
                const SizedBox(
                  width: 5,
                ),
                SvgPicture.asset('assets/icons/Star Icon.svg'),
              ],
            ),
          ),
        ],
      ),
      body: Column(
        children: <Widget>[
          SizedBox(
            width: getScreenWidth(238),
            child: AspectRatio(
              aspectRatio: 1,
              child: Image.asset(demoProducts[0].images![selectedImage]),
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ...List.generate(
                demoProducts[0].images?.length ?? 0,
                (index) => smallPreviewBuild(index),
              ),
            ],
          ),
          Container(
            margin: EdgeInsets.only(top: getScreenWidth(20)),
            padding: EdgeInsets.only(top: getScreenWidth(20)),
            width: double.infinity,
            height: 300,
            decoration: const BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(40),
                topRight: Radius.circular(40),
              ),
            ),
            child: Column(
              children: [
                Text(
                  demoProducts[0].title,
                  style: Theme.of(context).textTheme.titleLarge,
                ),
                const SizedBox(
                  height: 5,
                ),
                Align(
                  alignment: Alignment.centerRight,
                  child: Container(
                    padding: EdgeInsets.all(
                      getScreenWidth(16),
                    ),
                    decoration: const BoxDecoration(
                      color: Color(0xFFFFE6E6),
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(20),
                        bottomLeft: Radius.circular(20),
                      ),
                    ),
                    child: const Icon(Icons.favorite),
                  ),
                ),
                Expanded(
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        SizedBox(
                          height: SizeConfig.screenHeight * 0.04,
                        ),
                        SizedBox(
                          height: getScreenWidth(120),
                          child: Padding(
                            padding: const EdgeInsets.fromLTRB(20, 20, 20, 20),
                            child: Text(
                              demoProducts[0].description,
                              maxLines: 3,
                            ),
                          ),
                        ),
                        SizedBox(
                          height: SizeConfig.screenHeight * 0.04,
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(
                  height: SizeConfig.screenHeight * 0.04,
                ),
                Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: getScreenWidth(20),
                  ),
                  child: DefaultButton(
                    widget: const Text('Request to rent'),
                    press: () {},
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  GestureDetector smallPreviewBuild(int index) {
    return GestureDetector(
      onTap: () {
        setState(() {
          selectedImage = index;
        });
      },
      child: Container(
        padding: EdgeInsets.all(
          getScreenHeight(8),
        ),
        margin: EdgeInsets.only(right: getScreenWidth(15)),
        height: getScreenWidth(48),
        width: getScreenWidth(48),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10),
          border: Border.all(
            color: selectedImage == index ? primaryColor : Colors.transparent,
          ),
        ),
        child: Image.asset(demoProducts[0].images![index]),
      ),
    );
  }
}
