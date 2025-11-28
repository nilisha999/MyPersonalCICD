public class AccountPreventTriggerDispatcher {
    public static void handleEvents(System.TriggerOperation operationType){
        Switch on operationType{
            WHEN BEFORE_INSERT{
                AccountPreventTriggerDispatcherHandler.handleBeforeInsert(Trigger.New);
            }
            WHEN BEFORE_UPDATE{
                //AccountPreventTriggerDispatcherHandler.handleBeforeInsert(Trigger.New);
            }
             // When No of Locations field Updated on Account Creation, Then Create LOcation Record related to Account
            WHEN AFTER_INSERT{
                AccountPreventTriggerDispatcherHandler.handleAfterInsert(Trigger.New);
            }
            // When No of Locations field Updated on Account UPDATED, Then Create LOcation Record related to Account
            WHEN AFTER_UPDATE{
                AccountPreventTriggerDispatcherHandler.handleAfterUpdate((List<Account>)Trigger.New, (Map<Id,Account>)Trigger.oldMap);
                AccountPreventTriggerDispatcherHandler.handleAfterDelete(Trigger.old);
            }
            // prevent account from deletion if accounthaving contact more than 2 contacts
            WHEN BEFORE_DELETE{
                AccountPreventTriggerDispatcherHandler.handleAfterDelete(Trigger.old);
            }
        }
    }
}