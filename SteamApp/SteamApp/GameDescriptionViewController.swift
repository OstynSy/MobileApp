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

////https://stackoverflow.com/questions/24231680/loading-downloading-image-from-url-on-swift
//extension UIImageView {
//    func downloaded(from url: URL, contentMode mode: ContentMode = .scaleAspectFit) {
//        contentMode = mode
//        URLSession.shared.dataTask(with: url) { data, response, error in
//            guard
//                let httpURLResponse = response as? HTTPURLResponse, httpURLResponse.statusCode == 200,
//                let mimeType = response?.mimeType, mimeType.hasPrefix("image"),
//                let data = data, error == nil,
//                let image = UIImage(data: data)
//                else { return }
//            DispatchQueue.main.async() { [weak self] in
//                self?.image = image
//            }
//        }.resume()
//    }
//    func downloaded(from link: String, contentMode mode: ContentMode = .scaleAspectFit) {
//        guard let url = URL(string: link) else { return }
//        downloaded(from: url, contentMode: mode)
//    }
//}

class GameDescriptionViewController: UIViewController{

//    var stop: Stop?
//    var times: Directions?
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
            do {
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
                    originalPrice.textColor = UIColor(red: 50, green: 0, blue: 50, alpha: 1.0)
                    discountPercent.textColor = UIColor(red: 0, green: 50, blue: 0, alpha: 1.0)
                    
                    // Determine Discount Expiration Date
                    let date = Date(timeIntervalSince1970: Double(game?.discountExpiration ?? 0000000000))
                    let dateFormatter = DateFormatter()
                    dateFormatter.timeZone = TimeZone(abbreviation: "PST")
                    dateFormatter.locale = NSLocale.current
                    dateFormatter.dateFormat = "MMM d, h:mm a"
                    let strDate = dateFormatter.string(from: date)
                    print("TESTING", strDate)
                    
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
                    


                    print("headline", game?.headline)
//                    print("controller support", game?.controllerSupport)
//                    print("windows", game?.windowsAvailable)
                    print("disc expire", game?.discountExpiration)
                }
            } catch {
                print(error)
            }

        }
    }
}
