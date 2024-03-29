/*
 * Copyright 2020 Amazon.com, Inc. or its affiliates. All Rights Reserved.
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

struct FlutterResendSignUpCodeRequest {
  var username: String
  var options: AuthResendSignUpCodeRequest.Options?
  init(dict: NSMutableDictionary){
    self.username = dict["username"] as! String
    self.options = createOptions(options: dict["options"] as! Dictionary<String, Any>?)
  }

  func createOptions(options: Dictionary<String, Any>?) -> AuthResendSignUpCodeOperation.Request.Options {
    let pluginOptions =  AWSAuthResendSignUpCodeOptions(
        metadata: options?["clientMetadata"] as? [String : String]
    )
    return AuthResendSignUpCodeOperation.Request.Options(pluginOptions: pluginOptions)
  }
    
  static func validate(dict: NSMutableDictionary) throws {
    let validationErrorMessage = "ResendSignUpCode Request malformed."
    if (dict["username"] == nil) {
        throw InvalidRequestError.auth(comment: validationErrorMessage,
                                          suggestion: String(format: ErrorMessages.missingAttribute, "username"))
    }
  }
}
