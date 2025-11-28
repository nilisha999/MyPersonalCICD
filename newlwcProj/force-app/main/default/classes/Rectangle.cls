public class Rectangle {
    /* Golbal Variable
    Decimal length, breath;
    
    //A) Parameterized Constructors
    public Rectangle(Decimal len, Decimal bre){
        length = len;
        breath = bre;
    }
    
	//Method 1
    public void area(){
        Decimal a = length * breath;
        System.debug('Area = '+a);
    }
    
    // Method 2
    Public void perimeter(){
        Decimal p = 2 * (length + breath);
        System.debug('Sum of Perimeter = '+ p);
    }*/
    // Static Method 
    // (a)
    public static void area(){
        Decimal len = 5.56 , breath = 78;
        Decimal k = len * breath;
        System.debug('Area = '+k);
    }
    public static void peri(){
        Decimal len2 = 4.5, b = 6;
        Decimal g = 5* (len2 + b);
        System.debug('Perimeter = '+g);
    }
}