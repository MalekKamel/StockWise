//
// Created by Kamel on 04/02/2023.
//

import Foundation

public class AppCrashlytics {

    public class func record(
            description: String,
            failure: String
    ) {
        let error = NSError(
                domain: "Caught Error",
                code: 100,
                userInfo: [
                    "description": description,
                    "failure": failure
                ]
        )
        record(error: error)
    }

    public class func record(error: Error) {
        print(error)
        // TODO: Record the error in Crashlytics
    }

}

