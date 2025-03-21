import UIKit
import SnapKit

class LocalTrueMatchShopViewController: UIViewController {
    
    private var LocalTrueMatchBackgroundImageView: UIImageView!
    private var LocalTrueMatchHomeButton: UIButton!
    private var LocalTrueMatchGoldBallImageView: UIImageView!
    private var LocalTrueMatchBuyButton: UIButton!
    private var LocalTrueMatchScoreBackImageView: UIImageView!
    private var LocalTrueMatchScoreLabel: UILabel!
    
    private var LocalTrueMatchScore: Int {
        get { UserDefaults.standard.integer(forKey: "LocalTrueMatchScore") }
        set {
            UserDefaults.standard.set(newValue, forKey: "LocalTrueMatchScore")
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupLocalTrueMatchUI()
        setupLocalTrueMatchConstraints()
        updateLocalTrueMatchScoreLabel()
    }
    
    private func setupLocalTrueMatchUI() {
        view.backgroundColor = .white
        
        LocalTrueMatchBackgroundImageView = UIImageView(image: UIImage(named: "LocalTrueMatchGameBack"))
        LocalTrueMatchBackgroundImageView.contentMode = .scaleAspectFill
        view.addSubview(LocalTrueMatchBackgroundImageView)
        
        LocalTrueMatchHomeButton = UIButton(type: .custom)
        LocalTrueMatchHomeButton.setImage(UIImage(named: "LocalTrueMatchHome"), for: .normal)
        LocalTrueMatchHomeButton.addTarget(self, action: #selector(handleLocalTrueMatchHomeTapped), for: .touchUpInside)
        view.addSubview(LocalTrueMatchHomeButton)
        
        LocalTrueMatchGoldBallImageView = UIImageView(image: UIImage(named: "LocalTrueMatchGoldBall"))
        LocalTrueMatchGoldBallImageView.contentMode = .scaleAspectFit
        view.addSubview(LocalTrueMatchGoldBallImageView)
        
        LocalTrueMatchBuyButton = UIButton(type: .custom)
        LocalTrueMatchBuyButton.setImage(UIImage(named: "LocalTrueMatchBuy"), for: .normal)
        LocalTrueMatchBuyButton.addTarget(self, action: #selector(handleLocalTrueMatchBuyTapped), for: .touchUpInside)
        view.addSubview(LocalTrueMatchBuyButton)
        LocalTrueMatchAddSound(to: LocalTrueMatchHomeButton)
        LocalTrueMatchAddSound(to: LocalTrueMatchBuyButton)
        
        LocalTrueMatchScoreBackImageView = UIImageView(image: UIImage(named: "LocalTrueMatchScoreBack"))
        LocalTrueMatchScoreBackImageView.contentMode = .scaleToFill
        view.addSubview(LocalTrueMatchScoreBackImageView)
        
        LocalTrueMatchScoreLabel = UILabel()
        LocalTrueMatchScoreLabel.font = UIFont(name: "Alagard-12px-unicode", size: 16)
        LocalTrueMatchScoreLabel.textColor = .white
        LocalTrueMatchScoreLabel.adjustsFontSizeToFitWidth = true
        LocalTrueMatchScoreLabel.minimumScaleFactor = 0.5
        LocalTrueMatchScoreLabel.textAlignment = .center
        LocalTrueMatchScoreBackImageView.addSubview(LocalTrueMatchScoreLabel)
    }
    
    private func setupLocalTrueMatchConstraints() {
        LocalTrueMatchBackgroundImageView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        LocalTrueMatchHomeButton.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(50)
            make.leading.equalToSuperview().offset(20)
            make.width.height.equalTo(40)
        }
        
        LocalTrueMatchGoldBallImageView.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.centerY.equalToSuperview().offset(-50)
            make.width.height.equalTo(100)
        }
        
        LocalTrueMatchBuyButton.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(LocalTrueMatchGoldBallImageView.snp.bottom).offset(20)
            make.width.equalTo(150)
            make.height.equalTo(50)
        }
        
        LocalTrueMatchScoreBackImageView.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(50)
            make.trailing.equalToSuperview().offset(-20)
            make.width.equalTo(100)
            make.height.equalTo(40)
        }
        
        LocalTrueMatchScoreLabel.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.left.equalToSuperview().offset(10)
            make.right.equalToSuperview().inset(20)
        }
    }
    
    private func updateLocalTrueMatchScoreLabel() {
        LocalTrueMatchScoreLabel.text = "\(LocalTrueMatchScore)"
    }
    
    @objc private func handleLocalTrueMatchHomeTapped() {
        let LocalTrueMatchHomeViewController = LocalTrueMatchHomeViewController()
        self.navigationController?.setViewControllers([LocalTrueMatchHomeViewController], animated: false)
    }
    
    @objc private func handleLocalTrueMatchBuyTapped() {
        let cost = 2000
        if LocalTrueMatchScore >= cost && UserDefaults.standard.object(forKey: "LocalTrueMatchPurchasedItem") == nil {
            LocalTrueMatchScore -= cost
            UserDefaults.standard.set("LocalTrueMatchCellGold", forKey: "LocalTrueMatchPurchasedItem")
            updateLocalTrueMatchScoreLabel()
            showAlert(title: "Success", message: "You have successfully purchased LocalTrueMatchCellGold!")
        } else if UserDefaults.standard.string(forKey: "LocalTrueMatchPurchasedItem") != "LocalTrueMatchCellGold" {
            let difference = cost - LocalTrueMatchScore
            showAlert(title: "Insufficient Funds", message: "You need \(difference) more points to buy LocalTrueMatchCellGold.")
        } else {
            showAlert(title: "Shop", message: "You already have a purchase")
        }
    }
    
    private func showAlert(title: String, message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        present(alert, animated: true, completion: nil)
    }
}
