part of "widgets.dart";

class ShopCard extends StatelessWidget {

  final String title;
  final String description;
  final String imageURL;
  final int price;
  final int index;
  final bool isRightSide;

  ShopCard({
    required this.title,
    required this.description,
    required this.price,
    required this.index,
    required this.imageURL,
    required this.isRightSide
  });

  @override
  Widget build(BuildContext context) {

    final formatCurrency = new NumberFormat.simpleCurrency(locale: 'id_ID');

    return GestureDetector(
      onTap: (){
        Get.to(() => ShopItem(index: index));
      },
      child: Hero(
        tag: index,
        child: AspectRatio(
          aspectRatio: 1 / 1.6,
          child: Container(
            margin: EdgeInsets.fromLTRB(
                isRightSide
                    ? MQuery.height(0.0125, context)
                    : MQuery.height(0.025, context),
                MQuery.height(0.0275, context),
                isRightSide
                    ? MQuery.height(0.025, context)
                    : MQuery.height(0.0125, context),
                0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                AspectRatio(
                  aspectRatio: 1,
                  child: Container(
                    decoration: BoxDecoration(
                        color: Colors.red,
                        borderRadius: BorderRadius.all(Radius.circular(10))),
                  ),
                ),
                Container(
                  margin: EdgeInsets.symmetric(
                    horizontal: MQuery.height(0.01, context),
                    vertical: MQuery.height(0.015, context),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Font.out(
                          title: title,
                          fontSize: 18,
                          family: "EinaRegular",
                          textAlign: TextAlign.start),
                      SizedBox(height: 0.2),
                      Font.out(
                          title: "${formatCurrency.format(price).substring(0, formatCurrency.format(price).length - 3)}", fontSize: 18, family: "EinaSemiBold"),
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
