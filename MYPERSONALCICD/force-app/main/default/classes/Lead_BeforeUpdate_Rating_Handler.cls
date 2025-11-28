/* @Nilisha Patil - 10-9-24 :  On Lead - Before Update
●	Lead rating should be changed based on the Annual revenue of the Company
a. 1-10000	–	Cold
b.  10001-50000	–	Warm
c. 50001-100000 –	Hot
*/
public class Lead_BeforeUpdate_Rating_Handler {
    public static void ratingChangedOnAnnual(List<Lead> lisLead){
        if(!lisLead.isEmpty()){
            for(Lead lea : lisLead){
                if(lea.AnnualRevenue!= NULL){
                    if(lea.AnnualRevenue >= 1 && lea.AnnualRevenue<=10000){
                        lea.Rating = 'Cold';
                    }
                    else if(lea.AnnualRevenue >= 10001 && lea.AnnualRevenue<=50000){
                        lea.Rating = 'Warm';
                    }
                    else if(lea.AnnualRevenue >= 50001 && lea.AnnualRevenue<=100000){
                        lea.Rating = 'Hot';
                    }
                }
            }
        }
    }
}