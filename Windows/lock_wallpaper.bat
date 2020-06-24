:: this is create a folder for windows lock_screen wallpapers,which you dont find in regular wallpaper file
@echo off
mkdir C:\Users\%USERNAME%\Pictures\New_picture
cd C:\Users\%USERNAME%\Pictures\New_picture
xcopy C:\Users\%USERNAME%\AppData\Local\Packages\Microsoft.Windows.ContentDeliveryManager_cw5n1h2txyewy\LocalState\Assets\* C:\Users\%USERNAME%\Pictures\New_picture
ren *.* *.jpg
%SystemRoot%\explorer.exe "C:\Users\%USERNAME%\Pictures\New_picture"
