import UIKit

class SportSelectionViewController: UIViewController {
    
    
    @IBOutlet weak var footballSelected: UIButton!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
                
    }
    

    @IBAction func footballSelected(_ sender: UIButton) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        if let vc = storyboard.instantiateViewController(withIdentifier: "FootballSetupViewController") as? FootballSetupViewController {
            navigationController?.pushViewController(vc, animated: true)
        } else {
            print("FootballSetupViewController not found")
        }
    }

    @IBAction func futsalSelected(_ sender: UIButton) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        if let vc = storyboard.instantiateViewController(withIdentifier: "FutsalSetupViewController") as? FutsalSetupViewController {
            navigationController?.pushViewController(vc, animated: true)
        } else {
            print("FutsalSetupViewController not found")
        }
    }
}
