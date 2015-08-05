//
//  LoginService.swift
//  TwitterClone
//
//  Created by Edrease Peshtaz on 8/4/15.
//  Copyright (c) 2015 MysterioGroupSoftware. All rights reserved.
//

import Foundation
import Accounts

class LoginService {
  class func loginToTwitter(completionHandler: (String?, ACAccount?) -> (Void)) {
    let accountStore = ACAccountStore()
    let accountType = accountStore.accountTypeWithAccountTypeIdentifier(ACAccountTypeIdentifierTwitter)
    
    accountStore.requestAccessToAccountsWithType(accountType, options: nil) { (granted, error) -> Void in
      if let error = error {
        completionHandler("There was an error", nil)
        return
      } else if granted {
        if let account = accountStore.accountsWithAccountType(accountType).last as? ACAccount {
          completionHandler(nil, account)
          return
        }
      } else {
        completionHandler("This app requires Twitter access", nil)
        return
      }
    }
  }
}
