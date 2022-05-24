If (([Security.Principal.WindowsPrincipal] [Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole([Security.Principal.WindowsBuiltInRole] "Administrator")) {
    Write-Warning "This script will not function with administrative privileges. Please run as a normal user."
    Break
}

$outfile = "acltestfile"
set-variable -name paths -value (Get-ItemProperty -Path 'Registry::HKEY_LOCAL_MACHINE\System\CurrentControlSet\Control\Session Manager\Environment' -Name PATH).path.Split(";")
Foreach ($path in $paths) {
    # This prints a table of ACLs
    # get-acl $path | %{ $_.Access  } | ft -Wrap -AutoSize -property IdentityReference, AccessControlType, FileSystemRights

    # Easier to get effective access of current user by just trying to create a file
    Try {
        [io.file]::OpenWrite("$path\$outfile").close()
        Write-Warning "I can write to '$path'"
        $insecure = 1
    }
    Catch {}
}
If ($insecure -eq 1) {
  Write-Warning "Any directory above is in the system-wide directory list, but can also be written to by the current user."
  Write-Host "This can allow privilege escalation." -ForegroundColor Red
} Else {
  Write-Host "Looks good! No system path can be written to by the current user." -ForegroundColor Green
}