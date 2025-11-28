public class Sum {
// 1) Instance Methods
	// A) Sum with 2 params
    public Integer sum(Integer a, Integer b){
        Integer c = a + b;
        System.debug('Sum with 2 params : '+c);
        return c;
    }
    
    // B) Sum with 3 params
    public Integer sum(Integer a, Integer b, Integer c1){
        Integer cs = a + b + c1;
        System.debug('Sum with 3 params : '+cs);
        return cs;
    }
    
    // C) Sum with 4 params
    public Integer sum(Integer a, Integer b, Integer c11, Integer d){
        Integer cs1 = a + b + c11 + d;
        System.debug('Sum with 4 params : '+cs1);
        return cs1;
    }
    
    //D) Sum with 5 params
    public void sum(Integer a, Integer b, Integer c11, Integer d, Integer e){
        Integer cs2 = a + b + c11 + d + e;
        System.debug('Sum with 5 params : '+cs2);
        //return cs2;
    }
    
    // E) Sum with 6 params
    public Integer sum(Integer a, Integer b, Integer c11, Integer d, Integer e, Integer f){
        Integer cs3 = a + b + c11 + d + e + f;
        System.debug('Sum with 6 params : '+cs3);
        return cs3;
    }
    
    // F) Sum with 7 params
    public Integer sum(Integer a, Integer b, Integer c11, Integer d, Integer e, Integer f , Integer g){
        Integer cs4 = a + b + c11 + d + e + f + g;
        System.debug('Sum with 7 params : '+cs4);
        return cs4;
    }
    
    // G) Sum with 8 params
    public Integer sum(Integer a, Integer b, Integer c11, Integer d, Integer e, Integer f , Integer g, Integer h){
        Integer cs5 = a + b + c11 + d + e + f + g + h;
        System.debug('Sum with 8 params : '+cs5);
        return cs5;
    }
    
    // G) Sum with 9 params
    public Integer sum(Integer a, Integer b, Integer c11, Integer d, Integer e, Integer f , Integer g, Integer h, Integer i){
        Integer cs6 = a + b + c11 + d + e + f + g + h + i;
        System.debug('Sum with 9 params : '+cs6);
        return cs6;
    }
    
    // H) Sum with 10 params
    public Integer sum(Integer a, Integer b, Integer c11, Integer d, Integer e, Integer f , Integer g, Integer h, Integer i, Integer j){
        Integer cs7 = a + b + c11 + d + e + f + g + h + i + j;
        System.debug('Sum with 10 params : '+cs7);
        return cs7;
    }
    
// 2) Static methods
	// A) Sum with 2 params
    public static Integer sumS(Integer a, Integer b){
        Integer s1 = a + b;
        System.debug('Static Sum with 2 params : '+s1);
        return s1;
    }
    
    // B) Sum with 3 params
    public static Integer sumS(Integer a, Integer b, Integer c1){
        Integer s10 = a + b + c1;
        System.debug('Static Sum with 3 params : '+s10);
        return s10;
    }
    
    // C) Sum with 4 params
    public static Integer sumS(Integer a, Integer b, Integer c11, Integer d){
        Integer s101 = a + b + c11 + d;
        System.debug('Static Sum with 4 params : '+s101);
        return s101;
    }
    
    // D) Sum with 5 params
    public static Integer sumS(Integer a, Integer b, Integer c11, Integer d, Integer e){
        Integer s2 = a + b + c11 + d + e;
        System.debug('Static Sum with 5 params : '+s2);
        return s2;
    }
    
    // E) Sum with 6 params
    public static Integer sumS(Integer a, Integer b, Integer c11, Integer d, Integer e, Integer f){
        Integer s20 = a + b + c11 + d + e + f;
        System.debug('Static Sum with 6 Params : '+s20);
        return s20;
    }
    
    // F) Sum with 7 params
    public static Integer sumS(Integer a, Integer b, Integer c11, Integer d, Integer e, Integer f , Integer g){
        Integer s201 = a + b + c11 + d + e + f + g;
        System.debug('Static Sum with 7 Params : '+s201);
        return s201;
    }
    
    // G) Sum with 8 params
    public static Integer sumS(Integer a, Integer b, Integer c11, Integer d, Integer e, Integer f , Integer g, Integer h){
        Integer s202 = a + b + c11 + d + e + f + g + h;
        System.debug('Static Sum with 8 Params : '+s202);
        return s202;
    }
    
    // H) Sum with 9 params
    public static Integer sumS(Integer a, Integer b, Integer c11, Integer d, Integer e, Integer f , Integer g, Integer h, Integer i){
        Integer s3 = a + b + c11 + d + e + f + g + h + i;
        System.debug('Static Sum with 9 Params : '+s3);
        return s3;
    }
    
    // I) Sum with 10 params
    public static Integer sumS(Integer a, Integer b, Integer c11, Integer d, Integer e, Integer f , Integer g, Integer h, Integer i, Integer j){
        Integer s30 = a + b + c11 + d + e + f + g + h + i + j;
        System.debug('Static Sum with 10 Params : '+s30);
        return s30;
    }
}