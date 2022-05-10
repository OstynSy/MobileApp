//
//  GameDescription.swift
//  MidtermApp
//
//  Created by JPL-ST-SPRING2021 on 5/3/22.
//

import Foundation
import UIKit

//https://stackoverflow.com/questions/13133014/how-can-i-create-a-uilabel-with-strikethrough-text
extension String {
    func strikeThrough() -> NSAttributedString {
        let attributeString =  NSMutableAttributedString(string: self)
        attributeString.addAttribute(
            NSAttributedString.Key.strikethroughStyle,
               value: NSUnderlineStyle.single.rawValue,
                   range:NSMakeRange(0,attributeString.length))
        return attributeString
    }
}


class GameDescriptionViewController: UIViewController{

    var game: Item?
    
    @IBOutlet weak var originalPrice: UILabel!
    @IBOutlet weak var discountPercent: UILabel!
    @IBOutlet weak var finalPrice: UILabel!
    @IBOutlet weak var HeaderImage: UIImageView!
    @IBOutlet weak var gameName: UILabel!
    @IBOutlet weak var discExp: UILabel!
    
    var ogPrice :Float = 0
    var fprice :Float = 0
    var dpercent = 0
    var ogPriceText = ""
    

    override func viewDidLoad() {
        Task {
            await MainActor.run {
                // Headers
                title = game?.name
                HeaderImage.downloaded(from: game?.headerImage ?? "")
                gameName.text = game?.name
                
                // Initialize values with data
                ogPrice = Float(game?.originalPrice ?? 0) / 100.00
                fprice = Float(game?.finalPrice ?? 0) / 100.00
                dpercent = game?.discountPercent ?? 0
                ogPriceText = "Original Price: $" + "\(ogPrice)"
                
                // text color
                originalPrice.textColor = UIColor.purple
                discountPercent.textColor = UIColor.green
                
                // Determine Discount Expiration Date
                let date = Date(timeIntervalSince1970: Double(game?.discountExpiration ?? 0000000000))
                let dateFormatter = DateFormatter()
                dateFormatter.timeZone = TimeZone(abbreviation: "PST")
                dateFormatter.locale = NSLocale.current
                dateFormatter.dateFormat = "MMM d, h:mm a"
                let strDate = dateFormatter.string(from: date)
                
                // determine what to display based on discount
                if(dpercent != 0){  // Has Discount
                    originalPrice.attributedText = ogPriceText.strikeThrough()
                    discountPercent.text = "Discount: " + "\(dpercent)" + "%"
                    finalPrice.text = "Discounted Price: $" + "\(fprice)"
                    discExp.text = "Discount Expires on: " + strDate
                }else{  // No discount
                    // If Free
                    if(ogPrice == 0){
                        originalPrice.text = "Original Price: Free"
                    }
                    // has Price
                    else{
                        originalPrice.text = ogPriceText
                    }
                    discExp.text = "Discount Expires on: No Current Discount"
                    discountPercent.text = "Discount: No Current Discount"
                    finalPrice.text = "Discounted Price: No Current Discount"
                }
//                    print("controller support", game?.controllerSupport)
//                    print("windows", game?.windowsAvailable)
                }
        }
    }
}
