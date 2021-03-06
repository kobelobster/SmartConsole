﻿Function Set-Pause {
    <#
    .SYNOPSIS
        ... {SYNOPSIS} ...
    .DESCRIPTION
        ... {DESCRIPTION} ...
    .EXAMPLE
        ... {EXAMPLE} ...
    .INPUTS
        ... {INPUTS} ...
    .OUTPUTS
        ... {OUTPUTS} ...
    .LINK
        ... {LINK} ...
    .NOTES
        ... {NOTES} ...
    #>
    [CmdletBinding(DefaultParameterSetName = 'byMessage')]
    param(
        # {DESCRIPTION}
        [Parameter(
            Position = 0,
            Mandatory = $false,
            ParameterSetName = 'byMessage'
        )]
        [string] $Message = 'Press any key to continue . . . '
    )
    begin {
        Write-Debug -Message ("[ Enter => function {0} ]" -f $MyInvocation.MyCommand);
    }
    process {
        Write-Debug -Message ("[ Process => function {0} ]" -f $MyInvocation.MyCommand);
        if ($psISE) {
            # The "ReadKey" functionality is not supported in Windows PowerShell ISE.
            $Shell = New-Object -ComObject "WScript.Shell";
            $Button = $Shell.Popup("Click OK to continue.", 0, "Script Paused", 0);
            return;
        }
        Write-Host -NoNewline $Message;
        $Ignore =
        16, # Shift (left or right)
        17, # Ctrl (left or right)
        18, # Alt (left or right)
        20, # Caps lock
        91, # Windows key (left)
        92, # Windows key (right)
        93, # Menu key
        144, # Num lock
        145, # Scroll lock
        166, # Back
        167, # Forward
        168, # Refresh
        169, # Stop
        170, # Search
        171, # Favorites
        172, # Start/Home
        173, # Mute
        174, # Volume Down
        175, # Volume Up
        176, # Next Track
        177, # Previous Track
        178, # Stop Media
        179, # Play
        180, # Mail
        181, # Select Media
        182, # Application 1
        183  # Application 2
        while ($KeyInfo.VirtualKeyCode -Eq $Null -Or $Ignore -Contains $KeyInfo.VirtualKeyCode) {
            $KeyInfo = $Host.UI.RawUI.ReadKey("NoEcho, IncludeKeyDown");
        }
        Write-Host;
    }
    end {
        Write-Debug -Message ("[ Leave => function {0} ]" -f $MyInvocation.MyCommand);
    }
}