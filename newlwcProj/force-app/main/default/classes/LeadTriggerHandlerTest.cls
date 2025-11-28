@isTest
public class LeadTriggerHandlerTest {
	@isTest
	static void testHandleBeforeInsert_LeadSourceWithWeb(){
		// Step 1 : Create test lead record
		Lead testLead = new Lead(
					LeadSource = 'Web',
					Status = 'Open - Not Contacted',
					LastName = 'Test Nilisha Lead'
				);
		//Step 2 : Insert Test Lead
		insert testLead;
		
		//Step 3 : Retrieve inserted testLead
		Lead insertedLead = [SELECT Rating From Lead Where Id =: testLead.Id];

		// Step 4 : verify the inserted data is correctly set
		System.assertEquals('Cold', insertedLead.Rating);
	}

	@isTest
	static void testHandleBeforeInsert_LeadSourceWithoutWeb(){
		//Step 1 : Create test Lead record
		Lead testLeadDiff = new Lead(
					LeadSource = 'Other',
					Status = 'Open - Not Contacted',
					LastName = 'Test Nilisha LeadDiff'
				);
		// Step 2 : Insert Test Lead
		insert testLeadDiff;

		// Step 3 : Retrieve inserted testLeadDiff
		Lead insertedLeadDiff = [SELECT Rating FROM Lead WHERE Id =: testLeadDiff.Id];

		// Step 4 : Verify the inserted data correctly set
		System.assertEquals('Hot', insertedLeadDiff.Rating);
	}

}