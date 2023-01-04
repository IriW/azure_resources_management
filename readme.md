# Remove all NSG rules with specified name in all subscriptions
## This script does the following:
1. Loops through all subscriptions users has access to.
2. Finds all NSG rules with the specified name from each NSG it finds.
3. Removes all the rulles with the name specified.
4. The progress of tasks accomplishments is printed in console as it goes along.
5. Ignores errors and continues processing.

## Prerequisites
### If executed on local environment:
1. Azure CLI must be installed locally. 
2. Your account must have assigned `Network contributor` or `Contributor` role.
2. Authenticate your user with `az login`.

### Alternatively:
1. Sign in to Azure Portal
2. Your account must have assigned `Network contributor` or `Contributor` role.
3. Run the script via MS Azure Cloud Shell.

> **_NOTE:_**  This script is tested with Azure CLI version 2.43.0. To check yours run `az version`.