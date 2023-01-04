#!/bin/bash

# Replace SOME_LIFELESS_RULE_NAME with the name of the NSG rule that you want to remove
RULE_NAME="SOME_LIFELESS_RULE_NAME"

# Get a list of all subscriptions
subscriptions=$(az account list --query "[].id" -o tsv)
echo -e "The NSG Rules in following subscriptions will be checked:\n$subscriptions"

# Initialize a counter
counter=0

# Get the total number of subscriptions
total=$(echo "$subscriptions" | wc -l)

# Iterate over the subscriptions
for subscription in $subscriptions; do
  # Set the subscription
  az account set --subscription "$subscription"

  # Get a list of all resource groups in the subscription
  resource_groups=$(az group list --query "[].name" -o tsv)

  # Iterate over the resource groups
  for resource_group in $resource_groups; do
    # Get a list of all NSGs in the resource group
    nsgs=$(az network nsg list --resource-group $resource_group --query "[].name" -o tsv)

    # Iterate over the NSGs
    for nsg in $nsgs; do
      # Try to delete the NSG rule. If it doesn't exist, ignore the error
      az network nsg rule delete --resource-group $resource_group --nsg-name $nsg --name $RULE_NAME || true
    done
  done

  # Increment the counter
  counter=$((counter+1))

  # Print a progress message
  echo "$counter/$total subscriptions processed"
done

echo "Done!"