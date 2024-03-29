import 'package:flutter/material.dart';
import 'package:thalj/core/utils/app_colors.dart';
import 'package:thalj/core/utils/app_text_style.dart';


class TodayProducts extends StatelessWidget {
  const TodayProducts({
    super.key,
    required this.onTap,
    required this.location,
    required this.locationTo,
    required this.productType,
  });
  final void Function() onTap;
  final String location;
  final String locationTo;
  final String productType;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Container(

          color: const Color(0xffF0F3FD),
          child: Column(
            children: [
              Expanded(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,

                  children: [
                    Flexible(
                      child: Text(
                        location,
                        style: boldStyle(fontSize: 15),
                      ),
                    ),

                    const Icon(
                      Icons.location_on_outlined,
                      color: AppColors.primary,
                      size: 20,
                    )
                  ],
                ),
              ),
              Expanded(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,

                  children: [
                    Flexible(
                      child: Text(
                        locationTo,
                        style: boldStyle(fontSize: 15),
                      ),
                    ),
                    const Image(
                      image: AssetImage('assets/images/loc.png'),
                      height: 20,
                      width: 30,
                    )
                  ],
                ),
              ),
              Expanded(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,

                  children: [
                    Flexible(
                      child: Text(
                        productType,
                        style: boldStyle(fontSize: 15),
                      ),
                    ),

                    const Image(
                      image: AssetImage('assets/images/moka.png'),
                      height: 20,
                      width: 30,
                    )
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
