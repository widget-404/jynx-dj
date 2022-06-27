import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:jynx_dj/screens/events/event_screen.dart';
import 'package:jynx_dj/services/contract_service.dart';
import 'package:jynx_dj/widgets/customizebutton.dart';
import 'package:shared_preferences/shared_preferences.dart';
class ContractScreen extends StatefulWidget {
  const ContractScreen({ Key? key }) : super(key: key);

  @override
  State<ContractScreen> createState() => _ContractScreenState();
}

class _ContractScreenState extends State<ContractScreen> {

  String contract = "";
  bool loadData = false;

  @override
  void initState() {
    
    super.initState();

    getContract();
  }
  
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          child: Container(
            width: size.width,
            height: size.height,
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                  colors: [
                      Color(0xFF1B5BA1),
                      Color(0xFF011021)
                    ],
                    begin: Alignment.center,
                    end: Alignment.bottomCenter
                  ),
            ),
            child: loadData ? const Center(
              child: CircularProgressIndicator(
                color: Color(0xFF6BEAEC),
              ),
            ) 
            : Padding(
              padding:  EdgeInsets.only(top: size.height*0.04,left: size.width*0.075,
              right: size.width*0.075),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SvgPicture.asset('images/back.svg'),
                  SizedBox(
                    height: size.height*0.03,
                  ),
                  Text("Agreement",
                  style: GoogleFonts.montserrat().copyWith(
                    color: Colors.white,
                    fontSize: 30,
                    fontWeight: FontWeight.bold
                  )
                  ,),
                  SizedBox(
                    height: size.height*0.05,
                  ),

                  Text(contract,style: GoogleFonts.montserrat().copyWith(
                    color: Colors.white,
                    fontSize: 12.5
                  ),
                  ),
                  SizedBox(
                    height: size.height*0.05,
                  ),
                  Padding(
                    padding:  EdgeInsets.only(left: size.width*0.12),
                    child: CustomizeButton(onpress: (){
                      // Get.snackbar("End of this Build", "Further Functionality in Next Build",
                      //      snackPosition: SnackPosition.BOTTOM,
                      //      backgroundColor: const Color(0xFF6BEAEC),
                      //     duration: const Duration(seconds: 3) );
                      //Get.to(const EventScreen());
                      acceptContract(size);
                    }, 
                    title: "I Agree"),
                  )

                ],
              ),
            ),
          ),
        ),
      ),
      );
  }

  void getContract () async{
    setState(() {
      loadData = true;
    });
    String result = await ContractService().getContract();
    setState(() {
      contract = result;
      loadData = false;
    });
  }

  void acceptContract (Size size) async{
    setState(() {
      loadData = true;
    });
    SharedPreferences prefs =  await SharedPreferences.getInstance();
    var result = await ContractService().acceptContract(prefs.getString('user_id').toString());
    if (result == "error")
    {
      error("Error occured while accepting the Agreement, please try again", size);
      setState(() {
        loadData = false;
      });
    }
    else {
      await prefs.setString("agreement", "accept");
      Get.offAll(const EventScreen());
      setState(() {
        loadData = false;
      });
    }
  }

  
  error (String discription, Size size) {
    return AwesomeDialog(
      context: context,
      headerAnimationLoop: false,
      dialogType: DialogType.ERROR,
      showCloseIcon: true,
      animType: AnimType.BOTTOMSLIDE,
      body: Container(
        width: size.width,
        padding: const EdgeInsets.symmetric(horizontal: 20,vertical: 30),
        child: Column(
          children: [
            Text(discription,
            style: GoogleFonts.montserrat().copyWith(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: Colors.black
            ),
            ),
          ],
        ),
      )
       
      ).show();
  }

}