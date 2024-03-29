/*
 * Copyright 2021 Amazon.com, Inc. or its affiliates. All Rights Reserved.
 *
 * Licensed under the Apache License, Version 2.0 (the "License").
 * You may not use this file except in compliance with the License.
 * A copy of the License is located at
 *
 *  http://aws.amazon.com/apache2.0
 *
 * or in the "license" file accompanying this file. This file is distributed
 * on an "AS IS" BASIS, WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either
 * express or implied. See the License for the specific language governing
 * permissions and limitations under the License.
 */

import Foundation
import Amplify
import AmplifyPlugins
import amplify_core

struct FlutterSignInWithWebUIRequest {
  var provider: AuthProvider?
  var isPreferPrivateSession: Bool = false

  init(dict: NSMutableDictionary){
    self.provider = getAuthProvider(provider: dict["authProvider"] as! String?)
    if let options = dict["options"] as? [String: Any] {
       self.isPreferPrivateSession = options["isPreferPrivateSession"] as! Bool
    }
  }

  func getAuthProvider(provider: String?) -> AuthProvider? {
    if (provider != nil) {
      switch provider {
        case "facebook":
          return AuthProvider.facebook
        case "amazon":
          return AuthProvider.amazon
        case "google":
          return AuthProvider.google
        case "apple":
          return AuthProvider.apple
        default:
          return nil
      }
    }
    return nil
  }

  static func validate(dict: NSMutableDictionary) throws {
    let validationErrorMessage = "SignInWithWebUI Request malformed."
    let allowedProviders: Array<String> = ["amazon", "google", "facebook","apple"]
    if let provider = dict["authProvider"] {
      if(!allowedProviders.contains(provider as! String)) {
        throw InvalidRequestError.auth(comment: validationErrorMessage,
                                          suggestion: String(format: ErrorMessages.missingAttribute, "valid AuthProvider"))
      }
    }
  }
}
