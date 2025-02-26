
import UIKit

class AboutViewController: UIViewController {
    
    @IBOutlet weak var imageVIEW: UIImageView!
    @IBOutlet weak var titleLbl: UILabel!
    @IBOutlet weak var summaryLbl: UILabel!
    
    var image_url: String?
    var image_title: String?
    var summary: String?

    override func viewDidLoad() {
        super.viewDidLoad()
        self.setUpView()
    }
    
    func setUpView() {
        self.imageVIEW.layer.cornerRadius = self.imageVIEW.frame.height / 2
        self.imageVIEW.layer.borderWidth = 1
        self.imageVIEW.layer.borderColor = UIColor.black.cgColor
        self.imageVIEW.layer.cornerRadius = self.imageVIEW.frame.height / 2
        self.imageVIEW.sd_setImage(with: URL(string: image_url ?? ""), placeholderImage: defaultImage)
        self.titleLbl.text = self.image_title
        self.summaryLbl.text = summary
    }
    
    @IBAction func didBackBtnTap(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
}
