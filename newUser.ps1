Import-Csv -Path C:\users.csv | foreach {
	#initial default password
	$defaultPw = 'P@ssw0rd'
	$secPw = ConvertTo-SecureString -String $defaultPw -AsPlainText -Force

	$userName = '{0}{1}' -f $_.FirstName.Substring(0,1),$_.LastName
	$userName.ToLower()
	$NewUserParameters = @{
		GivenName = $_.FirstName
		Surname = $_.LastName
		Name = $userName
		AccountPassword = $secPw
	}
	New-AdUser @NewUserParameters
	Add-AdGroupMember -Identity 'Students' -Members $userName
}
