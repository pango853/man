
# Pricing

REF: https://azure.microsoft.com/en-us/pricing/details/openshift/

## Minimal cluster

SKU: D4s v3 (4, vCPUs 16 GiB RAM, 32 GB Temprary storage, $0.250/hour)
Region: Southeast Asia
Billing: Pay as you go

- 3 x Master nodes				Only Linux VM pay ($0.25/hour)
- 3 x Infra nodes				Only Linux VM pay ($0.25/hour)
- 4 x App nodes					Linux VM pay + Openshift pay as you go price (+$0.761/hour)

Total cluster pricing (excluding storage, networking, etc.)
	$48.6 K

VM fee : Openshift pay = 1 : 3

## Additional node
+ 1 App nodes: 	+($0.25/hour	+ $0.761/hour) = +$8.86 K

(!) 1 year reserved (~42% savings)

## Comparisons

### AKS

SKU: D4s v3 (4, vCPUs 16 GiB RAM, 32 GB Temprary storage, $0.250/hour)
Region: Southeast Asia
Support: Professional Direct		$1 K
Nodes:	4							$730

Estimated monthly cost:	$1.73 K/month
						$20.76 K

### OpenShift
// TODO

