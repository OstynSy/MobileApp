import UIKit

class SpecialCell: UITableViewCell {
    
}

class TodoViewController: UIViewController, UITableViewDataSource, UITableViewDelegate{
    
    //@IBOutlet weak var OGPrice: UILabel!
    @IBOutlet weak var tableView: UITableView!
    //@IBOutlet weak var DiscPrice: UILabel!
    //@IBOutlet weak var Discount: UILabel!
    
    // iboutlet for image
    //@IBOutlet weak var DiscountLabel: UILabel!
    
    let networking = Networking()
    var specials: [Item] = []
    
    override func viewDidLoad() {
        print("testing api call 1")
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(SpecialCell.self, forCellReuseIdentifier: "SpecialCell")
        
        Task {
            do {
                let Welcome = try await networking.fetchGames()
                await MainActor.run {
                    print("=====TESTING API=====")
                    specials = Welcome.specials.items
                    print(Welcome.specials.name)
                    print(Welcome.specials.items[0])
                    print(Welcome.comingSoon.name)
                    print(Welcome.comingSoon.items[0].name)

                    //stops = routeConfig.route.stop
                    tableView.reloadData()
                }
            } catch {
                print(error)
            }
        }
    }
    

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "SpecialCell") as? SpecialCell else {
            return UITableViewCell()
        }

        cell.textLabel?.text = specials[indexPath.row].name
        //cell.Discount.text = "test"
        //OGPrice.text = String(specials[indexPath.row].finalPrice)
        // image of game
        // original price of game
        // discounted price of game
        return cell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        print("NUMBER OF SPECIALS")
        print(specials.count)
        return specials.count
    }
    
    //segue to description of game
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "ToDescriptionSeque", sender: indexPath)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let PredictionsViewController = segue.destination as? GameDescriptionViewController else {
            return
        }
        guard let indexPath = sender as? IndexPath else {
            return
        }
        let special = specials[indexPath.row]
//
    }
    
}
