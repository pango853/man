
# Virtual Switch Manager

> New-VMSwitch -Name "VDI Network" -NetAdapterName "VDI Networks"

Add-VMNetworkAdapter –ManagementOS –Name Management
Add-VMNetworkAdapter –ManagementOS –Name Storage
Add-VMNetworkAdapter –ManagementOS –Name “Live Migration”



# Troubleshooting

## External Ethernet adapter 'XXXX #2' is already bound to the Microsoft Virtual Switch protocol.
Fix it by unchecking the "Hyper-V Extensible Virtual Switch" option in the LAN properties:
    Network and Sharing (Win7)/Network (Win 10)
    Change adapter settings/options
    Right-click Local Area Connection
    Go to Properties
    Scroll to the bottom of the list
    Uncheck "Hyper-V Extensible Virtual Switch" option

User netcfg to wipe out all your networking settings and re-initialize the network card drivers.
> netcfg -d

