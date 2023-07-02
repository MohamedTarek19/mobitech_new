import 'package:flutter/material.dart';
import 'package:flutter_background_service/flutter_background_service.dart';
import 'package:mobitech/business_logic/model/tips.dart';
import 'package:mobitech/business_logic/view_model/account_vm.dart';
import 'package:mobitech/business_logic/view_model/work_orders_vm.dart';
import 'package:mobitech/data_layer/localdata/localdata.dart';
import 'package:mobitech/theme/appthrmr.dart';
import 'package:mobitech/utils/navigation.dart';
import 'package:mobitech/view/accounts/login.dart';
import 'package:mobitech/view/emp_landing_page.dart';
import 'package:mobitech/view/landing_page.dart';
import 'package:mobitech/view/maintance/mhelper.dart';
import 'package:mobitech/view/maintance/test2.dart';
import 'package:mobitech/view/notify/status_updater.dart';
import 'package:mobitech/view/tips/page_tips.dart';
import 'package:mobitech/widgets/custom_button.dart';
import 'package:mobitech/widgets/main_container.dart';
import 'package:mobitech/widgets/text_button.dart';
import 'package:provider/provider.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class LandingTips extends StatefulWidget {
  const LandingTips({Key? key}) : super(key: key);

  @override
  State<LandingTips> createState() => _LandingTipsState();
}

class _LandingTipsState extends State<LandingTips> {
  var service = FlutterBackgroundService();

  int currentIndex = 0;
  var tips = [
    PageTips(
        pageTips: Tips(
            title: "حدد اختيارك واطلب الان",
            imagepath: "assets/a.png",
            description: "يمكنك اختيار افضل المنتجات")),
    PageTips(
        pageTips: Tips(
            title: "حدد مكان التسليم",
            imagepath: "assets/b.png",
            description:
                "حدد موقعك من خريطة جوجل و احصل على المنتج عند المنزل")),
    PageTips(
        pageTips: Tips(
            title: "التوصيل الى منزلك",
            imagepath: "assets/c.png",
            description: "احصل على توصيل المنتج وادفع عبر الانترنت و استمتع")),
  ];
  PageController pageController = PageController();
  checkSocialLogin(BuildContext context,AccountVM _acountVm) async{
    var service = FlutterBackgroundService();

    final _workOrdersVm = Provider.of<WorkOrdersVM>(context, listen: false);
    showDialog(context: context, builder: (context){
      return const Center(child: CircularProgressIndicator());
    });
    var _prefs =await sharedPreferences;
    String user = await _prefs.getString('user')?? '0';
    print(user);
    var userM = await _acountVm.login(user);
    String email = await _prefs.getString('email')?? '';
    print(email);
    String acctype =await _prefs.getString('account_type')??'';
    print(acctype);
    if(userM != null && user != '0'){
      String name = userM.aname??'';
      print(name);
      if(email == userM.agoogle || email == userM.aface || name.toLowerCase() == user){
        await _prefs.setString("Userid", userM.id.toString());
        print(_prefs.getString("Userid"));
        print('#########################################\nlanding');
        await StatusUtils.SaveStatusList(_workOrdersVm, _prefs);
        print(_workOrdersVm.orders?.length??0);
        StatusUtils.inLanding = true;
        service.startService();

        Navigation.puchReplace(const LandingPage(), context);
      }else{
        // service.invoke("stopService");
        await _prefs.clear();
        Navigator.of(context).pop();
        Navigation.puchReplace(const LoginScreen(), context);}
    }else{
      service.invoke("stopService");
      Navigator.of(context).pop();
      print("is cleared = ${await _prefs.clear()}");
      Navigation.puchReplace(const LoginScreen(), context);
    }

  }

  @override
  Widget build(BuildContext context) {
    // "stopService"
    service.invoke("stopService");
    final _acountVm = Provider.of<AccountVM>(context, listen: false);
    return MainContainer(
        padding: AppTheme.paddingall,
        widget: Scaffold(
          body: SafeArea(
            child: Column(mainAxisAlignment: MainAxisAlignment.center,
                children: [
              Align(
                alignment: Alignment.centerLeft,
                child: TextBtn(
                    text: "تخطي",
                    action: () {
                      // SavedLocalData savedLocalData = SavedLocalData();
                      // savedLocalData.setTipsViewed(false);
                      checkSocialLogin(context,_acountVm);
                    }),
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
                                SavedLocalData savedLocalData = SavedLocalData();
                                savedLocalData.setTipsViewed(false);
                                print('in landing');
                                 checkSocialLogin(context,_acountVm);

                                //Navigation.puchReplace(const LoginScreen(), context);
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
