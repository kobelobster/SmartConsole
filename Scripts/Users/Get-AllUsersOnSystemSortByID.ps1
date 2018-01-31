﻿Register-MSConfigStore;

Set-MSConfigDebugMode -Value ($false); # $true oder $false

Register-MSSession -UseDefaults ($true);
Select-MSSession -UseDefaults ($true);
Enter-MSSession -UseDefaults ($true);

Get-MSAllUsers;
$AllUsers = (([xml](Get-MSSessionProperty -Name ("LastResponse"))).SelectNodes("IODATA/USERS/USER")) | Sort-Object -Culture ("de-DE") -Property @{Expression = {$_.id -as [int]}};

Get-MSAllLoggedOnUsers;
$AllLoggedOnUsers = ([xml](Get-MSSessionProperty -Name ("LastResponse"))).SelectNodes("IODATA/USERS/USER");

Write-Output ("`r`n");

$AllUsers | Select-Object -Property ("id", "name", "fullname", "email", "guid");

Write-Output ("`r`n");
Write-Output ("Currently logged on: {0}`r`n" -f $AllLoggedOnUsers.Count);
Write-Output ("Total accounts: {0}`r`n" -f $AllUsers.Count);

#Show-MSSession; # Optional
Exit-MSSession -UseDefaults ($true);
Unregister-MSSession -UseDefaults ($true);

Unregister-MSConfigStore;