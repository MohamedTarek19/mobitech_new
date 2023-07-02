import 'package:flutter/material.dart';
import 'package:mobitech/business_logic/model/tips.dart';
import 'package:mobitech/business_logic/view_model/account_vm.dart';
import 'package:mobitech/data_layer/localdata/localdata.dart';
import 'package:mobitech/theme/appthrmr.dart';
import 'package:mobitech/utils/navigation.dart';
import 'package:mobitech/view/accounts/login.dart';
import 'package:mobitech/view/emp_landing_page.dart';
import 'package:mobitech/view/landing_page.dart';
import 'package:mobitech/view/maintance/mhelper.dart';
import 'package:mobitech/view/maintance/test2.dart';
import 'package:mobitech/view/tips/page_tips.dart';
import 'package:mobitech/widgets/custom_button.dart';
import 'package:mobitech/widgets/main_container.dart';
import 'package:mobitech/widgets/text_button.dart';
import 'package:provider/provider.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class MaintTips extends StatefulWidget {
  const MaintTips({Key? key}) : super(key: key);

  @override
  State<MaintTips> createState() => _MaintTipsState();
}

class _MaintTipsState extends State<MaintTips> {
  int currentIndex = 0;
  var tips = [
    PageTips(
        pageTips: Tips(
            title: "حدد اختيارك واطلب الان",
            imagepath: "assets/a.png",
            description: "يمكنك اختيار افضل الخدمات")),
    PageTips(
        pageTips: Tips(
            title: "حدد موقعك",
            imagepath: "assets/b.png",
            description:
            "حدد موقعك من خريطة جوجل و احصل على الخدمة عند المنزل")),
    PageTips(
        pageTips: Tips(
            title: "الخدمة تصل الى منزلك",
            imagepath: "assets/c.png",
            description: "اطلب خدمتك لتصل إلى منزلك وادفع عبر الانترنت و استمتع")),
  ];
  PageController pageController = PageController();
  checkSocialLogin(BuildContext context,var _acountVm) async{
    var _prefs =await sharedPreferences;

    String user = await _prefs.getString('user')?? '0';
    print(user);
    var userM = await _acountVm.login(user);
    String email = await _prefs.getString('email')?? '';
    print(email);
    String acctype =await _prefs.getString('account_type')??'';
    print(acctype);
    if(userM != null && user != '0'){
      if(email == userM.agoogle || email == userM.aface){
        print('#########################################\nlanding');
        Navigation.puchReplace(const LandingPage(), context);
      }else{Navigation.puchReplace(const LoginScreen(), context);}

    }else{
      Navigation.puchReplace(const LoginScreen(), context);
    }
  }

  @override
  Widget build(BuildContext context) {
    final _acountVm = Provider.of<AccountVM>(context, listen: false);
    return MainContainer(
        padding: AppTheme.paddingall,
        widget: Scaffold(
          body: SafeArea(
            child: Column(mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Align(
                        alignment: Alignment.centerLeft,
                        child: TextBtn(
                            text: "تخطي",
                            action: () {
                              Navigation.puchReplace(MaintanceTest2(), context);
                            }),
                      ),
                      Align(
                        alignment: Alignment.centerRight,
                        child: TextBtn(
                            text: "الصفحة الرئيسية",
                            action: () {
                              if(MHelper.isInEmp == true){
                                Navigator.pop(context);
                                Navigation.puchReplace(LandingPage_emp(), context);
                              }else{
                                Navigator.pop(context);
                                Navigation.puchReplace(LandingPage(), context);
                              }

                            }),
                      ),
                    ],
                  ),

                  
                  Expanded(
                    child: PageView(
                      controller: pageController,
                      children: tips,
                      onPageChanged: (index) {
                        print(index);

                        setState(() {
                          currentIndex = index;
                        });
                      },
                    ),
                  ),
                  const SizedBox(height: 20,),
                  SmoothPageIndicator(
                    controller: pageController,
                    count: tips.length,
                    onDotClicked: (index) {
                      pageController.animateToPage(index,
                          duration: const Duration(seconds: 1), curve: Curves.ease);
                      setState(() {
                        currentIndex = index;
                      });
                      print(pageController.initialPage);
                    },
                    effect: SlideEffect(
                        radius: 1,
                        dotHeight: 7,
                        dotWidth: 7,
                        spacing: 15,
                        dotColor: AppTheme.secondColor.withOpacity(.9),
                        activeDotColor: AppTheme.mainColor),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      currentIndex > 0
                          ? Expanded(
                          child: TextBtn(
                              text: "السابق",
                              action: () {
                                if (currentIndex > 0) {
                                  currentIndex--;
                                  pageController.animateToPage(currentIndex,
                                      duration: const Duration(seconds: 1),
                                      curve: Curves.ease);
                                }
                              }))
                          : Expanded(child: Container()),
                      currentIndex == 2
                          ? Expanded(
                          child: CustomBtn(
                              name: "بدا",
                              action: () {
                                Navigation.puchReplace(MaintanceTest2(), context);
                              }))
                          : Expanded(child: Container()),
                      currentIndex == 2
                          ? Expanded(child: Container())
                          : Expanded(
                          child: TextBtn(
                              text: "التالي",
                              action: () {
                                if (currentIndex < 2) {
                                  currentIndex++;
                                  pageController.animateToPage(currentIndex,
                                      duration: const Duration(seconds: 1),
                                      curve: Curves.ease);
                                }
                              })),
                    ],
                  )
                ]),
          ),
        ));
  }
}
