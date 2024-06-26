import 'package:bookstore/cache/cache_helper.dart';
import 'package:bookstore/core/services/service_locator.dart';
import 'package:bookstore/core/utils/api_key.dart';
import 'package:bookstore/cubits/add_to_cart/add_to_cart_cubit.dart';
import 'package:bookstore/cubits/bottom_navigation_bar/bottom_navigation_bar_cubit.dart';
import 'package:bookstore/cubits/get_books/book_id/get_books_cubit.dart';
import 'package:bookstore/cubits/get_books/get_Category_books/get_books_cubit.dart';
import 'package:bookstore/cubits/get_books/get_books/get_books_cubit.dart';
import 'package:bookstore/cubits/get_books/get_newarrival_books/get_books_cubit.dart';
import 'package:bookstore/cubits/get_books/get_onsale_books/get_books_cubit.dart';
import 'package:bookstore/cubits/get_books/get_topseller%20-books/get_books_cubit.dart';
import 'package:bookstore/cubits/get_books/get_upcoming_books/get_books_cubit.dart';
import 'package:bookstore/cubits/get_books/get_user_Bookmarks_books/get_books_cubit.dart';
import 'package:bookstore/cubits/get_books/get_user_fav_books/get_books_cubit.dart';
import 'package:bookstore/cubits/get_books/get_user_own__books/get_books_cubit.dart';
import 'package:bookstore/cubits/get_books/search_books/get_books_cubit.dart';
import 'package:bookstore/cubits/get_user_info/get_user_info_cubit.dart';
import 'package:bookstore/cubits/sign_in/sign_in_cubit.dart';
import 'package:bookstore/cubits/sign_up/sign_up_cubit.dart';
import 'package:bookstore/cubits/update_user_profile/update_user_profile_cubit.dart';
import 'package:bookstore/generated/l10n.dart';
import 'package:bookstore/helper/local_network.dart';
import 'package:bookstore/simple_bloc_observer.dart';
import 'package:bookstore/views/splash_screen/splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_stripe/flutter_stripe.dart';

void main() async {
  Stripe.publishableKey = ApiKeys.publishablekey;

  WidgetsFlutterBinding.ensureInitialized();
  setUpServiceLocator();
  await getIt<CacheHelper>().init();
  await CacheNetwork.cacheInitialization();
  Bloc.observer = SimpleBlocObserver();

  CacheHelper cacheHelper = getIt<CacheHelper>();
  String? savedLocale = cacheHelper.getLocale();
  Locale initialLocale =
      savedLocale != null ? Locale(savedLocale) : const Locale('en', 'US');

  runApp(BookStore(initialLocale: initialLocale));
}

class BookStore extends StatefulWidget {
  final Locale initialLocale;

  const BookStore({super.key, required this.initialLocale});

  static void setLocale(BuildContext context, Locale newLocale) {
    _BookStoreState state = context.findAncestorStateOfType<_BookStoreState>()!;
    state.setLocale(newLocale);
  }

  @override
  State<BookStore> createState() => _BookStoreState();
}

class _BookStoreState extends State<BookStore> {
  late Locale _locale;
  late CacheHelper cacheHelper;

  @override
  void initState() {
    super.initState();
    _locale = widget.initialLocale;
    cacheHelper = getIt<CacheHelper>();
  }

  void setLocale(Locale locale) {
    setState(() {
      _locale = locale;
      cacheHelper.saveLocale(locale.languageCode);
    });
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<BottomNavigationBarCubit>(
          create: (BuildContext context) => BottomNavigationBarCubit(),
        ),
        BlocProvider<GetallBooksCubit>(
          create: (BuildContext context) => GetallBooksCubit(),
        ),
        BlocProvider<GetonsaleBooksCubit>(
          create: (BuildContext context) => GetonsaleBooksCubit(),
        ),
        BlocProvider<GettopsellerBooksCubit>(
          create: (BuildContext context) => GettopsellerBooksCubit(),
        ),
        BlocProvider<GetnewarrivalBooksCubit>(
          create: (BuildContext context) => GetnewarrivalBooksCubit(),
        ),
        BlocProvider<GetupcomingBooksCubit>(
          create: (BuildContext context) => GetupcomingBooksCubit(),
        ),
        BlocProvider<GetCategoryBooksCubit>(
          create: (BuildContext context) => GetCategoryBooksCubit(),
        ),
        BlocProvider<GetsearchBooksCubit>(
          create: (BuildContext context) => GetsearchBooksCubit(),
        ),
        BlocProvider<GetBookidCubit>(
          create: (BuildContext context) => GetBookidCubit(),
        ),
        BlocProvider<GetFavoritesBooksCubit>(
          create: (BuildContext context) => GetFavoritesBooksCubit(),
        ),
        BlocProvider<GetownBooksCubit>(
          create: (BuildContext context) => GetownBooksCubit(),
        ),
        BlocProvider<GetmarksBooksCubit>(
          create: (BuildContext context) => GetmarksBooksCubit(),
        ),
        BlocProvider<AddToCartCubit>(
          create: (BuildContext context) => AddToCartCubit(),
        ),
        BlocProvider<SignInCubit>(
          create: (BuildContext context) => SignInCubit(),
        ),
        BlocProvider<SignUpCubit>(
          create: (BuildContext context) => SignUpCubit(),
        ),
        BlocProvider<UpdateUserProfileCubit>(
          create: (BuildContext context) => UpdateUserProfileCubit(),
        ),
        BlocProvider<GetUserInfoCubit>(
          create: (BuildContext context) => GetUserInfoCubit(),
        ),
      ],
      child: MaterialApp(
        locale: _locale,
        localizationsDelegates: const [
          S.delegate,
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
          GlobalCupertinoLocalizations.delegate,
        ],
        supportedLocales: S.delegate.supportedLocales,
        theme: ThemeData(
          fontFamily: 'Rubik-Variable',
        ),
        debugShowCheckedModeBanner: false,
        home: const SplashScreen(),
      ),
    );
  }
}
