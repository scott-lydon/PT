

import Foundation

extension Get {
    
    /*
 ["dogs", "puppies", "kittens", "cats", "penguin", "otter", "red+panda", "fennec+fox", "baby+hamster", "baby+mouse", "baby+elephant", "baby+seal", "baby+raccoon", "baby+pig", "baby+bunny", "bunny", "baby+sloth", "baby+panda", "baby+fox", "baby+monkey", "baby+hedgehog", "duckling", "kitten", "baby+ferret"]
 */
    
    func getYoutubeUrl(animalType: String) -> String {
        
        var videoID = ""
        let youtube = "https://www.youtube.com/watch?v="
        switch animalType {
        case "dogs", "puppies":
            videoID = "jKTzjEOqA3I"
        case "kittens", "cats":
            videoID = "4IP_E7efGWE"
        case "penguin":
            videoID = "8T86S_6gBWk"
        case "otter":
            videoID = "5GyhFsJoiYc"
        case "red+panda":
            videoID = "aaMdE6-U56Y"
        case "fennec+fox":
            videoID = "Y3fJmRRq0Ac&t=169s"
        case "baby+hamster":
            videoID = "riswlZTBilE"
        case "baby+mouse":
            videoID = "1qpDrH0JeNg"
        case "baby+elephant":
            videoID = "cQzV_p8fJ9U&t=175s"
        case "baby+seal":
            videoID = "8QWQZnBDf68"
        case "baby+raccoon":
            videoID = "vBX9SCtDrxs&t=58s"
        case "baby+pig":
            videoID = "3g_BO_Pjc-w"
        case "baby+bunny", "bunny":
            videoID = "AXT4fBWfN1Y"
        case "baby+sloth":
            videoID = "aaqzPMOd_1g"
        case "baby+panda":
            videoID = "__ztT6Hjw_o"
        case "baby+fox":
            videoID = "6HuIs2xW5kI"
        case "baby+monkey":
            videoID = "Vu55-haigoI"
        case "baby+hedgehog":
            videoID = "OjbpkginCSI"
        case "duckling":
            videoID = "A_rZ6xx1fbQ"
        case "kitten":
            videoID = "4IP_E7efGWE"
        case "baby+ferret":
            videoID = "ex9AXcYR_a0"
        default:
            videoID = ""
        }
        return youtube + videoID
    }//func
}//giphyVC
