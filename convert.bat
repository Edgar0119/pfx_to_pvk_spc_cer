@echo off
echo Please make sure you have named the PFX file authenticode.pfx
pause
Echo Please enter PFX password
openssl pkcs12 -in authenticode.pfx -nocerts -nodes -out temp.key
echo Please enter PFX Password
openssl pkcs12 -in authenticode.pfx -nokeys -out temp.txt
echo Create a PVK Password
pvk -in temp.key -topvk -strong -out myprivatekey.pvk
openssl crl2pkcs7 -nocrl -certfile temp.txt -outform DER -out mycredentials.spc

echo Convert .pfx to .cer
openssl pkcs12 -in authenticode.pfx -out mycerts.crt -nokeys -clcerts
openssl x509 -inform pem -in mycerts.crt -outform der -out cert.cer

del temp.txt
del temp.key
del mycerts.crt 