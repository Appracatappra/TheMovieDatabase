//
//  TMDError.swift
//  TheMovieDatabase
//
//  Created by Kevin Mullins on 5/22/25.
//

/// A custom Error that can be thrown from The Movie Database.
public enum TMDError: Error {
    
    // MARK: - Cases
    /// An invalid status code was sent from a RESTful API request.
    /// `statusCode` contains the status code returned.
    case invalidStatusCode(statusCode:Int)
    
    /// An invalid URL was created.
    /// `url` holds the string of the url that raised the error.
    case invalidURL(url:String)
    
    // MARK: - Static Functions
    /// Gets the definition of a given status code.
    /// - Parameter statusCode: The code to get the definition for.
    /// - Returns: Return the human readable definition for the code.
    public static func definition(statusCode:Int) -> String {
        
        // Take action based on the given code.
        switch statusCode {
        case 200:
            return "Successful."
            
        case 201:
            return "The item/record was updated successfully."
            
        case 400:
            return "Validation failed."
            
        case 401:
            return "Authentication failed: You do not have permissions to access the service."
            
        case 403:
            return "Duplicate entry: The data you tried to submit already exists."
            
        case 404:
            return "Invalid id: The pre-requisite id is invalid or not found."
            
        case 405:
            return "Invalid format: This service doesn't exist in that format."
            
        case 406:
            return "Invalid accept header."
            
        case 422:
            return "Invalid parameters: Your request parameters are incorrect."
            
        case 429:
            return "Your request count (#) is over the allowed limit of (40)."
            
        case 500:
            return "Internal error: Something went wrong, contact TMDB."
            
        case 501:
            return "Invalid service: this service does not exist."
            
        case 503:
            return "Service offline: This service is temporarily offline, try again later."
            
        case 504:
            return "Your request to the backend server timed out. Try again."
         
        default:
            return "An unknown error occurred."
        }
    }
    
    /// Gets the definition of a given The Movie Database code.
    /// - Parameter tmdCode: The code to get the definition for.
    /// - Returns: Return the human readable definition for the code.
    public static func definition(tmdCode:Int) -> String {
        
        switch(tmdCode) {
        case 1:
            return "Success.";
            
        case 2:
            return "Invalid service: this service does not exist.";
            
        case 3:
            return "Authentication failed: You do not have permissions to access the service.";
            
        case 4:
            return "Invalid format: This service doesn't exist in that format.";
            
        case 5:
            return "Invalid parameters: Your request parameters are incorrect.";
            
        case 6:
            return "Invalid id: The pre-requisite id is invalid or not found.";
            
        case 7:
            return "Invalid API key: You must be granted a valid key.";
            
        case 8:
            return "Duplicate entry: The data you tried to submit already exists.";
            
        case 9:
            return "Service offline: This service is temporarily offline, try again later.";
            
        case 10:
            return "Suspended API key: Access to your account has been suspended, contact TMDB.";
            
        case 11:
            return "Internal error: Something went wrong, contact TMDB.";
            
        case 12:
            return "The item/record was updated successfully.";
            
        case 13:
            return "The item/record was deleted successfully.";
            
        case 14:
            return "Authentication failed.";
            
        case 15:
            return "Failed.";
            
        case 16:
            return "Device denied.";
            
        case 17:
            return "Session denied.";
            
        case 18:
            return "Validation failed.";
            
        case 19:
            return "Invalid accept header.";
            
        case 20:
            return "Invalid date range: Should be a range no longer than 14 days.";
            
        case 21:
            return "Entry not found: The item you are trying to edit cannot be found.";
            
        case 22:
            return "Invalid page: Pages start at 1 and max at 500. They are expected to be an integer.";
            
        case 23:
            return "Invalid date: Format needs to be YYYY-MM-DD.";
            
        case 24:
            return "Your request to the backend server timed out. Try again.";
            
        case 25:
            return "Your request count (#) is over the allowed limit of (40).";
            
        case 26:
            return "You must provide a username and password.";
            
        case 27:
            return "Too many append to response objects: The maximum number of remote calls is 20.";
            
        case 28:
            return "Invalid timezone: Please consult the documentation for a valid timezone.";
            
        case 29:
            return "You must confirm this action: Please provide a confirm=true parameter.";
            
        case 30:
            return "Invalid username and/or password: You did not provide a valid login.";
            
        case 31:
            return "Account disabled: Your account is no longer active. Contact TMDB if this is an error.";
            
        case 32:
            return "Email not verified: Your email address has not been verified.";
            
        case 33:
            return "Invalid request token: The request token is either expired or invalid.";
            
        case 34:
            return "The resource you requested could not be found.";
            
        case 35:
            return "Invalid token.";
            
        case 36:
            return "This token hasn't been granted write permission by the user.";
            
        case 37:
            return "The requested session could not be found.";
            
        case 38:
            return "You don't have permission to edit this resource.";
            
        case 39:
            return "This resource is private.";
            
        case 40:
            return "Nothing to update.";
            
        case 41:
            return "This request token hasn't been approved by the user.";
            
        case 42:
            return "This request method is not supported for this resource.";
            
        case 43:
            return "Couldn't connect to the backend server.";
            
        case 44:
            return "The ID is invalid.";
            
        case 45:
            return "This user has been suspended.";
            
        case 46:
            return "The API is undergoing maintenance. Try again later.";
            
        case 47:
            return "The input is not valid.";
            
        default:
            return "An unknown error occurred."
        }
    }
}
