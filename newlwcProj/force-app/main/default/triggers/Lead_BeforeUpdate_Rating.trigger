/* @Nilisha Patil - 10-9-24 :  On Lead - Before Update
●   Lead rating should be changed based on the Annual revenue of the Company
a. 1-10000  –   Cold
b.  10001-50000 –   Warm
c. 50001-100000 –   Hot
*/
trigger Lead_BeforeUpdate_Rating on Lead (before update) {
    Lead_BeforeUpdate_Rating_Handler.ratingChangedOnAnnual(Trigger.New);
}