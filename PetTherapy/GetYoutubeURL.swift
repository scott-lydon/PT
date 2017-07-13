

import Foundation

extension Get {
    
    /*
 ["dogs", "puppies", "kittens", "cats", "penguin", "otter", "red+panda", "fennec+fox", "baby+hamster", "baby+mouse", "baby+elephant", "baby+seal", "baby+raccoon", "baby+pig", "baby+bunny", "bunny", "baby+sloth", "baby+panda", "baby+fox", "baby+monkey", "baby+hedgehog", "duckling", "kitten", "baby+ferret"]
 */
    
    func getYoutubeUrl(animalType: String) -> String {
        
        var returnString = ""
        switch animalType {
        case "dogs", "puppies":
            returnString = "https://www.youtube.com/watch?v=jKTzjEOqA3I"
        case "kittens", "cats":
            returnString = "https://www.youtube.com/watch?v=4IP_E7efGWE"
        case "penguin":
            returnString = "https://www.youtube.com/watch?v=8T86S_6gBWk"
            //https://www.youtube.com/watch?v=uFaHk2fFEhY
        case "otter":
            returnString = "https://www.youtube.com/watch?v=5GyhFsJoiYc"
            //https://www.youtube.com/watch?v=gw_yPqiiPIA
            //https://www.youtube.com/watch?v=VoXGG5byktw
        case "red+panda":
            returnString = "https://www.youtube.com/watch?v=aaMdE6-U56Y"
            //https://www.youtube.com/watch?v=9i-Yav3s6rU
        case "fennec+fox":
            returnString = "https://www.youtube.com/watch?v=Y3fJmRRq0Ac&t=169s"
        case "baby+hamster":
            returnString = "https://www.youtube.com/watch?v=riswlZTBilE"
            //https://www.youtube.com/watch?v=GYvApvHOPXc
        case "baby+mouse":
            returnString = "https://www.youtube.com/watch?v=1qpDrH0JeNg"
        case "baby+elephant":
            returnString = "https://www.youtube.com/watch?v=cQzV_p8fJ9U&t=175s"
        case "baby+seal":
            returnString = "https://www.youtube.com/watch?v=8QWQZnBDf68"
        case "baby+raccoon":
            returnString = "https://www.youtube.com/watch?v=vBX9SCtDrxs&t=58s"
        case "baby+pig":
            returnString = "https://www.youtube.com/watch?v=3g_BO_Pjc-w"
        case "baby+bunny", "bunny":
            returnString = "https://www.youtube.com/watch?v=AXT4fBWfN1Y"
        case "baby+sloth":
            returnString = "https://www.youtube.com/watch?v=aaqzPMOd_1g"
        case "baby+panda":
            returnString = "https://www.youtube.com/watch?v=__ztT6Hjw_o"
        case "baby+fox":
            returnString = "https://www.youtube.com/watch?v=6HuIs2xW5kI"
        case "baby+monkey":
            returnString = "https://www.youtube.com/watch?v=Vu55-haigoI"
        case "baby+hedgehog":
            returnString = "https://www.youtube.com/watch?v=OjbpkginCSI"
        case "duckling":
            returnString = "https://www.youtube.com/watch?v=A_rZ6xx1fbQ"
        case "kitten":
            returnString = "https://www.youtube.com/watch?v=4IP_E7efGWE"
        case "baby+ferret":
            returnString = "https://www.youtube.com/watch?v=ex9AXcYR_a0"
        default:
            returnString = ""
        }
        return returnString
    }//func
}//giphyVC
