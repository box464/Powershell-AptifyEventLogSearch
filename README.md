#Powershell-AptifyEventLogSearch

##Purpose
The Aptify Smart Client and EBusiness Website, by default, write exceptions to the Application Event Log.  When trouble arises, it can be difficult to peruse the Event Log if your system has many other Applications writing to this log as well.  Additionally, you may only be looking for Aptify Application Events from a particular user, or for instances of a particular exception type.

This script provides a way to filter the Application Event Logs down to the entries you are interested in.  The results include only the most pertitent information that will be useful in researching the issue.  It can be provided to Aptify Support when submitting a Support Ticket.

Ability to export to XML file, or view results in the console.
