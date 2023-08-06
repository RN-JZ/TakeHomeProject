

import Foundation



import Foundation

enum GHError:String , Error
{
    case invalidUsername       =   "This username created an invalid request. Please try again."
    case incompleteRequest     =   "Unable to complete your request. Please check your internet connection"
    case invalidRenponse       =   "Invalid response from the server. Please try again."
    case invalidData           =   "The data received from the server was invalid. Please try again."
    case alreadyPresent        =   "DATA IS ALREADY PRESENT"
}
