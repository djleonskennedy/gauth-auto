# gauth-vpn

[![CircleCI](https://circleci.com/gh/djleonskennedy/gauth-auto.svg?style=svg)](https://circleci.com/gh/djleonskennedy/gauth-auto)

Utility to provide automatic config generation for cisco any connect
with enabled [rfc6238](https://tools.ietf.org/html/rfc6238)

### Compiling

how to get it working

  - Clone sources
  - in project folder run `stack build`
  - in folder `.stack-work/dist/<hash>/build/hauth/hauth.exe`
  - copy where you need
  - hauth.exe -c C:/vpn/config.json -t C:/vpn/connect.txt
  - on Windows (i've tested on Windows 10)
  - `
   cmd.exe /c "%programfiles(x86)%\Cisco\Cisco AnyConnect Secure Mobility Client/vpncli.exe" -s < %~dp0connect.txt
  `
  - you have to be successfully logged 

### Config Json

Have to be in next format

```
{
  "login": "username",
  "password": "olo-olo",
  "secret": "base32 secret key", // for example EEEEAFFF44NNN5524QQQQUQMAUCI2222
  "host": "connect <host>" // for example connect vpn.cisco.com/ololo
}
```
### API
you import direct `KeyManager.hs` in you project

`import KeyManager (generate)`

it expose `generate` that can be used in your project
project depends on project of aleshgo `https://github.com/aleshgo/encdec`, 
so you can go there for types

PRs, issues are welcome

### Unix solution
[check this gist](https://gist.github.com/djleonskennedy/aa4a53265523d2bd805bb5cea7e40f48)

### Resources

[rfc6238](https://tools.ietf.org/html/rfc6238)
[gauth](https://gauth.apps.gbraad.nl/)
