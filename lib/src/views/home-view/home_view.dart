import 'package:flutter/material.dart';
import 'package:share_near/src/models/product_model.dart';
import 'package:share_near/src/utils/constants.dart';
import 'package:share_near/src/utils/size_config.dart';
import 'package:share_near/src/views/home-view/components/cash_back_offer.dart';
import 'package:share_near/src/views/home-view/components/home_view_search_bar.dart';
import 'package:share_near/src/views/home-view/components/product_card.dart';
import 'package:share_near/src/views/home-view/components/section_title.dart';
import 'package:share_near/src/views/home-view/components/special_offers.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.symmetric(
              horizontal: getScreenWidth(20),
            ),
            child: Column(
              children: <Widget>[
                littleGap,
                HomeViewSearchBar(
                  onChanged: () {},
                ),
                littleGap,
                const CashBackOffer(),
                littleGap,
                SectionTitle(
                  text: 'Trending Now',
                  press: () {},
                ),
                littleGap,
                SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    children: [
                      SpecialOffers(
                        category: 'Smartphone',
                        image: 'assets/images/phone banner.png',
                        press: () {},
                      ),
                      SpecialOffers(
                        category: 'Smartphone',
                        image: 'assets/images/phone banner.png',
                        press: () {},
                      ),
                    ],
                  ),
                ),
                littleGap,
                SectionTitle(
                  text: 'Popular Products',
                  press: () {},
                ),
                littleGap,
                SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    children: [
                      ...List.generate(
                        5,
                        (index) => ProductCard(
                          product: demoProducts[0],
                        ),
                      ),
                    ],
                  ),
                ),
                littleGap,
                SectionTitle(
                  text: 'New Arrival',
                  press: () {},
                ),
                littleGap,
                SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    children: [
                      ...List.generate(
                        5,
                        (index) => ProductCard(
                          product: demoProducts[0],
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
