New-AzResourceGroup -Name Dev-Pels-02 -Location "West Europe"
New-AzResourceGroupDeployment -ResourceGroupName Dev-Pels-02 -TemplateFile main.bicep -Confirm -verbose

Select-AzSubscription fffb0c65-e90a-4b5d-adac-a5d6d399e2cc
New-AzResourceGroup -Name Dev-Pels-02 -Location "West Europe" 