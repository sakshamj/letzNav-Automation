#variable Initailiazation
"Give all the paths ending with \"
$downloadPath = Read-Host -Prompt "Enter file download path"
$destPath=Read-Host -Prompt "Enter extraction path "
$Name=Read-Host -Prompt "Extraction folder name"
$downLoadList =Read-Host -Prompt "Download URL" 
"File will be downloaded to $downloadPath"
"File should be Extracted to $destPath"
"Folder Name of Extraction $Name"
"URL from where file need to be downloaded $downLoadList"

#Get Name of the file and downloading
$hdr = Invoke-WebRequest $downLoadList -Method Head
$title = $hdr.BaseResponse.ResponseUri.Segments[-1] 
$title = [uri]::UnescapeDataString($title) 
$saveTo = $downloadPath + $title
"Downloading $title to $saveTo"
Invoke-WebRequest $downLoadList -OutFile $saveTo 
"Downloading completed"

#Extracting File
"Extracting the file"
$extractPath= $destPath + $Name
Expand-Archive -Path $saveTo -DestinationPath $extractPath
"File Extraction completed"

#available options
"available options"
dir -Directory $destPath

#Setting selected folder to default folder
$select= Read-Host -Prompt "Select the folder"
$selectPath=$destPath+$select
dir -Directory $selectPath
$defult=Read-Host -Prompt "Default folder path"
Copy-Item -Path $selectPath -Destination $defult –Recurse
"Copied $select to default folder($defult) completed"

#Happy Beep...
[Console]::Beep(500,300)

#completed Successfully