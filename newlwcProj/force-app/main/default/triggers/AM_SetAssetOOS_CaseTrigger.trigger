/*

Copyright (c) 2011, salesforce.com, Inc.
All rights reserved.

Redistribution and use in source and binary forms, with or without modification, 
are permitted provided that the following conditions are met:

    * Redistributions of source code must retain the above copyright notice, 
    this list of conditions and the following disclaimer.
    * Redistributions in binary form must reproduce the above copyright notice, 
    this list of conditions and the following disclaimer in the documentation 
    and/or other materials provided with the distribution.
    * Neither the name of the salesforce.com, Inc. nor the names of its contributors 
    may be used to endorse or promote products derived from this software 
    without specific prior written permission.

THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS" AND 
ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED 
WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE DISCLAIMED. 
IN NO EVENT SHALL THE COPYRIGHT HOLDER OR CONTRIBUTORS BE LIABLE FOR ANY DIRECT, 
INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, 
BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, 
DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF 
LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING NEGLIGENCE 
OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS SOFTWARE, EVEN IF ADVISED 
OF THE POSSIBILITY OF SUCH DAMAGE.

*/
/*Description: Set case asset as OOS if requested on case.
*---------------------------------------------------------------------------
*     Date     |        Description                |
*---------------------------------------------------------------------------
*  06/24/2014      Created Trigger to set asset as out of service if requested
*   by on case edit / insert.
*/

trigger AM_SetAssetOOS_CaseTrigger on Case (after insert, after update) {
    List<Case> cases = [Select Id, AM_Asset__c, AM_Mark_Asset_as_out_of_service__c from Case where Id IN: Trigger.new];
    List<Id> assetIdList = new List<Id>();
    List<AM_Asset__c> assetList = new List<AM_Asset__c>();

    For (Case c : cases) {
        if (c.AM_Mark_Asset_as_out_of_service__c == true) {
            assetIdList.add(c.AM_Asset__c);
        }
    }

    if (!assetIdList.isEmpty()) {
        AssetList = [Select Id, AM_Out_of_service__c from AM_Asset__c where Id IN: assetIdList];
        for (AM_Asset__c asset : assetList) {
            asset.AM_Out_of_service__c = true;
        }
        update assetList;
    }
}