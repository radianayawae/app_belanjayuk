import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:piiicks/configs/configs.dart';
import 'package:piiicks/core/constant/colors.dart';
import 'package:piiicks/core/router/app_router.dart';
import 'package:piiicks/presentation/widgets/custom_appbar.dart';
import 'package:piiicks/presentation/widgets/transparent_button.dart';

import '../../application/delivery_info_action_cubit/delivery_info_action_cubit.dart';
import '../../application/delivery_info_fetch_cubit/delivery_info_fetch_cubit.dart';
import '../widgets/adress_card.dart';

class AddressesScreen extends StatefulWidget {
  const AddressesScreen({Key? key}) : super(key: key);

  @override
  State<AddressesScreen> createState() => _AddressesScreenState();
}

class _AddressesScreenState extends State<AddressesScreen> {
  @override
  void initState() {
    context.read<DeliveryInfoFetchCubit>().fetchDeliveryInfo();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<DeliveryInfoActionCubit, DeliveryInfoActionState>(
      listener: (context, state) {
        if (state is DeliveryInfoActionLoading) {
          //TODO
        } else if (state is DeliveryInfoSelectActionSuccess) {
          context
              .read<DeliveryInfoFetchCubit>()
              .selectDeliveryInfo(state.deliveryInfo);
        } else if (state is DeliveryInfoActionFail) {
          //TODO
        }
      },
      child: Scaffold(
        appBar: CustomAppBar("ADD ADDRESS", context,
            automaticallyImplyLeading: true),
        body: Padding(
          padding: Space.all(1.2, 1),
          child: Column(
            children: [
              transparentButton(
                  context: context,
                  onTap: () {
                    Navigator.of(context).pushNamed(AppRouter.addadress);
                  },
                  buttonText: "Add New Address"),
              BlocBuilder<DeliveryInfoFetchCubit, DeliveryInfoFetchState>(
                builder: (context, state) {
                  if (state is! DeliveryInfoFetchLoading &&
                      state.deliveryInformation.isEmpty) {
                    return Container(
                      height: AppDimensions.normalize(60),
                      padding: Space.all(0, .7),
                      margin: EdgeInsets.only(top: AppDimensions.normalize(60)),
                      color: AppColors.LightGrey,
                      child: Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              "NO SAVED ADDRESS",
                              style: AppText.h3b
                                  ?.copyWith(color: AppColors.CommonCyan),
                            ),
                            Space.yf(1),
                            Text(
                              "There Is No Saved Address.",
                              style: AppText.b2,
                            ),
                            Space.yf(1),
                            Text(
                              "Please Save New Address!",
                              style: AppText.b2,
                            ),
                          ],
                        ),
                      ),
                    );
                  }
                  return Flexible(
                    child: ListView.builder(
                      itemCount: (state is DeliveryInfoFetchLoading &&
                              state.deliveryInformation.isEmpty)
                          ? 5
                          : state.deliveryInformation.length,
                      itemBuilder: (context, index) => (state
                                  is DeliveryInfoFetchLoading &&
                              state.deliveryInformation.isEmpty)
                          ? const AdressCard()
                          : AdressCard(
                              deliveryInformation:
                                  state.deliveryInformation[index],
                              isSelected: state.deliveryInformation[index] ==
                                  state.selectedDeliveryInformation,
                            ),
                    ),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
