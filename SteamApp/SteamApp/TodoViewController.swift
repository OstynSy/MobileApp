import UIKit

class SpecialCell: UITableViewCell {
    
}

//https://stackoverflow.com/questions/24231680/loading-downloading-image-from-url-on-swift
extension UIImageView {
    func downloaded(from url: URL, contentMode mode: ContentMode = .scaleAspectFit) {
        contentMode = mode
        URLSession.shared.dataTask(with: url) { data, response, error in
            guard
                let httpURLResponse = response as? HTTPURLResponse, httpURLResponse.statusCode == 200,
                let mimeType = response?.mimeType, mimeType.hasPrefix("image"),
                let data = data, error == nil,
                let image = UIImage(data: data)
                else { return }
            DispatchQueue.main.async() { [weak self] in
                self?.image = image
            }
        }.resume()
    }
    func downloaded(from link: String, contentMode mode: ContentMode = .scaleAspectFit) {
        guard let url = URL(string: link) else { return }
        downloaded(from: url, contentMode: mode)
    }
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
    var topSellers: [Item] = []
    var newReleases: [Item] = []
    var comingSoon: [Item] = []
    var buttonClick: String?
    
    override func viewDidLoad() {
        tableView.delegate = self
        tableView.dataSource = self
        super.viewDidLoad()
        tableView.register(SpecialCell.self, forCellReuseIdentifier: "SpecialCell")
        
        Task {
            do {
                let Welcome = try await networking.fetchGames()
                await MainActor.run {
                    title = buttonClick
                    specials = Welcome.specials.items
                    topSellers = Welcome.topSellers.items
                    newReleases = Welcome.newReleases.items
                    comingSoon = Welcome.comingSoon.items

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

        switch buttonClick{
        case "Specials":
                cell.textLabel?.text = specials[indexPath.row].name
        case "TopSellers":
                cell.textLabel?.text = topSellers[indexPath.row].name
        case "NewReleases":
                cell.textLabel?.text = newReleases[indexPath.row].name
        case "ComingSoon":
                cell.textLabel?.text = comingSoon[indexPath.row].name
        default:
            print("ERROR")
        }
        //cell.Discount.text = "test"
        //OGPrice.text = String(specials[indexPath.row].finalPrice)
        // image of game
        // original price of game
        // discounted price of game
        return cell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch buttonClick{
        case "Specials":
            return specials.count
        case "TopSellers":
            return topSellers.count
        case "NewReleases":
            return newReleases.count
        case "ComingSoon":
            return comingSoon.count
        default:
            print("ERROR")
        }
        return 0
    }
    
    //segue to description of game
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "ToDescriptionSegue", sender: indexPath)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let GameDescriptionViewController = segue.destination as? GameDescriptionViewController else {
            return
        }
        guard let indexPath = sender as? IndexPath else {
            return
        }
        
        switch buttonClick{
        case "Specials":
            GameDescriptionViewController.game = specials[indexPath.row]
        case "TopSellers":
            GameDescriptionViewController.game = topSellers[indexPath.row]
        case "NewReleases":
            GameDescriptionViewController.game = newReleases[indexPath.row]
        case "ComingSoon":
            GameDescriptionViewController.game = comingSoon[indexPath.row]
        default:
            print("ERROR")
        }


    }
    
}
