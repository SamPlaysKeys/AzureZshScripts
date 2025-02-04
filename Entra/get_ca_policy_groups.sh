#!/bin/bash

# This script is created on MacOS using ZSH, and has not been tested on Windows or Linux.

# Function to display help/usage information
show_help() {
    echo "Usage: $0 [OPTIONS]"
    echo "Extract group information from Azure Conditional Access policies"
    echo
    echo "Options:"
    echo "  -p, --policy NAME    Specify a policy name to filter (optional)"
    echo "  -h, --help           Display this help message"
    exit 1
}

# Function to check if az cli is installed and user is logged in
check_prerequisites() {
    if ! command -v az >/dev/null 2>&1 || ! az account show >/dev/null 2>&1; then
        echo "Error: Azure CLI is not installed or you're not logged in to Azure"
        echo "Please ensure az cli is installed and run 'az login'"
        exit 1
    fi
}

# Function to get conditional access policies
get_policies() {
    local policy_name=$1
    local policies

    if [ -n "$policy_name" ]; then
        policies=$(az rest --method GET --uri "https://graph.microsoft.com/v1.0/identity/conditionalAccess/policies" | \
                jq -r ".value[] | select(.displayName == \"$policy_name\")")
    else
        policies=$(az rest --method GET --uri "https://graph.microsoft.com/v1.0/identity/conditionalAccess/policies" | \
                jq -r '.value[]')
    fi

    if [ -z "$policies" ]; then
        echo "No policies found"
        exit 1
   fi

    echo "$policies"
}

# Function to extract group IDs from policy conditions
extract_group_ids() {
    local policy="$1"
    echo "$policy" | jq -r '.conditions.users.includeGroups[]?' 2>/dev/null
}

# Function to get group details and members
get_group_details() {
    local group_id="$1"
    local group_name

    # Get group name
    group_name=$(az ad group show --group "$group_id" --query displayName -o tsv 2>/dev/null)
    if [ -z "$group_name" ]; then
        echo "Unable to fetch group name for ID: $group_id"
        return
    else
        echo "Group Name: $group_name"
    fi

    # Get group members
    local members
    members=$(az ad group member list --group "$group_id" --query "[].displayName" -o tsv)
    
    # echo "Group Name: $group_name" - testing calling from the earlier check to avoid the delay while searching members
    if [ -n "$members" ]; then
        echo "Members:"
        echo "$members" | sed 's/^/  - /'
    else
        echo "No members found"
    fi
    echo
}

# check cli argument inputs
while [[ $# -gt 0 ]]; do
    case $1 in
        -h|--help)
            show_help
            ;;
        -p|--policy)
            policy_name="$2"
            shift 2
            ;;
        *)
            echo "Unknown option: $1"
            show_help
            ;;
    esac
done

# Main start point 
check_prerequisites

# Get policies
echo "Fetching conditional access policies..."
policies=$(get_policies "$policy_name")

# Process each policy
echo "$policies" | jq -c '.' | while read -r policy; do
    policy_name=$(echo "$policy" | jq -r '.displayName')
    echo "Policy: $policy_name"
    echo "----------------------------------------"

    # extract and process group IDs
    group_ids=$(extract_group_ids "$policy")
    if [ -n "$group_ids" ]; then
        echo "$group_ids" | while read -r group_id; do
            [ -n "$group_id" ] && get_group_details "$group_id"
        # echo "$group_ids" - useful for testing raw output while running, but leave commented for cleaner output.
        done
    else
        echo "No groups found in policy"
    fi
    echo "========================================"
    echo
done

