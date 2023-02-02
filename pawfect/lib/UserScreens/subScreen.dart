// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter/rendering.dart';
// import 'package:pawfect/ViewModel/DogViewModel.dart';
// import 'package:provider/provider.dart';
//
// import '../ViewModel/GlobalUIViewModel.dart';
// import '../ViewModel/SingleDogViewModel.dart';
// import '../ViewModel/auth_viewmodel.dart';
// import '../Widgets/AppColumn.dart';
// import '../Widgets/AppIcon.dart';
// import '../Widgets/ExpandableTextWidget.dart';
// import '../model/favModel.dart';
//
// class SubScreen extends StatefulWidget {
//   final int? index;
//   final String? dogName;
//   final String? dogDescription;
//   final String? imageLink;
//   final String? breed;
//   final String? color;
//   final int? price;
//
//   SubScreen(this.index, this.dogName, this.dogDescription, this.imageLink,
//       this.price, this.breed, this.color);
//
//   @override
//   State<SubScreen> createState() => _SubScreenState();
// }
//
// class _SubScreenState extends State<SubScreen> {
//   late DogViewModel _dogViewModel;
//   var _currentPageValue = 0.0;
//   PageController pageController = PageController(viewportFraction: 0.85);
//   int _count = 1;
//
//   late GlobalUIViewModel _ui;
//   late AuthViewModel _authViewModel;
//   String? dogId;
//   late SingleDogViewModel _singleDogViewModel;
//
//   @override
//   void initState() {
//     WidgetsBinding.instance.addPostFrameCallback((_) {
//       _singleDogViewModel =
//           Provider.of<SingleDogViewModel>(context, listen: false);
//       _authViewModel = Provider.of<AuthViewModel>(context, listen: false);
//       _ui = Provider.of<GlobalUIViewModel>(context, listen: false);
//       final args = ModalRoute.of(context)!.settings.arguments.toString();
//       _dogViewModel = Provider.of<DogViewModel>(context, listen: false);
//       _dogViewModel.getDog();
//       print("The Final Place -->${_dogViewModel.getDog()}");
//       setState(() {
//         dogId = args;
//       });
//       print(args);
//       getData(args);
//     });
//     super.initState();
//     pageController.addListener(() {
//       setState(() {
//         _currentPageValue = pageController.page!;
//       });
//     });
//   }
//
//   Future<void> getData(String dogId) async {
//     _ui.loadState(true);
//     try {
//       await _authViewModel.getFavoritesDog();
//       await _singleDogViewModel.getDogs(dogId);
//     } catch (e) {}
//     _ui.loadState(false);
//   }
//
//   Future<void> favoritePressed(FavoriteModel? isFavorite, String dogId) async {
//     _ui.loadState(true);
//     try {
//       await _authViewModel.favoriteAction(isFavorite, dogId);
//       ScaffoldMessenger.of(context)
//           .showSnackBar(SnackBar(content: Text("Favorite updated.")));
//     } catch (e) {
//       ScaffoldMessenger.of(context).showSnackBar(
//           SnackBar(content: Text("Something went wrong. Please try again.")));
//       print(e);
//     }
//     _ui.loadState(false);
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     var dog = context.watch<DogViewModel>().dog;
//     int weight = 0;
//     return Consumer2<SingleDogViewModel, AuthViewModel>(
//         builder: (context, singleDogVM, authVm, child) {
//       return Scaffold(
//           appBar: AppBar(
//             backgroundColor: Colors.black54,
//             actions: [
//               Builder(builder: (context) {
//                 FavoriteModel? isFavorite;
//                 try {
//                   isFavorite = authVm.favorites.firstWhere(
//                       (element) => element.dogId == singleDogVM.dog!.dogId);
//                 } catch (e) {}
//
//                 return IconButton(
//                     onPressed: () {
//                       print(singleDogVM.dog!.dogId!);
//                       favoritePressed(isFavorite, singleDogVM.dog!.dogId!);
//                     },
//                     icon: Icon(
//                       Icons.favorite,
//                       color: isFavorite != null ? Colors.red : Colors.white,
//                     ));
//               })
//             ],
//           ),
//           backgroundColor: Color(0xFFf5f5f4),
//           body: Stack(children: [
//             Positioned(
//                 left: 0,
//                 right: 0,
//                 child: Container(
//                     width: double.maxFinite,
//                     //takes all available width
//                     height: MediaQuery.of(context).size.height / 2.2,
//                     decoration: BoxDecoration(
//                         image: DecorationImage(
//                             fit: BoxFit.cover,
//                             image: NetworkImage(widget.imageLink!))))),
//             Positioned(
//                 top: MediaQuery.of(context).size.width * 0.1,
//                 left: MediaQuery.of(context).size.width * 0.04,
//                 right: MediaQuery.of(context).size.width * 0.03,
//                 child: InkWell(
//                   child: Row(
//                     children: [
//                       AppIcon(icon: Icons.arrow_back),
//                     ],
//                   ),
//                   onTap: () {
//                     Navigator.of(context).pop("/SubPage");
//                     // MyConstants.holdNavigatePlaceDetails = null;
//                     // Navigator.of(context).pop("/SubPages");
//                   },
//                 )),
//             Positioned(
//                 left: 0,
//                 right: 0,
//                 bottom: 0,
//                 top: MediaQuery.of(context).size.height / 2.5,
//                 child: Container(
//                     padding: EdgeInsets.only(
//                       left: MediaQuery.of(context).size.height * 0.04,
//                       right: MediaQuery.of(context).size.height * 0.03,
//                       top: MediaQuery.of(context).size.height * 0.03,
//                     ),
//                     decoration: BoxDecoration(
//                         borderRadius: BorderRadius.only(
//                             topRight: Radius.circular(40),
//                             topLeft: Radius.circular(40)),
//                         color: Colors.white),
//                     child: Column(
//                         crossAxisAlignment: CrossAxisAlignment.start,
//                         children: [
//                           Text(
//                             "Personality",
//                             style: TextStyle(
//                               fontSize: 25,
//                               fontWeight: FontWeight.bold,
//                             ),
//                           ),
//                           SizedBox(
//                             height: 5,
//                           ),
//                           Expanded(
//                             child: SingleChildScrollView(
//                               child: ExpandableTextWidget(
//                                 Des_text: widget.dogDescription!,
//                               ),
//                             ),
//                           ),
//                           Center(
//                             child: AppColumn(
//                               Name: widget.dogName!,
//                               price: widget.price!,
//                               color: widget.color!,
//                               breed: widget.breed!,
//                             ),
//                           ),
//                           SizedBox(
//                             height: 15,
//                           ),
//                         ]))),
//           ]),
//           bottomNavigationBar: Container(
//               height: 75,
//               padding: EdgeInsets.all(20),
//               decoration: BoxDecoration(
//                   color: Color(0xfffcf4e4),
//                   borderRadius: BorderRadius.only(
//                     topLeft: Radius.circular(40),
//                     topRight: Radius.circular(40),
//                   )),
//               child: Align(
//                   alignment: Alignment.bottomCenter,
//                   child: Container(
//                     height: 100,
//                     child: Row(
//                       children: [
//                         Container(
//                           margin: EdgeInsets.only(left: 15),
//                           height: 50,
//                           width: 70,
//                           decoration: BoxDecoration(
//                             borderRadius: BorderRadius.circular(20),
//                             color: Color.fromRGBO(191, 134, 143, 30),
//                           ),
//                         ),
//                         Expanded(
//                             child: Container(
//                           margin: EdgeInsets.symmetric(horizontal: 15),
//                           height: 50,
//                           decoration: BoxDecoration(
//                             color: Color.fromRGBO(191, 134, 143, 30),
//                             borderRadius: BorderRadius.circular(20),
//                           ),
//                           child: Center(
//                             child: Text(
//                               "Adoption",
//                               style:
//                                   TextStyle(color: Colors.white, fontSize: 24),
//                             ),
//                           ),
//                         )),
//                       ],
//                     ),
//                   ))));
//     });
//   }
// }
