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
    
    override func viewDidLoad() {

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
