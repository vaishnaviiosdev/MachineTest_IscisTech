
import UIKit
import SDWebImage
import HeartButton

class HomePage: UIViewController, UITextFieldDelegate {
    
    @IBOutlet weak var searchView: UIView!
    @IBOutlet weak var searchTextfield: UITextField!
    @IBOutlet weak var NewsListTableView: UITableView!
    
    var allData: [Results] = []
    var filteredData: [Results] = []
   
    override func viewDidLoad() {
        super.viewDidLoad()
        self.searchTextfield.delegate = self
        setView(iview: self.searchView, customColor: UIColor.black, borderWidth: 2)
        self.fetchArticles()
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        self.view.addGestureRecognizer(tapGesture)
    }
    
    @objc func dismissKeyboard() {
        self.view.endEditing(true)
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
            
        let currentText = textField.text ?? ""
        let updatedText = (currentText as NSString).replacingCharacters(in: range, with: string)
        self.filterItems(with: updatedText)
        return true
    }
    
    func filterItems(with searchText: String) {
        if searchText.isEmpty {
           filteredData = allData
        }
        else {
            // Filter the data based on author names
           filteredData = allData.filter { article in
                article.authors.contains { author in
                    author.name.lowercased().contains(searchText.lowercased())
                }
            }
        }
        print("The filtered data is \(filteredData.count)")
        self.NewsListTableView.reloadData()
    }
    
    func textFieldShouldClear(_ textField: UITextField) -> Bool {
        filteredData = allData // Show all items
        self.NewsListTableView.reloadData()
        return true
    }
    
    func fetchArticles() {
        showActivityIndicator(in: self.view) // Show the indicator
        guard let url = URL(string: API_Url) else {
            print("Invalid URL")
            return
        }

        let task = URLSession.shared.dataTask(with: url) { data, response, error in
            
            if let error = error {
                print("Error fetching data: \(error)")
                DispatchQueue.main.async {
                    self.hideActivityIndicator()
                }
                return
            }

            guard let data = data else {
                print("No data received")
                DispatchQueue.main.async {
                    self.hideActivityIndicator()
                }
                return
            }
            do {
                let decoder = JSONDecoder()
                let decodedData = try decoder.decode(AllData.self, from: data)
                let articles = decodedData.results
        
                DispatchQueue.main.async {
                    self.allData = articles
                    self.NewsListTableView.reloadData()
                    self.hideActivityIndicator()
                }
            }
            catch {
                print("Error decoding data: \(error)")
                DispatchQueue.main.async {
                    self.hideActivityIndicator()
                }
            }
        }
        task.resume()
    }
}

extension HomePage: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        if filteredData.isEmpty {
            return allData.count
        }
        else {
            return filteredData.count
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "NewListTableViewCell", for: indexPath) as! NewListTableViewCell
        let article = filteredData.isEmpty ? allData[indexPath.row] : filteredData[indexPath.row]
                
        cell.authorNameLbl.text = "Author name: \(article.authors[0].name)"
        cell.titleLbl.text = "Title: \(article.title)"
        cell.imageVIEW.sd_setImage(with: URL(string: article.image_url), placeholderImage: defaultImage)
        cell.readMoreBtn.tag = indexPath.row
        cell.readMoreBtn.addTarget(self, action: #selector(readMoreTapped(sender:)), for: .touchUpInside)
        cell.favouriteBtn.tag = indexPath.row
        cell.favouriteBtn.addTarget(self, action: #selector(self.didTapFavorite(_:)), for: .touchUpInside)
        return cell
    }
    
    @objc func readMoreTapped(sender: UIButton) {
        let index = sender.tag
        let iData = self.allData[index]
        print("The iData value is \(iData)")
        let vc = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "AboutViewController") as? AboutViewController
        vc?.image_url = iData.image_url
        vc?.image_title = iData.title
        vc?.summary = iData.summary
        self.navigationController?.pushViewController(vc!, animated: false)
    }
    
    @objc func didTapFavorite(_ sender: UIButton) {
        let indexpath = IndexPath(row: sender.tag, section: 0)
        let cell = self.NewsListTableView.cellForRow(at: indexpath) as! NewListTableViewCell
        
        if cell.heartButton.isOn {
            showAlertView(title: projectName, message: "Removed from favourites")
        }
        else {
            showAlertView(title: projectName, message: "Added to favourites")
        }
        cell.heartButton.setOn(!(cell.heartButton.isOn), animated: true)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
}

class NewListTableViewCell: UITableViewCell {
    @IBOutlet weak var imageVIEW: UIImageView!
    @IBOutlet weak var authorNameLbl: UILabel!
    @IBOutlet weak var titleLbl: UILabel!
    @IBOutlet weak var readMoreBtn: UIButton!
    @IBOutlet weak var heartButton: HeartButton!
    @IBOutlet weak var favouriteBtn: UIButton!
}


