
import 'package:get/get.dart';


class QuijoteController extends GetxController {
  RxDouble cordinateX = 2650.0.obs;
  RxDouble cordinateY = 2225.0.obs;

  RxBool rompeUno = false.obs;
  RxBool rompeDos = false.obs;
  RxBool rompeTres = false.obs;

  RxBool moleUno = false.obs;
  RxBool moleDos = false.obs;
  RxBool moleTres = false.obs;

  RxBool quizUno = false.obs;
  RxBool quizDos = false.obs;
  RxBool quizTres = false.obs;


  changeCoordinateX(double xd){
    cordinateX.value = xd;
    update();
  }

  changeCoordinateY(double xd){
    cordinateY.value = xd;
    update();
  }

  changeRompeUno(bool xd){
    rompeUno.value = xd;
  }
  changeRompeDos(bool xd){
    rompeDos.value = xd;
  }
  changeRompeTres(bool xd){
    rompeTres.value = xd;
  }

  changeMoleUno(bool xd){
    moleUno.value = xd;
  }
  changeMoleDos(bool xd){
    moleDos.value = xd;
  }
  changeMoleTres(bool xd){
    moleTres.value = xd;
  }

  changeQuizUno(bool xd){
    quizUno.value = xd;
  }
  changeQuizDos(bool xd){
    quizDos.value = xd;
  }
  changeQuizTres(bool xd){
    quizTres.value = xd;
  }

}