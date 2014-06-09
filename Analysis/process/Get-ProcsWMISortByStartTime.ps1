﻿<#
Get-ProcsWMISortByStartTime.ps1

Returns process CreationDate, ProcessId, ParentProcessId, CommandLine

Requires:
Process data matching *ProcWMI.tsv in pwd
logparser.exe in path
#>

if (Get-Command logparser.exe) {
    $lpquery = @"
    SELECT DISTINCT
        CreationDate,
        ProcessId,
        ParentProcessId,
        CommandLine,
        PSComputerName
    FROM
        *ProcsWMI.tsv
    ORDER BY
        PSComputerName,
        CreationDate,
        ProcessId ASC
"@

    & logparser -i:tsv -dtlines:0 -fixedsep:on -rtp:50 "$lpquery"

} else {
    $ScriptName = [System.IO.Path]::GetFileName($MyInvocation.ScriptName)
    "${ScriptName} requires logparser.exe in the path."
}