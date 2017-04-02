# Powershell-AptifyEventLogSearch

## Purpose
The Aptify Smart Client and EBusiness Website, by default, write exceptions to the Application Event Log.  When trouble arises, it can be difficult to peruse the Event Log if your system has many other Applications writing to this log as well.  Additionally, you may only be looking for Aptify Application Events from a particular user, or for instances of a particular exception type, or Aptify Events in a particular date range.

This script provides a way to filter the Application Event Logs down to the entries you are interested in.  The results include only the most pertitent information that will be useful in researching the issue.  It can be provided to Aptify Support when submitting a Support Ticket.

## Requirements
This script has been tested and utilized on the following environment:
* Windows Server 2012 R2 Standard Edition
* Powershell 4.0 and above (verified not working with Powershell 2.0)
   * [Verify your Powershell Version](http://stackoverflow.com/questions/1825585/determine-installed-powershell-version)
   * [Powershell Basics](https://msdn.microsoft.com/en-us/powershell/scripting/powershell-scripting)
   * [Set your Execution Policy](https://ss64.com/ps/set-executionpolicy.html) (My preference is RemoteSigned, but your needs may vary.)
   
## Usage
This script should be manually run by someone with access to the server on which Aptify or eBusiness resides.  A user can copy this script to their desktop, right click on it and choose "Run with Powershell".  Additionally, you can open a Powershell Console Window and locate the script for execution.

### Filters
* Provider Name (Source): Not editable, but all Providers that start with "Aptify*" are searched.
* Specific Dates - Only return results from a specific date range.  Larger ranges will take longer to process.
* Specific Phrases - Use * for wildcards.  This is not case sensitive.
    * example: field format error
    * example: field format error*user2

### Results
* To Console as XML
* To File as XML
* Files are stored on the currently logged in user's desktop in the following format:
    * example: `AptifyErrorSearch_[username]_[filter]_[startDate]_[endDate].xml`

### Sample Results
```
<Events>
  <Event>
    <DateTime>03/31/2017 18:13:15</DateTime>
    <Source>Aptify.ExceptionManagerPublishedException</Source>
    <EntryType>Error</EntryType>
    <Message><![CDATA[[
				        

General Information 

*********************************************

Additional Info:

ExceptionManager.MachineName: [REDACTED]

ExceptionManager.TimeStamp: 3/31/2017 6:13:15 PM

ExceptionManager.FullName: AptifyExceptionManagement, Version=4.0.0.0, Culture=neutral, PublicKeyToken=f3fa0ecabf9514d9

ExceptionManager.AppDomainName: Aptify Shell.exe

ExceptionManager.ThreadIdentity: 

ExceptionManager.WindowsIdentity: [REDACTED]



1) Exception Information

*********************************************

Exception Type: System.UnauthorizedAccessException

Message: Access to the path 'C:\Windows\TEMP\attributes.xml' is denied.

Data: System.Collections.ListDictionaryInternal

TargetSite: Void FileCopy(System.String, System.String)

HelpLink: NULL

Source: Microsoft.VisualBasic

HResult: -2147024891



StackTrace Information

*********************************************

   at Microsoft.VisualBasic.FileSystem.FileCopy(String Source, String Destination)

   at Aptify.Framework.AttributeManagement.XMLAttributeSource.a(String )

   at Aptify.Framework.AttributeManagement.XMLAttributeSource.a(String , NameValueCollection , IConvertible )

   at Aptify.Framework.AttributeManagement.XMLAttributeSource.PersistAttributeValue(Attribute AttributeToPersist, NameValueCollection ConfigSettings, IConvertible NewValue)

   at Aptify.Framework.AttributeManagement.AttributeManager.PersistAttributeValue(Attribute Attribute, IConvertible NewValue)

   at Aptify.Framework.LoginServices.AptifyConnectionState.SaveLastKnownState()

   at Aptify.Framework.AptifyShellForm.AptifyShellForm_FormClosing(Object sender, FormClosingEventArgs e)
			        ]]></Message>
  </Event>
</Events>
```
