Function ConvertFrom-RQLGuid {
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
    [CmdletBinding(DefaultParameterSetName = 'byOLEAutomationDate')]
    param(
        # {DESCRIPTION}
        [Parameter(
            Position = 0,
            Mandatory = $true,
            ParameterSetName = 'byOLEAutomationDate',
            ValueFromPipeline = $true,
            ValueFromRemainingArguments = $true
        )]
        [string] $ValueGuid
    )
    begin {
        Write-Debug -Message ("[ Enter => function {0} ]" -f $MyInvocation.MyCommand);
    }
    process {
        Write-Debug -Message ("[ Process => function {0} ]" -f $MyInvocation.MyCommand);
        return [guid]$ValueGuid;
    }
    end {
        Write-Debug -Message ("[ Leave => function {0} ]" -f $MyInvocation.MyCommand);
    }
}