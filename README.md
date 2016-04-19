# Powershell-AptifyEventLogSearch

## Purpose
The Aptify Smart Client and EBusiness Website, by default, write exceptions to the Application Event Log.  When trouble arises, it can be difficult to peruse the Event Log if your system has many other Applications writing to this log as well.  Additionally, you may only be looking for Aptify Application Events from a particular user, or for instances of a particular exception type, or Aptify Events in a particular date range.

This script provides a way to filter the Application Event Logs down to the entries you are interested in.  The results include only the most pertitent information that will be useful in researching the issue.  It can be provided to Aptify Support when submitting a Support Ticket.

### Filters
* Provider Name (Source): Not editable, but all Providers that start with "Aptify*" are searched.
* Specific Dates - Only return results from a specific date range.  Larger ranges will take longer to process.
* Specific Phrases - Use * for wildcards.  This is not case sensitive.
    * example: field format error
    * example: field format error*AANP\jsikes

### Results
* To Console as XML
* To File as XML
* Files are stored on the currently logged in user's desktop in the following format:
    * example: AptifyErrorSearch_[username]_[filter]_[startDate]_[endDate].xml
