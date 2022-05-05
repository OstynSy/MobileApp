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
    var specials: Item?
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
                let Welcome = try await networking.fetchGames()
                await MainActor.run {
                    // labels

                }
            } catch {
                print(error)
            }

        }
    }
}
