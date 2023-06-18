 import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shopapp/network/local/cache_helper.dart';
import 'package:shopapp/shared/components/components.dart';
import 'package:shopapp/shop_login_screen.dart';
import 'package:shopapp/styles/colors.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

import 'network/local/cache_helper.dart';


class BoardingModel{
  final String? image;
  final String? title;
  final String? body;
  BoardingModel({
    @required this.title,
    @required this.image,
    @required this.body,
});
}

class OnBoardingScreen extends StatefulWidget {
   OnBoardingScreen({Key? key}) : super(key: key);

  @override
  State<OnBoardingScreen> createState() => _OnBoardingScreenState();
}

class _OnBoardingScreenState extends State<OnBoardingScreen> {
   bool isLast = false;

   void submit() {
     CacheHelper.saveData(key: 'onBoarding',
         value: true).then((value) {
       Navigator.pushAndRemoveUntil(
         context,
         MaterialPageRoute(
           builder:(context)=> ShopLoginScreen(),
         ),
             (route)=> false,
       );
     });
   }

   var boardController = PageController();

  List<BoardingModel> boarding =[
    BoardingModel(
      image: 'assets/images/onboard_1.jpg',
      title: 'On Board 1 Title',
      body:  'On Board 1 body'
    ),
    BoardingModel(
      image: 'assets/images/onboard_1.jpg',
      title: 'On Board 2 Title',
      body:  'On Board 2 body'
    ),
    BoardingModel(
      image: 'assets/images/onboard_1.jpg',
      title: 'On Board 3 Title',
      body:  'On Board 3 body'
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          TextButton(onPressed: (){
             submit();
          },child: Text(
            'SKIP',
          ),)
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(30),
        child: Column(
            children: [
              Expanded(

                child: PageView.builder(
                  controller: boardController,
                  physics: BouncingScrollPhysics(),
                  onPageChanged: (index){
                    if(index == boarding.length-1)
                      {
                        setState((){
                          isLast = true;
                        });
                      }else
                        {
                          setState((){
                            isLast=false;
                          });
                        }
                  },
                  itemBuilder: (context, index) => buildBoardingIten(boarding[index]),
                  itemCount: boarding.length,

                ),
              ),
              SizedBox(
                height:40,
              ),

              Row(
                children: [
                  SmoothPageIndicator(
                    controller:boardController ,
                    effect: ExpandingDotsEffect(
                      dotColor: Colors.grey,
                      activeDotColor: defaultColor,
                      dotHeight: 10,
                      expansionFactor: 4,
                      spacing: 5,
                    ),
                    count: boarding.length,
                  ),
                  Spacer(),
                  FloatingActionButton(
                    onPressed: ()
                    {
                      if(isLast)
                        {
                           submit();
                          // Navigator.pushAndRemoveUntil(
                          //   context,
                          //   MaterialPageRoute(
                          //     builder:(context)=> ShopLoginScreen(),
                          //   ),
                          //       (route)=> false,
                          // );
                        } else
                          {
                            boardController.nextPage(
                              duration: Duration(
                                milliseconds: 750,
                              ),
                              curve: Curves.fastLinearToSlowEaseIn,
                            );
                          }

                    },
                  child: Icon(
                    Icons.arrow_forward_ios,
                  ),
                  )
                ],
              ),
            ]

        ),
      ),
    );
  }

  Widget buildBoardingIten(BoardingModel model) => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: Image(
              image: AssetImage('${model.image}'),
            ),
          ),
          SizedBox(
            height: 30,),
          Text(
            '${model.title}',
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(
            height: 15,),
          Text(
            '${model.body} ',
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(
            height: 15,),
        ],
      );
}
