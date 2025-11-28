// @Np : 22-2-25 
// Constructor Assignement Panther School
public class Car {
    // Step 1 : The class should have the private variables
	private string name;
    private string model;
    private string year;
    private string company;
    private string TypeC;
    
    // Step 2 : Create multiple constructors that are accepting the different parameters
    public Car(String name , String TypeC){
        this.name = name;
        this.TypeC = TypeC;
        System.debug('Car Name is : '+name+' and Type is : '+TypeC);
    }
    
    public Car(String name){
        this.name = name;
        System.debug('Car Name is : '+name);
    }
    
    public Car(){
        System.debug('No Paramterziered Constructor Called');
    }
    
    public Car(String name, String model, String year, String company, String TypeC){
        this.name = name;
        this.model = model;
        this.year = year;
        this.company = company;
        this.TypeC = TypeC;
        System.debug('Car Name : '+name+' , model is : '+model+' , '+' year is : '+year+' , Company is : '+company+' , Type is : '+TypeC);
    }
}