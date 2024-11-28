import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:piiicks/application/filter_cubit/filter_cubit.dart';
import 'package:piiicks/application/notifications_cubit/notifications_cubit.dart';
import 'package:piiicks/application/share_cubit/share_cubit.dart';
import 'package:piiicks/application/wishlist_cubit/wishlist_cubit.dart';

import '../application/bottom_navbar_cubit/bottom_navbar_cubit.dart';
import 'di.dart';

void registerCubits() {
  // Navigation
  sl.registerFactory(() => NavigationCubit());

  //Filter
  sl.registerFactory(() => FilterCubit());

  //Wishlist
  sl.registerFactory(() => WishlistCubit());

  //Wishlist
  sl.registerFactory(() => ShareCubit());

  //Notiications
  sl.registerLazySingleton(() => FlutterLocalNotificationsPlugin());
  sl.registerFactory(() => NotificationsCubit(sl()));
}
