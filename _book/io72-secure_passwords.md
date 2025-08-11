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
## 81                                                                                                                                                                                                                        
## 82                                                                                                                                                                                                       Zoom Safe Storage
## 83                                                                                                                                                                                                   com.bluejeansnet.Blue
## 84                                                                                                                                                                                                   com.bluejeansnet.Blue
## 85                                                                                                                                                                                                   com.bluejeansnet.Blue
## 86                                                                                                                                                                                com.microsoft.SkypeForBusiness.HockeySDK
## 87                                                                                                                                                                                                     com.apple.assistant
## 88                                                                                                                                                                                               Zoom Safe Meeting Storage
## 89                                                                                                                                                                                                      SWC Agent Database
## 90                                                                                                                                                                                                                Exchange
## 91                                                                                                                                                                     com.apple.account.AppleAccount.back-to-my-mac-token
## 92                                                                                                                                                                           com.apple.account.AppleIDAuthentication.token
## 93                                                                                                                                                               com.apple.account.AppleIDAuthentication.token-expiry-date
## 94                                                                                                                                                                                                 AppleIDClientIdentifier
## 95                                                                                                                                                                                    317E8977-13BE-4CD4-9FF3-F396535E48FC
## 96                                                                                                                                                                             com.apple.account.Google.oauth-token-nosync
## 97                                                                                                                                                                                                      Adobe User OS Info
## 98                                                                                                                                                                                                     com.apple.assistant
## 99                                                                                                                             com.adobe.creativecloud.com.adobe.acc.pmp.C2A135575CF3D7EC0A495FA8.ThirdPartyPluginsInstall
## 100                                                                                                                                                                                                                       
## 101                                                                                                                                                                                                    com.apple.assistant
## 102                                                                                                                                                                                                AirPlay Server Identity
## 103                                                                                                                                                                                                             iOS Backup
## 104                                                                                                                                                                                                    Chrome Safe Storage
## 105                                                                                                                                                                                     com.apple.account.GameCenter.token
## 106                                                                                                                                                                                                    com.apple.assistant
## 107                                                                                                                                        com.firebase.FIRInstallations.installations.1:177223194525:ios:76d203d5a1553972
## 108                                                                                                                                                                                   84ef17be-80f0-4750-a22c-c2a26ff1ba72
## 109                                                                                                                                                                                   84ef17be-80f0-4750-a22c-c2a26ff1ba72
## 110                                                                                                                                                                                       Microsoft Teams Identities Cache
## 111                                                                                                                                                                        Adobe App Info (Q0NMaWJyYXJ5MXt9MjAxODA3MjAwMQ)
## 112                                                                                                                                                                                                   discord Safe Storage
## 113                                                                                                                                                                                                com.microsoft.rdc.macos
## 114                                                                                                                                                                                                     Teams Safe Storage
## 115                                                                                                                                                                                                                teamsIv
## 116                                                                                                                                                                                                               teamsKey
## 117                                                                                                              com.adobe.creativecloud.com.adobe.acc.container.C2A135575CF3D7EC0A495FA8.AdobeStock:NOTIFICATION_GUID_KEY
## 118                                                                                                         com.adobe.creativecloud.com.adobe.acc.container.C2A135575CF3D7EC0A495FA8.AdobeStock:NOTIFICATION_TIMESTAMP_KEY
## 119                                                                                                              com.adobe.creativecloud.com.adobe.acc.container.C2A135575CF3D7EC0A495FA8.AdobeStock:NOTIFICATION_ETAG_KEY
## 120                                                                                                                                                                                                                       
## 121                                                                                                                                                                            com.apple.account.Google.oath-refresh-token
## 122                                                                                                                                                                                                                       
## 123                                                                                                                                                                                                     Slack Safe Storage
## 124                                                                                                                   com.adobe.creativecloud.com.adobe.acc.container.C2A135575CF3D7EC0A495FA8.AdobeStock:NOTIFICATION_KEY
## 125                                                                                                                                                                                                                       
## 126                                                                                                                             DBX_PASSWORDS_NMHAAARijI5FMx-jb14NyZYH9Q6BB4lBd1XpMc__40F9DF58-039E-40F1-A3CD-490226F560C6
## 127                                                                                                                             DBX_PASSWORDS_NMHAAARijI5FMx-jb14NyZYH9Q6BB4lBd1XpMc__7EB20C05-66C8-4151-9A03-3B433077E00F
## 128                                                                                                                                                                                       Microsoft Teams Identities Cache
## 129                                                                                                                                                                                                              AdalCache
## 130                                                                                                                                                                                   d211f69b-6302-418e-b36f-ae2aa01bdbfd
## 131                                                                                                                                                                                        com.apple.continuity.encryption
## 132                                                                                                                                                                                                        biofire_api_key
## 133                                                                                                                                                                                                    FMFDStoreController
## 134                                                                                                                                                                                                    com.apple.assistant
## 135                                                                                                                                                                               com.apple.NetworkServiceProxy.ProxyToken
## 136                                                                                                                                                                                           Microsoft Teams Safe Storage
## 137                                                                                                                                                                                                                 iCloud
## 138                                                                                                                                                                                    com.microsoft.OutlookCore.ServiceV2
## 139                                                                                                                                                                          com.garmin.cartography.mapupdate.express.auth
## 140                                                                                                                                                                                                                       
## 141                                                                                                                                                                               com.apple.NetworkServiceProxy.ProxyToken
## 142                                                                                                                                                                                                    com.apple.assistant
## 143                                                                                                                                                                               com.apple.NetworkServiceProxy.ProxyToken
## 144                                                                                                                                                                        Adobe App Info (Q0NMaWJyYXJ5Mnt9MjAxODA3MjAwMQ)
## 145                                                                                                                                                                                        com.apple.continuity.encryption
## 146                                                                                                                                                                                                                       
## 147                                                                                                                                                                                                                       
## 148                                                                                                                                                                                        com.apple.continuity.encryption
## 149                                                                                                                                                                   Adobe App Info (Q3JlYXRpdmVDbG91ZDJ7fTIwMTgwNzIwMDE)
## 150                                                                                                                                                                                        com.apple.continuity.encryption
## 151                                                                                                                                                                                   EDCA163A-9928-49A8-B539-BE9DE9A1B0E6
## 152                                                                                                                                                                                                        Adobe User Info
## 153                                                                                                                                                                           com.apple.scopedbookmarksagent.xpc.encrypted
## 154                                                                                                                                                                                                    com.apple.assistant
## 155                                                                                                                                                                                                    com.apple.assistant
## 156                                                                                                                                                                                                    com.apple.assistant
## 157                                                                                                                                                                        Adobe App Info (QWNyb2JhdERDMXt9MjAxODA3MjAwMQ)
## 158                                                                                                                                                                                        com.apple.continuity.encryption
## 159                                                                                                                                                                                        com.apple.continuity.encryption
## 160                                                                                                    com.adobe.creativecloud.com.adobe.acc.container.C2A135575CF3D7EC0A495FA8.AdobeStock:UPDATE_INDICATOR_VISIBILITY_KEY
## 161                                                                                                                                                                          Adobe App Info (Q29yZVN5bmMxe30yMDE4MDcyMDAx)
## 162                                                                                                                                                 com.apple.gs.icloud.auth.com.apple.account.AppleIDAuthentication.token
## 163                                                                                                                                                com.apple.gs.appleid.auth.com.apple.account.AppleIDAuthentication.token
## 164                                                                                                                                                                                             com.apple.ind.registration
## 165                                                                                                                                                                               com.apple.NetworkServiceProxy.ProxyToken
## 166                                                                                                                                                                                                         OneAuthAccount
## 167                                                                                                                                                                                                         OneAuthAccount
## 168                                                                                                                                                                                                     TelephonyUtilities
## 169                                                                                                                                                                                                     TelephonyUtilities
## 170                                                                                                                                                                       Adobe App Info (Q0NYUHJvY2VzczF7fTIwMTgwNzIwMDE)
## 171                                                                                                                                                                               com.apple.NetworkServiceProxy.ProxyToken
## 172                                                                                                                                                                               com.apple.NetworkServiceProxy.ProxyToken
## 173                                                                                                                                                                               com.apple.NetworkServiceProxy.ProxyToken
## 174                                                                                                                                                                               com.apple.NetworkServiceProxy.ProxyToken
## 175                                                                                                                                                                               com.apple.NetworkServiceProxy.ProxyToken
## 176                                                                                                                                                                               com.apple.NetworkServiceProxy.ProxyToken
## 177                                                                                                                                                                                                    com.apple.assistant
## 178                                                                                                                                                                             com.apple.account.Google.oauth-expiry-date
## 179                                                                                                                                                                                   com.apple.account.Google.oauth-token
## 180                                                                                                                                                                                      Apple Persistent State Encryption
## 181                                                                                                                                                                      Adobe App Info (SWxsdXN0cmF0b3Ixe30yMDE4MDcyMDAx)
## 182                                                                                                                                                                        Adobe App Info (UGhvdG9zaG9wMXt9MjAxODA3MjAwMQ)
## 183                                                                                                                                                                               com.apple.NetworkServiceProxy.ProxyToken
## 184                                                                                                                                                                                                         OneAuthAccount
## 185                                                                                                                                                                                                    com.apple.assistant
## 186                                                                                                                                                                                                                       
## 187                                                                                                                                                                                        com.apple.continuity.encryption
## 188                                                                                                                                                                                                                AirPort
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
## 254                                                                                                                                                                                    com.citrix.receiver.nomas.HockeySDK
## 255                                                                                                                                                                                                                AirPort
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
## 266                                                                                                                                                                                                          WiFiAnalytics
## 267                                                                                                                                                                                                        BluetoothGlobal
## 268                                                                                                                                                                                                        BluetoothGlobal
## 269                                                                                                                                                                                                        BluetoothGlobal
## 270                                                                                                                                                                                                        BluetoothGlobal
## 271                                                                                                                                                                                                        BluetoothGlobal
## 272                                                                                                                                                                                                        BluetoothGlobal
## 273                                                                                                                                                                                                        BluetoothGlobal
## 274                                                                                                                                                                                                        BluetoothGlobal
## 275                                                                                                                                                                                                                       
## 276                                                                                                                                                                                                Remote Pairing Identity
## 277                                                                                                                                                                                                        BluetoothGlobal
## 278                                                                                                                                                                                                                AirPort
## 279                                                                                                                                                                                                            BluetoothLE
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
## 308                                                                                                                                                                                                            BluetoothLE
## 309                                                                                                                                                                                                                AirPort
## 310                                                                                                                                                                                                        BluetoothGlobal
## 311                                                                                                                                                                             AF2710E6-F2E5-48E8-AFA4-28BBC7B9CEA8.XAUTH
## 312                                                                                                                                                                                AF2710E6-F2E5-48E8-AFA4-28BBC7B9CEA8.SS
## 313                                                                                                                                                                             FDB4238E-3A19-4058-AAEA-42DEAA52A9D8.XAUTH
## 314                                                                                                                                                                                FDB4238E-3A19-4058-AAEA-42DEAA52A9D8.SS
## 315                                                                                                                                                                                                        MobileBluetooth
## 316                                                                                                                                                                                                        MobileBluetooth
## 317                                                                                                                                                                                                        MobileBluetooth
## 318                                                                                                                                                                                                        MobileBluetooth
## 319                                                                                                                                                                                                          WiFiAnalytics
## 320                                                                                                                                                                                                          WiFiAnalytics
## 321                                                                                                                                                                                                          WiFiAnalytics
## 322                                                                                                                                                                                                        MobileBluetooth
## 323                                                                                                                                                                                                            BluetoothLE
## 324                                                                                                                                                                                                                AirPort
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
## 79                            /Users/peterhiggins/Library/Application Support/Adobe/Acrobat/DC/Security/Annssk.dat
## 80     /Users/peterhiggins/Library/Application Support/Adobe/Acrobat/DC/Security/acrobat_eureka_caching_key_storek
## 81       /Users/peterhiggins/Library/Application Support/Adobe/Acrobat/DC/Security/acrobat_fss_signature_initialsk
## 82                                                                                                            Zoom
## 83                                                                                         PNConfigurationDeviceID
## 84                                                                                             PNConfigurationUUID
## 85                                                                                              pn_publishSequence
## 86                                                                                                       appAnonID
## 87                                                                                   Siri Global - User Identifier
## 88                                                                                                            Zoom
## 89                                                                                              SWC Agent Database
## 90                                                                                    phiggins@email.med.umich.edu
## 91                                                                                           pdr.higgins@gmail.com
## 92                                                      pdr.higgins@gmail.com-FC61F671-38B7-4248-9B20-665F07014991
## 93                                                      pdr.higgins@gmail.com-3007D2C2-5FBA-4A98-985D-21E894F43011
## 94                                                                                                                
## 95                                                                            317E8977-13BE-4CD4-9FF3-F396535E48FC
## 96                                                                                           pdr.higgins@gmail.com
## 97                                                                                                    User OS Info
## 98                                                                           Siri Global - Logging User Identifier
## 99                                                                                                                
## 100                     /Users/peterhiggins/Library/Application Support/Adobe/Acrobat/DC/Security/searchDataCachek
## 101                                                   9980D418-5756-46F7-99F5-BAAFC46CB734 - Local Crypto Key Data
## 102                                               65b32966698820e956298f72d6a0a33993d934acbac7e7fe9732b0a5410bb4c8
## 103                                                                                      00008101-0005452E14C0001E
## 104                                                                                                         Chrome
## 105                                                                                          pdr.higgins@gmail.com
## 106                                                 9980D418-5756-46F7-99F5-BAAFC46CB734 - Server Certificate Data
## 107                                                            1:177223194525:ios:76d203d5a1553972__FIRAPP_DEFAULT
## 108                                                                                 com.microsoft.lync.certificate
## 109                                                                                         com.microsoft.lync.key
## 110                                          Microsoft Teams Identities Cache_1f41d613-d3a1-4ead-918d-2a25b10de330
## 111                                                                                                       App Info
## 112                                                                                                        discord
## 113                                                                           A9A5830D-F96E-4B23-A0D5-7014094728B0
## 114                                                                                                          Teams
## 115                                                                                                          teams
## 116                                                                                                          teams
## 117                                                                                                               
## 118                                                                                                               
## 119                                                                                                               
## 120          /Users/peterhiggins/Library/Application Support/Adobe/Acrobat/DC/Security/DCAPIDiscoveryCacheAcrobatk
## 121                                                                                          pdr.higgins@gmail.com
## 122                                                                                Microsoft Office Ticket Cache 2
## 123                                                                                            Slack App Store Key
## 124                                                                                                               
## 125                                                                                  Microsoft Office Ticket Cache
## 126                                      AAARijI5FMx-jb14NyZYH9Q6BB4lBd1XpMc__40F9DF58-039E-40F1-A3CD-490226F560C6
## 127                                      AAARijI5FMx-jb14NyZYH9Q6BB4lBd1XpMc__7EB20C05-66C8-4151-9A03-3B433077E00F
## 128                                                                               Microsoft Teams Identities Cache
## 129                                                                                                      adalcache
## 130                                                                                                               
## 131                                                    handoff-decryption-key-3B5C995B-4A70-46EF-8FA5-AF6A8D8B7EB6
## 132                                                                                                               
## 133                                                                                         FMFDStoreControllerKey
## 134                                                               Siri Global - AnalyticsIdentifiers.fixedDeviceId
## 135                                                                                   CloudFlare_OHTTP_Relay_Carry
## 136                                                                                                Microsoft Teams
## 137                                                                                                     1457225930
## 138                                                                            com.microsoft.OutlookCore.AccountV2
## 139                                                                                                     3481069885
## 140                                                                            Microsoft Office Identities Cache 3
## 141                                                                           CloudFlare_OHTTP_Relay_Carry_Staging
## 142                                                              Siri Global - com.apple.assistant.music.fusetoken
## 143                                                                                                        Apple_2
## 144                                                                                                       App Info
## 145                                                    handoff-decryption-key-F0384A42-87AF-41F5-A4DD-E12353FD9024
## 146                     /Users/peterhiggins/Library/Application Support/Adobe/Acrobat/DC/Security/AcroMLDataCachek
## 147                   /Users/peterhiggins/Library/Application Support/Adobe/Acrobat/DC/Security/workflowDataCachek
## 148                                                    handoff-decryption-key-1D3B068C-DD25-4A0B-8016-371043696090
## 149                                                                                                       App Info
## 150                                                    handoff-decryption-key-94195545-BC3B-45FF-A720-3066E8EAD314
## 151                                                                      com.apple.continuity.auto-unlock.attested
## 152                                                                                                        User DT
## 153                                                                                                               
## 154                                                    9980D418-5756-46F7-99F5-BAAFC46CB734 - Assistant Identifier
## 155                                            9980D418-5756-46F7-99F5-BAAFC46CB734 - Logging Assistant Identifier
## 156                                                       9980D418-5756-46F7-99F5-BAAFC46CB734 - Speech Identifier
## 157                                                                                                       App Info
## 158                                                    handoff-decryption-key-53C91792-73B1-4277-A455-428B304D9E1B
## 159                                                    handoff-decryption-key-3FC361CC-4036-4255-B474-0F2B2357A185
## 160                                                                                                               
## 161                                                                                                       App Info
## 162                                                                                          pdr.higgins@gmail.com
## 163                                                                                          pdr.higgins@gmail.com
## 164                                                                           9C1AC72F-511A-46E3-88E3-64885BB78814
## 165                                                                                                         Akamai
## 166 e6c3d4cc-993c-41e5-82c6-68254c71767f.1f41d613-d3a1-4ead-918d-2a25b10de330.e66e77b4-5724-44d7-8721-06df160450ce
## 167                                                                           897557a6-f7f7-4e15-b896-bd49d6ddca75
## 168                                                                                      lastKnownFaceTimeCallerID
## 169                                                                                            registeredProviders
## 170                                                                                                       App Info
## 171                                                                                                    Apple_Relay
## 172                                                                                                         Fastly
## 173                                                                                             Fastly_OHTTP_Relay
## 174                                                                                                     CloudFlare
## 175                                                                                                CloudFlare_cp10
## 176                                                                                         CloudFlare_OHTTP_Relay
## 177                                                         9980D418-5756-46F7-99F5-BAAFC46CB734 - Validation Data
## 178                                                                                          pdr.higgins@gmail.com
## 179                                                                                          pdr.higgins@gmail.com
## 180                                                                                       Window Bitmap Encryption
## 181                                                                                                       App Info
## 182                                                                                                       App Info
## 183                                                                                                          Apple
## 184                                                                           e6c3d4cc-993c-41e5-82c6-68254c71767f
## 185                                                                  Siri Global - AnalyticsIdentifiers.checkpoint
## 186                                                                         Microsoft Office Identities Settings 3
## 187                                                                                     handoff-own-encryption-key
## 188                                                                                                  NETGEAR-Guest
## 189                                                                                                  villaflorida1
## 190                                                                                                   Medosz_Front
## 191                                                                                                    buckeye 210
## 192                                                                                                      medosz_8B
## 193                                                                                  Verizon MIFI4510L E927 Secure
## 194                                                                                                     Michigania
## 195                                                                                                      U10C022B7
## 196                                                                                                      Aran View
## 197                                                                                                 tep-modem-7fea
## 198                                                                                                        WebbNet
## 199                                                                                            Stauntons_GuestWiFi
## 200                                                                                                   Amity Coffee
## 201                                                                                                      medosz_7B
## 202                                                                                                  Evidera-Guest
## 203                                                                                                   ZyXEL202-203
## 204                                                                                                    Caesar_Hall
## 205                                                                                           safetourbus mobile 1
## 206                                                                                          Trans-CWB-2Andar (Me)
## 207                                                                                                      SBAD 2015
## 208                                                                                          Trans-CWB-3Andar (Me)
## 209                                                                                                       GVT-E3FC
## 210                                                                                          Trans-CWB-3Andar (Fr)
## 211                                                                                                  Merck - 23/11
## 212                                                                                                  Merck - 24/11
## 213                                                                                                    WebbnetDown
## 214                                                                                                      CampusNet
## 215                                                                                                         ECCO16
## 216                                                                                                  TonicLife2015
## 217                                                                                  MiFi4620L Jetpack E2D3 Secure
## 218                                                                                          Peter's Wi-Fi Network
## 219                                                                                  Peter's Library Wi-Fi Network
## 220                                                                                                      HiltonMTG
## 221                                                                                         Samsung Galaxy S7 9350
## 222                                                                                                     murphy2014
## 223                                                                                                        STELARA
## 224                                                                                                   Fischer Hall
## 225                                                                                                        Stelara
## 226                                                                                                murphy2014.2.4G
## 227                                                                                                 murphy2014.2.4
## 228                                                                                                       PRINCESS
## 229                                                                                 Knights Restaurant Public Wifi
## 230                                                                                                      SpeedNews
## 231                                                                                             Apples and Oranges
## 232                                                                                                  Joe&RosieWifi
## 233                                                                                                     ATTSzJhvMS
## 234                                                                                                  ZouZou's Cafe
## 235                                                                                                       CCFALink
## 236                                                                                                      colonial1
## 237                                                                                                Bayshore Resort
## 238                                                                                                       AB-Guest
## 239                                                                                            Cardinal 5836 Guest
## 240                                                                                                     YOTEL-Wifi
## 241                                                                                                  internet-10NP
## 242                                                                                                     MAXIMILIAN
## 243                                                                                                       AIBD2017
## 244                                                                                                   Sava's Guest
## 245                                                                                                   rstudio_conf
## 246                                                                                                      Jul_Menam
## 247                                                                                                    Jul note FE
## 248                                                                                                      HOME-4EB7
## 249                                                                                                  HOME-1841-2.4
## 250                                                                                                  Hotel_Famulus
## 251                                                                                     Dennis's Wi-Fi Network_EXT
## 252                                                                                                  Masonic_Event
## 253                                                                                                      ICConnect
## 254                                                                                                   deletionFlag
## 255                                                                                                     ATTgUEMmbA
## 256                                                                                                      NETGEAR35
## 257                                                                                                 AIBDWifiByBMS!
## 258                                                                                                      rstudio20
## 259                                                                                                       MOTOBBCA
## 260                                                                                                      NETGEAR11
## 261                                                                                                 Peter’s iPhone
## 262                                                                                                        Amplifi
## 263                                                                                            MySpectrumWiFi68-2G
## 264                                                                                            MySpectrumWiFi80-5G
## 265                                                                                                       WZ-Guest
## 266                                                                   com.apple.wifi.analytics.tokenStore.airportd
## 267                                                                                                  Identity Root
## 268                                                                                                Encryption Root
## 269                                                                                         Cloud Private Key Root
## 270                                                                                          Cloud Public Key Root
## 271                                                                                               Cloud Nonce Root
## 272                                                                                                    CT TKPeriod
## 273                                                                                             CT TEK BUFF V2 LEN
## 274                                                                                        Local Device Identifier
## 275                                                                                com.apple.LaunchServices.encr.3
## 276                                                                           44CEED20-EF9C-42CF-A88D-13E49433198A
## 277                                                                             Local Device Static Random Address
## 278                                                                                              Peter’s iPhone 13
## 279                                                              Public EC:A9:07:0C:94:EF Random D9:39:E3:50:39:3A
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
## 308                                                              Public 34:66:91:93:3B:49 Random D9:39:E3:50:39:3A
## 309                                                                                                         iPhone
## 310                                                                                              Identity Root Key
## 311                                                                                                       phiggins
## 312                                                                                           UM-off-campus-access
## 313                                                                                                       phiggins
## 314                                                                                          UM-on-campus-wireless
## 315                                                                                              28:37:37:36:35:C6
## 316                                                                                              35:09:06:E7:23:9D
## 317                                                                                              90:9C:4A:09:DB:4E
## 318                                                                                              DC:A9:04:03:D7:1A
## 319                                                                           com.apple.wifi.analytics.persistence
## 320                                                                        com.apple.wifi.analytics.persistence-iv
## 321                                                                       com.apple.wifi.analytics.persistence-tag
## 322                                                                                              1C:B3:C9:B2:DE:FF
## 323                                                              Public CC:3F:36:CB:7B:78 Random D9:39:E3:50:39:3A
## 324                                                                                                   Cadets Guest
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
