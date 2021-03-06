Function Find-MSContentClassInstances {
    <#
    .SYNOPSIS
        (Extended) Page Search > Content Class
    .DESCRIPTION
        You can use this RQL to search for instances based on a specfic content class guid. 
    .EXAMPLE
        ... {EXAMPLE} ...
    .INPUTS
        ... {INPUTS} ...
    .OUTPUTS
        ... {OUTPUTS} ...
    .LINK
        ... {LINK} ...
    .NOTES
        RQL: (Extended) Page Search, Software version >= 7.5
        History:
        16.0 SP2        Added the SEARCHITEM of type element. Added the SEARCHITEM of type linkingschedule.
        11.0.0          Added description for searchguid attribute of the xsearch request in order to implement result paging.
    #>
    [Alias('Find-CMSContentClassInstances')]
    [CmdletBinding(DefaultParameterSetName = 'byMSSession')]
    param(
        # {DESCRIPTION}
        [Parameter(
            Position = 0,
            Mandatory = $true,
            ParameterSetName = 'byMSSession'
        )]
        [string] $ContentClassGUID,
        # {DESCRIPTION}
        [Parameter(
            Position = 1,
            Mandatory = $false,
            ParameterSetName = 'byMSSession'
        )]
        [string] $SearchGUID,
        # {DESCRIPTION}
        [Parameter(
            Position = 2,
            Mandatory = $false,
            ParameterSetName = 'byMSSession'
        )]
        [int] $Page = 1,
        # {DESCRIPTION}
        [Parameter(
            Position = 3,
            Mandatory = $false,
            ParameterSetName = 'byMSSession'
        )]
        [int] $PageSize = 10,
        # {DESCRIPTION}
        [Parameter(
            Position = 4,
            Mandatory = $false,
            ParameterSetName = 'byMSSession'
        )]
        [int] $MaxHits = 100
    )
    begin {
        Write-Debug -Message ("[ Enter => function {0} ]" -f $MyInvocation.MyCommand);
    }
    process { #$ContentClassGUID, $SearchGUID, $Page=1, $PageSize=10, $MaxHits=100
        Write-Debug -Message ("[ Process => function {0} ]" -f $MyInvocation.MyCommand);
        Set-MSTimestamp;
        $Request = ("<IODATA loginguid='[!guid_Login!]' sessionkey='[!key!]' dialoglanguageid='[!dialog_language_id!]'><PAGE action='xsearch' orderby='pageid' orderdirection='ASC' searchguid='[!page_searchguid!]' page='[!page!]' pagesize='[!pagesize!]' maxhits='[!maxhits!]'><SEARCHITEMS><SEARCHITEM key='contentclassguid' value='[!guid_template!]' operator='eq'/></SEARCHITEMS></PAGE></IODATA>").Replace("[!guid_template!]",$ContentClassGUID).Replace("[!pagesize!]",$PageSize).Replace("[!maxhits!]",$MaxHits);
        if ($Page -and $SearchGUID) {
            $Request = $Request.Replace("[!page_searchguid!]",$SearchGUID).Replace("[!page!]",$Page);
        } else {
            $Request = $Request.Replace(" searchguid='[!page_searchguid!]'","").Replace(" page='[!page!]'","");
        }
        $Request = Import-MSSessionProperties -Request ($Request);
        [xml]$Response = Invoke-MSRQLRequest -Request ($Request);
        Show-MSSessionWebServiceDebug;
        return $Response;
    }
    end {
        Write-Debug -Message ("[ Leave => function {0} ]" -f $MyInvocation.MyCommand);
    }
}