---
title: "Secure Passwords in R"
author: "Peter Higgins"
date: "5/6/2021"
output: html_document
---



# Secure Passwords in R

You will, not infrequently, need to use passwords to access secure or PHI protected data from databases or cloud storage or even password-protected excel files.

It is important to sort out how to use passwords securely. You do not want to type out your password in a script. You can store passwords securely in variables on your computer for use later. If they are in a script, someone else can find them, especially if you are using version control and pushing code to Github.

You *can* use the **.gitignore** file to make sure that git ignores certain files to back up to the repository, especially large files (graphics, etc. that can be regenerated), but it is better to avoid putting any passwords into your code at all.

Each major computer operating system (Windows, MacOS, Linux) has its own secure credential store. You may know this as the 'Credential Store' on Windows, the 'Keychain' on MacOS, or the "Secret Service API' on Linux. Each of these is a secure, password-protected store of passwords that you use for different websites for browser access.

The {keyring} package in R gives you a single interface to all of these secure credential stores. Make sure you have this installed with<br>

`install.packages('keyring')`

after you call `library(keyring)`, you can store one or more secret passwords (keys). A key is defined by a service name (i.e. website) and a password. Once defined, this key persists in the keyring store of your operating system, and is only accessible to someone with the password to your computer.

You can define a key once (interactively, or in an R script), and it will persist for use in future R sessions.

Let's see your current list of secrets. Run the code chunk below.


``` r
library(keyring)
key_list()
```

```
##                                                                                                                                                                                                                    service
## 1                                                                                                                                                                                                  Apple ID Authentication
## 2                                                                                                                                                                                       com.apple.scopedbookmarksagent.xpc
## 3                                                                                                                                                                                                    ProtectedCloudStorage
## 4                                                                                                                                                                                              ProtectedCloudStoragePublic
## 5                                                                                                                                                                             com.apple.cloudd.deviceIdentifier.Production
## 6                                                                                                                                                                             com.apple.cloudd.deviceIdentifier.Production
## 7                                                                                                                                                                             com.apple.cloudd.deviceIdentifier.Production
## 8                                                                                                                                                                                                 Safari Session State Key
## 9                                                                                                                                                                                            PersonalFormsAutoFillDatabase
## 10                                                                                                                                                                                                 AirPlay Client Identity
## 11                                                                                                                                                                                                     AirPlay Client Peer
## 12                                                                                                                                                                                              Call History User Data Key
## 13                                                                                                                                                                                   com.apple.linkedin.oauth-token-nosync
## 14                                                                                                                                                                                                    Extended Preferences
## 15                                                                                                                                                                                                   fmfd-daemon-aps-token
## 16                                                                                                                                                                                                           iPhone Backup
## 17                                                                                                                                                                                                           com.apple.ids
## 18                                                                                                                                                                            com.apple.cloudd.deviceIdentifier.Production
## 19                                                                                                                                      com.apple.gs.icloud.auth.com.apple.account.AppleIDAuthentication.token-expiry-date
## 20                                                                                                                                     com.apple.gs.appleid.auth.com.apple.account.AppleIDAuthentication.token-expiry-date
## 21                                                                                                                                                                                                                        
## 22                                                                     MSOpenTech.ADAL.1|aHR0cHM6Ly9sb2dpbi53aW5kb3dzLm5ldC9jb21tb24|aHR0cHM6Ly9vZmZpY2VhcHBzLmxpdmUuY29t|ZDM1OTBlZDYtNTJiMy00MTAyLWFlZmYtYWFkMjI5MmFiMDFj
## 23                                                                                                                                                                                                    AirPort Base Station
## 24                                                                                                                                                                                 com.apple.iMovieApp: Google Plus OAuth2
## 25                                                                     MSOpenTech.ADAL.1|aHR0cHM6Ly9sb2dpbi53aW5kb3dzLm5ldC9jb21tb24|CC3513A0-0E69-4B4D-97FC-DFB6C91EE132|ZDM1OTBlZDYtNTJiMy00MTAyLWFlZmYtYWFkMjI5MmFiMDFj
## 26                                          MSOpenTech.ADAL.1|aHR0cHM6Ly9sb2dpbi53aW5kb3dzLm5ldC9jb21tb24|aHR0cHM6Ly81ZDU1ZTE4MjRjNWE0NGU2OGJjMi1teS5zaGFyZXBvaW50LmNvbS8|ZDM1OTBlZDYtNTJiMy00MTAyLWFlZmYtYWFkMjI5MmFiMDFj
## 27                                                                                                                                                                                                        com.amazon.music
## 28                                                                                                                                                                            com.apple.cloudd.deviceIdentifier.Production
## 29                             MSOpenTech.ADAL.1|aHR0cHM6Ly9sb2dpbi53aW5kb3dzLm5ldC80MzYzYjM3Yy01ZjNjLTRmZDctYTU2MS05NDMxMzFkYjc4YmM|CC3513A0-0E69-4B4D-97FC-DFB6C91EE132|ZDM1OTBlZDYtNTJiMy00MTAyLWFlZmYtYWFkMjI5MmFiMDFj
## 30  MSOpenTech.ADAL.1|aHR0cHM6Ly9sb2dpbi53aW5kb3dzLm5ldC80MzYzYjM3Yy01ZjNjLTRmZDctYTU2MS05NDMxMzFkYjc4YmM|aHR0cHM6Ly81ZDU1ZTE4MjRjNWE0NGU2OGJjMi1teS5zaGFyZXBvaW50LmNvbS8|ZDM1OTBlZDYtNTJiMy00MTAyLWFlZmYtYWFkMjI5MmFiMDFj
## 31                                                                                                                                                                                                                     SSH
## 32                                                                                                                                                                                             com.garmin.renu.client.MSAI
## 33                                                                                                                                                                                            com.garmin.renu.service.MSAI
## 34                                                                                                                                                                                                   BackupIDSAccountToken
## 35                                                                                                                                                                                com.helpshift.data_com.microsoft.Outlook
## 36                                                                                                                                                                                com.helpshift.data_com.microsoft.Outlook
## 37                                                                                                                                                                                                                        
## 38                                                                                                                                                                                    Safari Forms AutoFill Encryption Key
## 39                                                                                                                                                                                   com.apple.facebook.oauth-token-nosync
## 40                                                                                                                                                                                                        MetadataKeychain
## 41                                                                                                                                                                            com.apple.cloudd.deviceIdentifier.Production
## 42                                                                                                                                                                            com.apple.cloudd.deviceIdentifier.Production
## 43                                                                                                                                                                            com.apple.cloudd.deviceIdentifier.Production
## 44                                                                                                                                                                            com.apple.cloudd.deviceIdentifier.Production
## 45                                                                                                                                                                            com.apple.cloudd.deviceIdentifier.Production
## 46                                                                                                                                                                            com.apple.cloudd.deviceIdentifier.Production
## 47                                                                                                                                                                            com.apple.cloudd.deviceIdentifier.Production
## 48                                                                                                                                                                            com.apple.cloudd.deviceIdentifier.Production
## 49                                                                                                                                                                            com.apple.cloudd.deviceIdentifier.Production
## 50                                                                                                                                                                            com.apple.cloudd.deviceIdentifier.Production
## 51                                                                                                                                                                            com.apple.cloudd.deviceIdentifier.Production
## 52                                                                                                                                                                            com.apple.cloudd.deviceIdentifier.Production
## 53                                                                                                                                                                                                                        
## 54                                                                                                                                                                                                     com.apple.assistant
## 55                                                                                                                                                                             com.apple.NetworkServiceProxy.Configuration
## 56                                                                                                                                                                    com.apple.NetworkServiceProxy.WaldoInfo.pie.v3.hosts
## 57                                                                                                                                                               com.apple.NetworkServiceProxy.WaldoInfo.com.apple.parsecd
## 58                                                                                                                                                                                                                        
## 59                                                                                                                                                                            com.apple.cloudd.deviceIdentifier.Production
## 60                                                                                                                                                                                     com.citrix.receiver.nomas.HockeySDK
## 61                                                                                                                                                                                     com.citrix.ReceiverHelper.HockeySDK
## 62                                                                                                                                                                                     com.citrix.receiver.nomas.HockeySDK
## 63                                                                                                                                                                                    com.citrix.ReceiverUpdater.HockeySDK
## 64                                                                                                                                                                                    com.apple.twitter.oauth-token-nosync
## 65                                                                                                                                                                          com.apple.quicktimeplayerx.YouTube.oauth-token
## 66                                                                                                                                                                  com.apple.quicktimeplayerx.YouTube.oauth-refresh-token
## 67                                                                                                                                                                                com.helpshift.data_com.microsoft.Outlook
## 68                                                                                                                                                                                com.helpshift.data_com.microsoft.Outlook
## 69                                                                                                                                                                         com.garmin.cartography.mapupdate.express.itauth
## 70                                                                                                                                                                            com.apple.cloudd.deviceIdentifier.Production
## 71                                                                                                                                                                           Forms-{23D7314F-334F-49af-A1F1-87F222FEC590}u
## 72                                                                                                                                                                                       com.citrix.XenAppViewer.HockeySDK
## 73                                                                                                                                                                           com.garmin.cartography.mapupdate.express.auth
## 74                                                                                                                                                                                         GitHub - https://api.github.com
## 75                                                                                                                                                                                                                        
## 76                                                                                                                                                                                                                        
## 77                                                                                                                                                                        AGLegacy-{232FA8DF-2F1B-462c-846E-00BFBC1B5A44}u
## 78                                                                                                                                                                                                                        
## 79                                                                                                                                                                                                                        
## 80                                                                                                                                                                                                                        
## 81                                                                                                                                                                                                       Zoom Safe Storage
## 82                                                                                                                                                                                                   com.bluejeansnet.Blue
## 83                                                                                                                                                                                                   com.bluejeansnet.Blue
## 84                                                                                                                                                                                                   com.bluejeansnet.Blue
## 85                                                                                                                                                                                com.microsoft.SkypeForBusiness.HockeySDK
## 86                                                                                                                                                                                                     com.apple.assistant
## 87                                                                                                                                                                                               Zoom Safe Meeting Storage
## 88                                                                                                                                                                                                      SWC Agent Database
## 89                                                                                                                                                                                                                Exchange
## 90                                                                                                                                                                     com.apple.account.AppleAccount.back-to-my-mac-token
## 91                                                                                                                                                                           com.apple.account.AppleIDAuthentication.token
## 92                                                                                                                                                               com.apple.account.AppleIDAuthentication.token-expiry-date
## 93                                                                                                                                                                                                 AppleIDClientIdentifier
## 94                                                                                                                                                                                    317E8977-13BE-4CD4-9FF3-F396535E48FC
## 95                                                                                                                                                                             com.apple.account.Google.oauth-token-nosync
## 96                                                                                                                                                                                                      Adobe User OS Info
## 97                                                                                                                                                                                                     com.apple.assistant
## 98                                                                                                                             com.adobe.creativecloud.com.adobe.acc.pmp.C2A135575CF3D7EC0A495FA8.ThirdPartyPluginsInstall
## 99                                                                                                                                                                                                                        
## 100                                                                                                                                                                                                    com.apple.assistant
## 101                                                                                                                                                                                                AirPlay Server Identity
## 102                                                                                                                                                                                                             iOS Backup
## 103                                                                                                                                                                                                    Chrome Safe Storage
## 104                                                                                                                                                                                     com.apple.account.GameCenter.token
## 105                                                                                                                                                                                                    com.apple.assistant
## 106                                                                                                                                        com.firebase.FIRInstallations.installations.1:177223194525:ios:76d203d5a1553972
## 107                                                                                                                                                                                   84ef17be-80f0-4750-a22c-c2a26ff1ba72
## 108                                                                                                                                                                                   84ef17be-80f0-4750-a22c-c2a26ff1ba72
## 109                                                                                                                                                                                       Microsoft Teams Identities Cache
## 110                                                                                                                                                                        Adobe App Info (Q0NMaWJyYXJ5MXt9MjAxODA3MjAwMQ)
## 111                                                                                                                                                                                                   discord Safe Storage
## 112                                                                                                                                                                                                com.microsoft.rdc.macos
## 113                                                                                                                                                                                                     Teams Safe Storage
## 114                                                                                                                                                                                                                teamsIv
## 115                                                                                                                                                                                                               teamsKey
## 116                                                                                                              com.adobe.creativecloud.com.adobe.acc.container.C2A135575CF3D7EC0A495FA8.AdobeStock:NOTIFICATION_GUID_KEY
## 117                                                                                                         com.adobe.creativecloud.com.adobe.acc.container.C2A135575CF3D7EC0A495FA8.AdobeStock:NOTIFICATION_TIMESTAMP_KEY
## 118                                                                                                              com.adobe.creativecloud.com.adobe.acc.container.C2A135575CF3D7EC0A495FA8.AdobeStock:NOTIFICATION_ETAG_KEY
## 119                                                                                                                                                                                                                       
## 120                                                                                                                                                                            com.apple.account.Google.oath-refresh-token
## 121                                                                                                                                                                                                                       
## 122                                                                                                                                                                                                     Slack Safe Storage
## 123                                                                                                                   com.adobe.creativecloud.com.adobe.acc.container.C2A135575CF3D7EC0A495FA8.AdobeStock:NOTIFICATION_KEY
## 124                                                                                                                                                                                                                       
## 125                                                                                                                             DBX_PASSWORDS_NMHAAARijI5FMx-jb14NyZYH9Q6BB4lBd1XpMc__40F9DF58-039E-40F1-A3CD-490226F560C6
## 126                                                                                                                             DBX_PASSWORDS_NMHAAARijI5FMx-jb14NyZYH9Q6BB4lBd1XpMc__7EB20C05-66C8-4151-9A03-3B433077E00F
## 127                                                                                                                                                                                       Microsoft Teams Identities Cache
## 128                                                                                                                                                                                                              AdalCache
## 129                                                                                                                                                                                   d211f69b-6302-418e-b36f-ae2aa01bdbfd
## 130                                                                                                                                                                                        com.apple.continuity.encryption
## 131                                                                                                                                                                                                        biofire_api_key
## 132                                                                                                                                                                                                    FMFDStoreController
## 133                                                                                                                                                                                                    com.apple.assistant
## 134                                                                                                                                                                               com.apple.NetworkServiceProxy.ProxyToken
## 135                                                                                                                                                                                           Microsoft Teams Safe Storage
## 136                                                                                                                                                                                                                 iCloud
## 137                                                                                                                                                                                    com.microsoft.OutlookCore.ServiceV2
## 138                                                                                                                                                                          com.garmin.cartography.mapupdate.express.auth
## 139                                                                                                                                                                                                                       
## 140                                                                                                                                                                               com.apple.NetworkServiceProxy.ProxyToken
## 141                                                                                                                                                                               com.apple.NetworkServiceProxy.ProxyToken
## 142                                                                                                                                                                        Adobe App Info (Q0NMaWJyYXJ5Mnt9MjAxODA3MjAwMQ)
## 143                                                                                                                                                                                        com.apple.continuity.encryption
## 144                                                                                                                                                                                                                       
## 145                                                                                                                                                                                                                       
## 146                                                                                                                                                                   Adobe App Info (Q3JlYXRpdmVDbG91ZDJ7fTIwMTgwNzIwMDE)
## 147                                                                                                                                                                                        com.apple.continuity.encryption
## 148                                                                                                                                                                                   EDCA163A-9928-49A8-B539-BE9DE9A1B0E6
## 149                                                                                                                                                                                                        Adobe User Info
## 150                                                                                                                                                                           com.apple.scopedbookmarksagent.xpc.encrypted
## 151                                                                                                                                                                        Adobe App Info (QWNyb2JhdERDMXt9MjAxODA3MjAwMQ)
## 152                                                                                                                                                                                                  Positron Safe Storage
## 153                                                                                                                                                                                                    com.apple.assistant
## 154                                                                                                                                                                                        com.apple.continuity.encryption
## 155                                                                                                                                                                                        com.apple.continuity.encryption
## 156                                                                                                                                                                                        com.apple.continuity.encryption
## 157                                                                                                                                                 com.apple.gs.icloud.auth.com.apple.account.AppleIDAuthentication.token
## 158                                                                                                                                                com.apple.gs.appleid.auth.com.apple.account.AppleIDAuthentication.token
## 159                                                                                                                                                                                                                       
## 160                                                                                                                                                                                                    com.apple.assistant
## 161                                                                                                                                                                                                    com.apple.assistant
## 162                                                                                                                                                                                                    com.apple.assistant
## 163                                                                                                                                                                                                     TelephonyUtilities
## 164                                                                                                                                                                                                     TelephonyUtilities
## 165                                                                                                                                                                                             com.apple.ind.registration
## 166                                                                                                                                                                       Adobe App Info (Q0NYUHJvY2VzczF7fTIwMTgwNzIwMDE)
## 167                                                                                                                                                                          Adobe App Info (Q29yZVN5bmMxe30yMDE4MDcyMDAx)
## 168                                                                                                                                                                               com.apple.NetworkServiceProxy.ProxyToken
## 169                                                                                                                                                                                      Apple Persistent State Encryption
## 170                                                                                                                                                                                                    com.apple.assistant
## 171                                                                                                                                                                                                         OneAuthAccount
## 172                                                                                                                                                                                                         OneAuthAccount
## 173                                                                                                                                                                                                                       
## 174                                                                                                    com.adobe.creativecloud.com.adobe.acc.container.C2A135575CF3D7EC0A495FA8.AdobeStock:UPDATE_INDICATOR_VISIBILITY_KEY
## 175                                                                                                                                                                               com.apple.NetworkServiceProxy.ProxyToken
## 176                                                                                                                                                                               com.apple.NetworkServiceProxy.ProxyToken
## 177                                                                                                                                                                               com.apple.NetworkServiceProxy.ProxyToken
## 178                                                                                                                                                                               com.apple.NetworkServiceProxy.ProxyToken
## 179                                                                                                                                                                               com.apple.NetworkServiceProxy.ProxyToken
## 180                                                                                                                                                                      Adobe App Info (SWxsdXN0cmF0b3Ixe30yMDE4MDcyMDAx)
## 181                                                                                                                                                                        Adobe App Info (UGhvdG9zaG9wMXt9MjAxODA3MjAwMQ)
## 182                                                                                                                                                                                                         OneAuthAccount
## 183                                                                                                                                                                                                    com.apple.assistant
## 184                                                                                                                                                                               com.apple.NetworkServiceProxy.ProxyToken
## 185                                                                                                                                                                             com.apple.account.Google.oauth-expiry-date
## 186                                                                                                                                                                                   com.apple.account.Google.oauth-token
## 187                                                                                                                                                                                        com.apple.continuity.encryption
## 188                                                                                                                                                                               com.apple.NetworkServiceProxy.ProxyToken
## 189                                                                                                                                                                                                                AirPort
## 190                                                                                                                                                                                                                AirPort
## 191                                                                                                                                                                                                                AirPort
## 192                                                                                                                                                                                                                AirPort
## 193                                                                                                                                                                                                                AirPort
## 194                                                                                                                                                                                                                AirPort
## 195                                                                                                                                                                                                                AirPort
## 196                                                                                                                                                                                                                AirPort
## 197                                                                                                                                                                                                                AirPort
## 198                                                                                                                                                                                                                AirPort
## 199                                                                                                                                                                                                                AirPort
## 200                                                                                                                                                                                                                AirPort
## 201                                                                                                                                                                                                                AirPort
## 202                                                                                                                                                                                                                AirPort
## 203                                                                                                                                                                                                                AirPort
## 204                                                                                                                                                                                                                AirPort
## 205                                                                                                                                                                                                                AirPort
## 206                                                                                                                                                                                                                AirPort
## 207                                                                                                                                                                                                                AirPort
## 208                                                                                                                                                                                                                AirPort
## 209                                                                                                                                                                                                                AirPort
## 210                                                                                                                                                                                                                AirPort
## 211                                                                                                                                                                                                                AirPort
## 212                                                                                                                                                                                                                AirPort
## 213                                                                                                                                                                                                                AirPort
## 214                                                                                                                                                                                                                AirPort
## 215                                                                                                                                                                                                                AirPort
## 216                                                                                                                                                                                                                AirPort
## 217                                                                                                                                                                                                                AirPort
## 218                                                                                                                                                                                                                AirPort
## 219                                                                                                                                                                                                                AirPort
## 220                                                                                                                                                                                                                AirPort
## 221                                                                                                                                                                                                                AirPort
## 222                                                                                                                                                                                                                AirPort
## 223                                                                                                                                                                                                                AirPort
## 224                                                                                                                                                                                                                AirPort
## 225                                                                                                                                                                                                                AirPort
## 226                                                                                                                                                                                                                AirPort
## 227                                                                                                                                                                                                                AirPort
## 228                                                                                                                                                                                                                AirPort
## 229                                                                                                                                                                                                                AirPort
## 230                                                                                                                                                                                                                AirPort
## 231                                                                                                                                                                                                                AirPort
## 232                                                                                                                                                                                                                AirPort
## 233                                                                                                                                                                                                                AirPort
## 234                                                                                                                                                                                                                AirPort
## 235                                                                                                                                                                                                                AirPort
## 236                                                                                                                                                                                                                AirPort
## 237                                                                                                                                                                                                                AirPort
## 238                                                                                                                                                                                                                AirPort
## 239                                                                                                                                                                                                                AirPort
## 240                                                                                                                                                                                                                AirPort
## 241                                                                                                                                                                                                                AirPort
## 242                                                                                                                                                                                                                AirPort
## 243                                                                                                                                                                                                                AirPort
## 244                                                                                                                                                                                                                AirPort
## 245                                                                                                                                                                                                                AirPort
## 246                                                                                                                                                                                                                AirPort
## 247                                                                                                                                                                                                                AirPort
## 248                                                                                                                                                                                                                AirPort
## 249                                                                                                                                                                                                                AirPort
## 250                                                                                                                                                                                                                AirPort
## 251                                                                                                                                                                                                                AirPort
## 252                                                                                                                                                                                                                AirPort
## 253                                                                                                                                                                                                                AirPort
## 254                                                                                                                                                                                                                AirPort
## 255                                                                                                                                                                                    com.citrix.receiver.nomas.HockeySDK
## 256                                                                                                                                                                                                                AirPort
## 257                                                                                                                                                                                                                AirPort
## 258                                                                                                                                                                                                                AirPort
## 259                                                                                                                                                                                                                AirPort
## 260                                                                                                                                                                                                                AirPort
## 261                                                                                                                                                                                                                AirPort
## 262                                                                                                                                                                                                                AirPort
## 263                                                                                                                                                                                                                AirPort
## 264                                                                                                                                                                                                                AirPort
## 265                                                                                                                                                                                                                AirPort
## 266                                                                                                                                                                                                                AirPort
## 267                                                                                                                                                                                                          WiFiAnalytics
## 268                                                                                                                                                                                                        BluetoothGlobal
## 269                                                                                                                                                                                                        BluetoothGlobal
## 270                                                                                                                                                                                                        BluetoothGlobal
## 271                                                                                                                                                                                                        BluetoothGlobal
## 272                                                                                                                                                                                                        BluetoothGlobal
## 273                                                                                                                                                                                                        BluetoothGlobal
## 274                                                                                                                                                                                                        BluetoothGlobal
## 275                                                                                                                                                                                                        BluetoothGlobal
## 276                                                                                                                                                                                                                       
## 277                                                                                                                                                                                                Remote Pairing Identity
## 278                                                                                                                                                                                                        BluetoothGlobal
## 279                                                                                                                                                                                                                AirPort
## 280                                                                                                                                                                                                        BluetoothGlobal
## 281                                                                                                                                                                                                        BluetoothGlobal
## 282                                                                                                                                                                                                                AirPort
## 283                                                                                                                                                                                                                AirPort
## 284                                                                                                                                                                                                                AirPort
## 285                                                                                                                                                                                                                AirPort
## 286                                                                                                                                                                                                                AirPort
## 287                                                                                                                                                                                                                AirPort
## 288                                                                                                                                                                                                                AirPort
## 289                                                                                                                                                                                                                AirPort
## 290                                                                                                                                                                                                                AirPort
## 291                                                                                                                                                                                                                AirPort
## 292                                                                                                                                                                                                        BluetoothGlobal
## 293                                                                                                                                                                                                                AirPort
## 294                                                                                                                                                                                                                AirPort
## 295                                                                                                                                                                                                                AirPort
## 296                                                                                                                                                                                                                AirPort
## 297                                                                                                                                                                                                                AirPort
## 298                                                                                                                                                                                                                AirPort
## 299                                                                                                                                                                                                                AirPort
## 300                                                                                                                                                                                                                AirPort
## 301                                                                                                                                                                                                                AirPort
## 302                                                                                                                                                                                                            BluetoothLE
## 303                                                                                                                                                                                                                AirPort
## 304                                                                                                                                                                                                        BluetoothGlobal
## 305                                                                                                                                                                                                            BluetoothLE
## 306                                                                                                                                                                                                                AirPort
## 307                                                                                                                                                                                                                AirPort
## 308                                                                                                                                                                                                                AirPort
## 309                                                                                                                                                                                                                AirPort
## 310                                                                                                                                                                                                            BluetoothLE
## 311                                                                                                                                                                                                                AirPort
## 312                                                                                                                                                                                                                AirPort
## 313                                                                                                                                                                                                                AirPort
## 314                                                                                                                                                                                                                AirPort
## 315                                                                                                                                                                                                                AirPort
## 316                                                                                                                                                                                                            BluetoothLE
## 317                                                                                                                                                                                                            BluetoothLE
## 318                                                                                                                                                                                                        BluetoothGlobal
## 319                                                                                                                                                                             AF2710E6-F2E5-48E8-AFA4-28BBC7B9CEA8.XAUTH
## 320                                                                                                                                                                                AF2710E6-F2E5-48E8-AFA4-28BBC7B9CEA8.SS
## 321                                                                                                                                                                             FDB4238E-3A19-4058-AAEA-42DEAA52A9D8.XAUTH
## 322                                                                                                                                                                                FDB4238E-3A19-4058-AAEA-42DEAA52A9D8.SS
## 323                                                                                                                                                                                                        MobileBluetooth
## 324                                                                                                                                                                                                        MobileBluetooth
## 325                                                                                                                                                                                                        MobileBluetooth
## 326                                                                                                                                                                                                        MobileBluetooth
## 327                                                                                                                                                                                                        MobileBluetooth
## 328                                                                                                                                                                                                          WiFiAnalytics
## 329                                                                                                                                                                                                          WiFiAnalytics
## 330                                                                                                                                                                                                          WiFiAnalytics
##                                                                                                           username
## 1                                                                                            pdr.higgins@gmail.com
## 2                                                                               com.apple.scopedbookmarksagent.xpc
## 3                                                                                                          default
## 4                                                                                                          default
## 5                                                                                            com.apple.CallHistory
## 6                                                                                              com.apple.clouddocs
## 7                                                                      com.apple.SafariShared.WBSCloudHistoryStore
## 8                                                                                                                 
## 9                                                                                                           Safari
## 10                                                e9a97d4986bc3f7c54e215b19fda27051d7c6ce8dd2a8c716632ecb9baa5bce4
## 11                                                bbefd137e887c47f8495be41c2e8a2d91ab38f84b8b483fc6f15b4758e3a7b18
## 12                                                                                                                
## 13                                                                                            higgi13425@yahoo.com
## 14                                                                                                          Safari
## 15                                                                                         fmfd-aps-token-username
## 16                                                                        2bf4e0a1358f6080420ad18d262bcbd2202bdd72
## 17                                                       localdevice274d0a8a-5bf5-5aca-a3ab-362b925f54ca-AuthToken
## 18                                                                                                 com.apple.notes
## 19                                                       pdr.higgins@gmail.com3FCF0381-C0B2-4534-9D76-8D992BDCA6BE
## 20                                                       pdr.higgins@gmail.comBB68689C-4E3E-4E0E-8615-65B027B4B9D9
## 21                                                                                                    bundleSeedID
## 22                                                                                        cGhpZ2dpbnNAdW1pY2guZWR1
## 23                                                                                               80:ea:96:e7:43:ae
## 24                                                                                                           OAuth
## 25                                                                                        cGhpZ2dpbnNAdW1pY2guZWR1
## 26                                                                                        cGhpZ2dpbnNAdW1pY2guZWR1
## 27                                                                                 amazon_cloud_player_remember_me
## 28                                                                                       com.apple.largeattachment
## 29                                                                                        cGhpZ2dpbnNAdW1pY2guZWR1
## 30                                                                                        cGhpZ2dpbnNAdW1pY2guZWR1
## 31                                                                                 /Users/peterhiggins/.ssh/id_rsa
## 32                                                                                                       appAnonID
## 33                                                                                                       appAnonID
## 34                                                                                 pdr.higgins@gmail.com-AuthToken
## 35                                                                            com.helpshift.deviceUniqueIdentifier
## 36                                                                                                            __hs
## 37                                                                          Microsoft Office Identities Settings 2
## 38                                                                                                                
## 39                                                                                            higgi13425@yahoo.com
## 40                                                                                                                
## 41                                                                                     com.apple.security.keychain
## 42                                                                   com.apple.SafariShared.WBSCloudBookmarksStore
## 43                                                                                       com.apple.knowledgestore2
## 44                                                                                      com.apple.securedBluetooth
## 45                                                                          com.apple.CoreSuggestions.PseudoEvents
## 46                                                                            com.apple.security.PCSIdentityBackup
## 47                                                                                          com.apple.siri.profile
## 48                                                                                        com.apple.siri.knowledge
## 49                                                                                             com.apple.bluetooth
## 50                                                                            com.apple.textinput.KeyboardServices
## 51                                                                                       com.apple.icloud-rawhide2
## 52                                                                                       com.apple.icloud-rawhide3
## 53                                                              com.apple.WebKit.WebCrypto.master+com.apple.Safari
## 54                                                       9980D418-5756-46F7-99F5-BAAFC46CB734 - Host Creation UUID
## 55                                                                                                   configuration
## 56                                                                                                           waldo
## 57                                                                                                           waldo
## 58                                                                             Microsoft Office Identities Cache 2
## 59                                                                                        com.apple.messages.cloud
## 60                                                                                                    deletionFlag
## 61                                                                                                       appAnonID
## 62                                                                                                       appAnonID
## 63                                                                                                       appAnonID
## 64                                                       higgi13425@yahoo.com-FB80BBBE-58A2-4E35-8D1E-6BDB7458458A
## 65                                                                  com.apple.quicktimeplayerx.YouTube.oauth-token
## 66                                                          com.apple.quicktimeplayerx.YouTube.oauth-refresh-token
## 67                                                                                                   AllHSProfiles
## 68                                                                                          lastLoggedInIdentifier
## 69                                                                                                      3941332313
## 70                                                                                             com.apple.Maps.Sync
## 71                                         https://vplacesint.med.umich.edu/Citrix/vplacesAuth/ExplicitForms/Start
## 72                                                                                                       appAnonID
## 73                                                                                                      3941332313
## 74                                                                                                      higgi13425
## 75        /Users/peterhiggins/Library/Application Support/Adobe/Acrobat/DC/Security/reader_fss_signature_initialsk
## 76              /Users/peterhiggins/Library/Application Support/Adobe/Acrobat/DC/Security/workflowDataCacheReaderk
## 77                                                                                  https://vplaces.med.umich.edu/
## 78                     /Users/peterhiggins/Library/Application Support/Adobe/Acrobat/DC/Security/ES_session_storek
## 79     /Users/peterhiggins/Library/Application Support/Adobe/Acrobat/DC/Security/acrobat_eureka_caching_key_storek
## 80       /Users/peterhiggins/Library/Application Support/Adobe/Acrobat/DC/Security/acrobat_fss_signature_initialsk
## 81                                                                                                            Zoom
## 82                                                                                         PNConfigurationDeviceID
## 83                                                                                             PNConfigurationUUID
## 84                                                                                              pn_publishSequence
## 85                                                                                                       appAnonID
## 86                                                                                   Siri Global - User Identifier
## 87                                                                                                            Zoom
## 88                                                                                              SWC Agent Database
## 89                                                                                    phiggins@email.med.umich.edu
## 90                                                                                           pdr.higgins@gmail.com
## 91                                                      pdr.higgins@gmail.com-FC61F671-38B7-4248-9B20-665F07014991
## 92                                                      pdr.higgins@gmail.com-3007D2C2-5FBA-4A98-985D-21E894F43011
## 93                                                                                                                
## 94                                                                            317E8977-13BE-4CD4-9FF3-F396535E48FC
## 95                                                                                           pdr.higgins@gmail.com
## 96                                                                                                    User OS Info
## 97                                                                           Siri Global - Logging User Identifier
## 98                                                                                                                
## 99                      /Users/peterhiggins/Library/Application Support/Adobe/Acrobat/DC/Security/searchDataCachek
## 100                                                   9980D418-5756-46F7-99F5-BAAFC46CB734 - Local Crypto Key Data
## 101                                               65b32966698820e956298f72d6a0a33993d934acbac7e7fe9732b0a5410bb4c8
## 102                                                                                      00008101-0005452E14C0001E
## 103                                                                                                         Chrome
## 104                                                                                          pdr.higgins@gmail.com
## 105                                                 9980D418-5756-46F7-99F5-BAAFC46CB734 - Server Certificate Data
## 106                                                            1:177223194525:ios:76d203d5a1553972__FIRAPP_DEFAULT
## 107                                                                                 com.microsoft.lync.certificate
## 108                                                                                         com.microsoft.lync.key
## 109                                          Microsoft Teams Identities Cache_1f41d613-d3a1-4ead-918d-2a25b10de330
## 110                                                                                                       App Info
## 111                                                                                                        discord
## 112                                                                           A9A5830D-F96E-4B23-A0D5-7014094728B0
## 113                                                                                                          Teams
## 114                                                                                                          teams
## 115                                                                                                          teams
## 116                                                                                                               
## 117                                                                                                               
## 118                                                                                                               
## 119          /Users/peterhiggins/Library/Application Support/Adobe/Acrobat/DC/Security/DCAPIDiscoveryCacheAcrobatk
## 120                                                                                          pdr.higgins@gmail.com
## 121                                                                                Microsoft Office Ticket Cache 2
## 122                                                                                            Slack App Store Key
## 123                                                                                                               
## 124                                                                                  Microsoft Office Ticket Cache
## 125                                      AAARijI5FMx-jb14NyZYH9Q6BB4lBd1XpMc__40F9DF58-039E-40F1-A3CD-490226F560C6
## 126                                      AAARijI5FMx-jb14NyZYH9Q6BB4lBd1XpMc__7EB20C05-66C8-4151-9A03-3B433077E00F
## 127                                                                               Microsoft Teams Identities Cache
## 128                                                                                                      adalcache
## 129                                                                                                               
## 130                                                    handoff-decryption-key-3B5C995B-4A70-46EF-8FA5-AF6A8D8B7EB6
## 131                                                                                                               
## 132                                                                                         FMFDStoreControllerKey
## 133                                                               Siri Global - AnalyticsIdentifiers.fixedDeviceId
## 134                                                                                   CloudFlare_OHTTP_Relay_Carry
## 135                                                                                                Microsoft Teams
## 136                                                                                                     1457225930
## 137                                                                            com.microsoft.OutlookCore.AccountV2
## 138                                                                                                     3481069885
## 139                                                                            Microsoft Office Identities Cache 3
## 140                                                                           CloudFlare_OHTTP_Relay_Carry_Staging
## 141                                                                                                        Apple_2
## 142                                                                                                       App Info
## 143                                                    handoff-decryption-key-F0384A42-87AF-41F5-A4DD-E12353FD9024
## 144                     /Users/peterhiggins/Library/Application Support/Adobe/Acrobat/DC/Security/AcroMLDataCachek
## 145                   /Users/peterhiggins/Library/Application Support/Adobe/Acrobat/DC/Security/workflowDataCachek
## 146                                                                                                       App Info
## 147                                                    handoff-decryption-key-94195545-BC3B-45FF-A720-3066E8EAD314
## 148                                                                      com.apple.continuity.auto-unlock.attested
## 149                                                                                                        User DT
## 150                                                                                                               
## 151                                                                                                       App Info
## 152                                                                                                       Positron
## 153                                                              Siri Global - com.apple.assistant.music.fusetoken
## 154                                                    handoff-decryption-key-53C91792-73B1-4277-A455-428B304D9E1B
## 155                                                    handoff-decryption-key-3FC361CC-4036-4255-B474-0F2B2357A185
## 156                                                    handoff-decryption-key-1D3B068C-DD25-4A0B-8016-371043696090
## 157                                                                                          pdr.higgins@gmail.com
## 158                                                                                          pdr.higgins@gmail.com
## 159                           /Users/peterhiggins/Library/Application Support/Adobe/Acrobat/DC/Security/Annssk.dat
## 160                                                    9980D418-5756-46F7-99F5-BAAFC46CB734 - Assistant Identifier
## 161                                            9980D418-5756-46F7-99F5-BAAFC46CB734 - Logging Assistant Identifier
## 162                                                       9980D418-5756-46F7-99F5-BAAFC46CB734 - Speech Identifier
## 163                                                                                      lastKnownFaceTimeCallerID
## 164                                                                                            registeredProviders
## 165                                                                           9C1AC72F-511A-46E3-88E3-64885BB78814
## 166                                                                                                       App Info
## 167                                                                                                       App Info
## 168                                                                                                         Akamai
## 169                                                                                       Window Bitmap Encryption
## 170                                                         9980D418-5756-46F7-99F5-BAAFC46CB734 - Validation Data
## 171 e6c3d4cc-993c-41e5-82c6-68254c71767f.1f41d613-d3a1-4ead-918d-2a25b10de330.e66e77b4-5724-44d7-8721-06df160450ce
## 172                                                                           897557a6-f7f7-4e15-b896-bd49d6ddca75
## 173                                                                         Microsoft Office Identities Settings 3
## 174                                                                                                               
## 175                                                                                                         Fastly
## 176                                                                                                    Apple_Relay
## 177                                                                                             Fastly_OHTTP_Relay
## 178                                                                                                CloudFlare_cp10
## 179                                                                                                     CloudFlare
## 180                                                                                                       App Info
## 181                                                                                                       App Info
## 182                                                                           e6c3d4cc-993c-41e5-82c6-68254c71767f
## 183                                                                  Siri Global - AnalyticsIdentifiers.checkpoint
## 184                                                                                         CloudFlare_OHTTP_Relay
## 185                                                                                          pdr.higgins@gmail.com
## 186                                                                                          pdr.higgins@gmail.com
## 187                                                                                     handoff-own-encryption-key
## 188                                                                                                          Apple
## 189                                                                                                  NETGEAR-Guest
## 190                                                                                                  villaflorida1
## 191                                                                                                   Medosz_Front
## 192                                                                                                    buckeye 210
## 193                                                                                                      medosz_8B
## 194                                                                                  Verizon MIFI4510L E927 Secure
## 195                                                                                                     Michigania
## 196                                                                                                      U10C022B7
## 197                                                                                                      Aran View
## 198                                                                                                 tep-modem-7fea
## 199                                                                                                        WebbNet
## 200                                                                                            Stauntons_GuestWiFi
## 201                                                                                                   Amity Coffee
## 202                                                                                                      medosz_7B
## 203                                                                                                  Evidera-Guest
## 204                                                                                                   ZyXEL202-203
## 205                                                                                                    Caesar_Hall
## 206                                                                                           safetourbus mobile 1
## 207                                                                                          Trans-CWB-2Andar (Me)
## 208                                                                                                      SBAD 2015
## 209                                                                                          Trans-CWB-3Andar (Me)
## 210                                                                                                       GVT-E3FC
## 211                                                                                          Trans-CWB-3Andar (Fr)
## 212                                                                                                  Merck - 23/11
## 213                                                                                                  Merck - 24/11
## 214                                                                                                    WebbnetDown
## 215                                                                                                      CampusNet
## 216                                                                                                         ECCO16
## 217                                                                                                  TonicLife2015
## 218                                                                                  MiFi4620L Jetpack E2D3 Secure
## 219                                                                                          Peter's Wi-Fi Network
## 220                                                                                  Peter's Library Wi-Fi Network
## 221                                                                                                      HiltonMTG
## 222                                                                                         Samsung Galaxy S7 9350
## 223                                                                                                     murphy2014
## 224                                                                                                        STELARA
## 225                                                                                                   Fischer Hall
## 226                                                                                                        Stelara
## 227                                                                                                murphy2014.2.4G
## 228                                                                                                 murphy2014.2.4
## 229                                                                                                       PRINCESS
## 230                                                                                 Knights Restaurant Public Wifi
## 231                                                                                                      SpeedNews
## 232                                                                                             Apples and Oranges
## 233                                                                                                  Joe&RosieWifi
## 234                                                                                                     ATTSzJhvMS
## 235                                                                                                  ZouZou's Cafe
## 236                                                                                                       CCFALink
## 237                                                                                                      colonial1
## 238                                                                                                Bayshore Resort
## 239                                                                                                       AB-Guest
## 240                                                                                            Cardinal 5836 Guest
## 241                                                                                                     YOTEL-Wifi
## 242                                                                                                  internet-10NP
## 243                                                                                                     MAXIMILIAN
## 244                                                                                                       AIBD2017
## 245                                                                                                   Sava's Guest
## 246                                                                                                   rstudio_conf
## 247                                                                                                      Jul_Menam
## 248                                                                                                    Jul note FE
## 249                                                                                                      HOME-4EB7
## 250                                                                                                  HOME-1841-2.4
## 251                                                                                                  Hotel_Famulus
## 252                                                                                     Dennis's Wi-Fi Network_EXT
## 253                                                                                                  Masonic_Event
## 254                                                                                                      ICConnect
## 255                                                                                                   deletionFlag
## 256                                                                                                     ATTgUEMmbA
## 257                                                                                                      NETGEAR35
## 258                                                                                                 AIBDWifiByBMS!
## 259                                                                                                      rstudio20
## 260                                                                                                       MOTOBBCA
## 261                                                                                                      NETGEAR11
## 262                                                                                                 Peter’s iPhone
## 263                                                                                                        Amplifi
## 264                                                                                            MySpectrumWiFi68-2G
## 265                                                                                            MySpectrumWiFi80-5G
## 266                                                                                                       WZ-Guest
## 267                                                                   com.apple.wifi.analytics.tokenStore.airportd
## 268                                                                                                  Identity Root
## 269                                                                                                Encryption Root
## 270                                                                                         Cloud Private Key Root
## 271                                                                                          Cloud Public Key Root
## 272                                                                                               Cloud Nonce Root
## 273                                                                                                    CT TKPeriod
## 274                                                                                             CT TEK BUFF V2 LEN
## 275                                                                                        Local Device Identifier
## 276                                                                                com.apple.LaunchServices.encr.3
## 277                                                                           44CEED20-EF9C-42CF-A88D-13E49433198A
## 278                                                                             Local Device Static Random Address
## 279                                                                                              Peter’s iPhone 13
## 280                                                                               Non Connectable identity address
## 281                                                                                  Non Connectable identity root
## 282                                                                                          Long Pond Cottage-PRO
## 283                                                                                                        Webbnet
## 284                                                                                                       Gartland
## 285                                                                                                      NETGEAR34
## 286                                                                                                    HOME-3EC2-5
## 287                                                                                                    hug2g966693
## 288                                                                                                    hug5g966693
## 289                                                                                              Long Pond Cottage
## 290                                                                                                  Fioptics07121
## 291                                                                                                       Rust2933
## 292                                                                                          Cloud Master Key Root
## 293                                                                                                       Wildcats
## 294                                                                                                   NETGEAR35-5G
## 295                                                                                                 SkyTeam Lounge
## 296                                                                                                   Rydges-Guest
## 297                                                                                                         AGW_24
## 298                                                                                                  TelstraE2D2C8
## 299                                                                                                    SPARK GUEST
## 300                                                                                               5404 Maryanna-5G
## 301                                                                                                      NachoWifi
## 302                                                              Public 08:FF:44:A2:D9:C1 Random D9:39:E3:50:39:3A
## 303                                                                                                   CCCongress25
## 304                                                                                               Cloud FC Address
## 305                                                              Random F3:B3:86:10:2C:FD Random D9:39:E3:50:39:3A
## 306                                                                                                            WEL
## 307                                                                                                   Victra-Guest
## 308                                                                                                         iPhone
## 309                                                                                                   Cadets Guest
## 310                                                              Public CC:3F:36:CB:7B:78 Random D9:39:E3:50:39:3A
## 311                                                                                                    BROWNS FOOD
## 312                                                                                                             Oc
## 313                                                                                                   Tipilikwani 
## 314                                                                                               Tipilikwani WiFi
## 315                                                                                                    Tipilikwani
## 316                                                              Public EC:A9:07:0C:94:EF Random D9:39:E3:50:39:3A
## 317                                                              Public 34:66:91:93:3B:49 Random D9:39:E3:50:39:3A
## 318                                                                                              Identity Root Key
## 319                                                                                                       phiggins
## 320                                                                                           UM-off-campus-access
## 321                                                                                                       phiggins
## 322                                                                                          UM-on-campus-wireless
## 323                                                                                              28:37:37:36:35:C6
## 324                                                                                              35:09:06:E7:23:9D
## 325                                                                                              90:9C:4A:09:DB:4E
## 326                                                                                              DC:A9:04:03:D7:1A
## 327                                                                                              1C:B3:C9:B2:DE:FF
## 328                                                                           com.apple.wifi.analytics.persistence
## 329                                                                        com.apple.wifi.analytics.persistence-iv
## 330                                                                       com.apple.wifi.analytics.persistence-tag
```

This gives you a list of all the keys stored by your operating system credential store.

## Setting New Keys

You can add a new secret with *key_set()*


``` r
key_set(service = "secure_web", username = "pdrh")
```

This will open an interactive window for you to securely enter your hidden password. This is stored in your credential store.

If you now run key_list(), and store it in a new object named keys, you can View this object and find new secret, named secure_web. Run the code chunk below.


``` r
keys <- key_list()
View(keys)
```

You may need to sort these secrets by service (click on the header of this column) to make it easier to find. Note that you see the service and username, but the password is not visible. To read the secret, you need to use the *key_get*() function.


``` r
secure_web_pwd <- key_get(service = "secure_web", username = "pdrh")
secure_web_pwd
```

This actually returns the password, in this case, to the console.

You can use this to respond to a password request, or pass the password to a web API. These often use a function to retrieve data that requires the username and password as arguments.

For the imaginary website, secure_web, we can use this approach to access web storage and retrieve files.


``` r
secure_web_pwd <- key_get(service = "secure_web", username = "pdrh")
get_secure_web_files(username = "pdrh", password = secure_web_pwd)
```

If you want to delete a secret, you can use key_delete()


``` r
key_delete(service = "secure_web", username = "pdrh")
```

You can check this by regenerating your keys dataframe


``` r
keys <- key_list()
View(keys)
```

You will find that the secret for secure_web is now gone from your Credential Store.

You can also use an R package named {credentials}, which is also popular, and it stores your credentials within git.

<https://happygitwithr.com/credential-caching.html>
