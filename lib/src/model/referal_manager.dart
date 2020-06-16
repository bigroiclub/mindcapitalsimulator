class ReferalManager {
  double level_1 = 0;
  double level_2 = 0;
  double level_3 = 0;
  double level_4 = 0;
  double level_5 = 0;
  double level_6 = 0;
  double level_7 = 0;
  double level_8 = 0;
  double level_9 = 0;
  double level_10 = 0;

  get total => level_1 + level_2  + level_3  + level_4  + level_5  + level_6  + level_7  + level_8  + level_9  + level_10;

/*
Para calcular los beneficios se utiliza la tabla de porcentajes siguiente:
Level 1: 8%
Level 2: 4%
Level 3: 3%
Level 4: 3%
Level 5: 2%
Level 6: 2%
Level 7: 2%
Level 8: 2%
Level 9: 2%
Level 10: 2%
*/
  double profit(double porcGanancias, double porcInversor) {
    return ( ( ( level_1 * porcGanancias ) / 100 ) * ( porcInversor / 100 ) ) * 0.08 + 
           ( ( ( level_2 * porcGanancias ) / 100 ) * ( porcInversor / 100 ) ) * 0.04 + 
           ( ( ( level_3 * porcGanancias ) / 100 ) * ( porcInversor / 100 ) ) * 0.03 + 
           ( ( ( level_4 * porcGanancias ) / 100 ) * ( porcInversor / 100 ) ) * 0.03 + 
           ( ( ( level_5 * porcGanancias ) / 100 ) * ( porcInversor / 100 ) ) * 0.02 + 
           ( ( ( level_6 * porcGanancias ) / 100 ) * ( porcInversor / 100 ) ) * 0.02 + 
           ( ( ( level_7 * porcGanancias ) / 100 ) * ( porcInversor / 100 ) ) * 0.02 + 
           ( ( ( level_8 * porcGanancias ) / 100 ) * ( porcInversor / 100 ) ) * 0.02 + 
           ( ( ( level_9 * porcGanancias ) / 100 ) * ( porcInversor / 100 ) ) * 0.02 + 
           ( ( ( level_10 * porcGanancias ) / 100 ) * ( porcInversor / 100 ) ) * 0.02 ;
  }

  clear(){
    level_1 = level_2 = level_3 = level_4 = level_5 = level_6 = level_7 = level_8 = level_9 = level_10 = 0;
  }
}