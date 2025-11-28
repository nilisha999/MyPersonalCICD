// - a) Calculate Area and Perimeter of Square
// Area of Square = Square(a); Perimeter = 4a
public class Day32_SanjayGupta_Self {
	Decimal a2 = 5;
    Decimal b;
    //    - 1) Using non-static method
    /*public void areaOfSquare(){
        Decimal AOS = a *a ;
        System.debug('Area Of Square = '+AOS);
    }
    Public void perimeterOfSquare(){
        Decimal POS = 4 * a;
        System.debug('Peri of Square= '+POS);
    }*/
    // - 2) Using non-static method and Constructor
    /*public Day32_SanjayGupta_Self(){
         b = 50;
    }
    public void areaOfSquare2(){
        Decimal AOS2 = b *b ;
        System.debug('Area Of Square = '+AOS2);
    }
    Public void perimeterOfSquare2(){
        Decimal POS2 = 4 * b;
        System.debug('Peri of Square= '+POS2);
    }*/
    // 3) Using Static Method
    /*public static void areaOfSq3(){
        Decimal a2 = 5;
        Decimal SResult = a2 *a2;
        System.debug('Static area of Sqaure = '+ SResult);
    }
    public static void periOfSq3(){
        Decimal a3 = 10;
        Decimal SResult1 = a3 *a3;
        System.debug('Static peri of Sqaure = '+ SResult1);
    }*/
    // 4) Using Static Method by passing parameters to method
    public static void areaOfSq4(Decimal a2, Decimal b){
        Decimal SResult4 = a2 *a2;
        System.debug('Static with Parameter area of Sqaure = '+ SResult4);
    }
    public static void periOfSq4(Decimal a3, Decimal b){
        Decimal SResult14 = a3 *a3;
        System.debug('Static with Parameter peri of Sqaure = '+ SResult14);
    }
}