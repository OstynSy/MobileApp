//
//  GameDescription.swift
//  MidtermApp
//
//  Created by JPL-ST-SPRING2021 on 5/3/22.
//

import Foundation
import UIKit

class GameDescriptionViewController: UIViewController{

//    var stop: Stop?
//    var times: Directions?
    var game: Item?
    let networking = Networking()
    
//    @IBOutlet weak var StationLabel:UILabel!
//    @IBOutlet weak var DirectionLabel:UILabel!
//    @IBOutlet weak var MinutesLabel1:UILabel!
//    @IBOutlet weak var MinutesLabel2:UILabel!
//    @IBOutlet weak var MinutesLabel3:UILabel!
    
    override func viewDidLoad() {
        
//        guard let specials = specials else {
//            return
//        }

        Task {
            do {
                await MainActor.run {
                    title = game?.name
                }
            } catch {
                print(error)
            }

        }
    }
}
