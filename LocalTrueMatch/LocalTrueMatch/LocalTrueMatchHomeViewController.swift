import UIKit
import SnapKit

class LocalTrueMatchHomeViewController: UIViewController {
    
    private var LocalTrueMatchBackgroundImageView: UIImageView!
    private var LocalTrueMatchScoreBackImageView: UIImageView!
    private var LocalTrueMatchScoreLabel: UILabel!
    private var LocalTrueMatchWhiteBallImageView: UIImageView!
    private var LocalTrueMatchPlayButton: UIButton!
    private var LocalTrueMatchSettingButton: UIButton!
    private var LocalTrueMatchShopButton: UIButton!
    
    private var LocalTrueMatchScore: Int {
        get { UserDefaults.standard.integer(forKey: "LocalTrueMatchScore") }
        set {
            UserDefaults.standard.set(newValue, forKey: "LocalTrueMatchScore")
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.navigationBar.isHidden = true
        self.navigationItem.hidesBackButton = true
        setupLocalTrueMatchUI()
        setupLocalTrueMatchConstraints()
        updateLocalTrueMatchScoreLabel()
        LocalTrueMatchPlayButton.addTarget(self, action: #selector(handleLocalTrueMatchPlayTapped), for: .touchUpInside)
        LocalTrueMatchSettingButton.addTarget(self, action: #selector(handleLocalTrueMatchSettingTapped), for: .touchUpInside)
        LocalTrueMatchShopButton.addTarget(self, action: #selector(handleLocalTrueMatchShopTapped), for: .touchUpInside)
        LocalTrueMatchAddSound(to: LocalTrueMatchPlayButton)
        LocalTrueMatchAddSound(to: LocalTrueMatchSettingButton)
        LocalTrueMatchAddSound(to: LocalTrueMatchShopButton)
    }
    
    private func setupLocalTrueMatchUI() {
        view.backgroundColor = .white
        
        LocalTrueMatchBackgroundImageView = UIImageView(image: UIImage(named: "LocalTrueMatchGameBack"))
        LocalTrueMatchBackgroundImageView.contentMode = .scaleAspectFill
        view.addSubview(LocalTrueMatchBackgroundImageView)
        
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
        
        LocalTrueMatchWhiteBallImageView = UIImageView(image: UIImage(named: "LocalTrueMatchWhiteBall"))
        LocalTrueMatchWhiteBallImageView.contentMode = .scaleAspectFit
        view.addSubview(LocalTrueMatchWhiteBallImageView)
        
        LocalTrueMatchPlayButton = UIButton(type: .custom)
        LocalTrueMatchPlayButton.setImage(UIImage(named: "LocalTrueMatchPlay"), for: .normal)
        view.addSubview(LocalTrueMatchPlayButton)
        
        LocalTrueMatchSettingButton = UIButton(type: .custom)
        LocalTrueMatchSettingButton.setImage(UIImage(named: "LocalTrueMatchSetting"), for: .normal)
        view.addSubview(LocalTrueMatchSettingButton)
        
        LocalTrueMatchShopButton = UIButton(type: .custom)
        LocalTrueMatchShopButton.setImage(UIImage(named: "LocalTrueMatchShop"), for: .normal)
        view.addSubview(LocalTrueMatchShopButton)
    }
    
    private func setupLocalTrueMatchConstraints() {
        LocalTrueMatchBackgroundImageView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
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
        
        LocalTrueMatchWhiteBallImageView.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.centerY.equalToSuperview().offset(50)
            make.width.height.equalTo(150)
        }
        
        LocalTrueMatchPlayButton.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(LocalTrueMatchWhiteBallImageView.snp.bottom).offset(20)
            make.width.equalTo(150)
            make.height.equalTo(50)
        }
        
        LocalTrueMatchSettingButton.snp.makeConstraints { make in
            make.centerX.equalToSuperview().offset(-50)
            make.top.equalTo(LocalTrueMatchPlayButton.snp.bottom).offset(20)
            make.width.height.equalTo(50)
        }
        
        LocalTrueMatchShopButton.snp.makeConstraints { make in
            make.centerX.equalToSuperview().offset(50)
            make.top.equalTo(LocalTrueMatchPlayButton.snp.bottom).offset(20)
            make.width.height.equalTo(50)
        }
    }
    
    @objc private func handleLocalTrueMatchPlayTapped() {
        let LocalTrueMatchHomeViewController = LocalTrueMatchGameViewController()
        self.navigationController?.setViewControllers([LocalTrueMatchHomeViewController], animated: false)
    }
    
    @objc private func handleLocalTrueMatchSettingTapped() {
        let LocalTrueMatchHomeViewController = LocalTrueMatchSettingViewController()
        self.navigationController?.setViewControllers([LocalTrueMatchHomeViewController], animated: false)
    }
    
    @objc private func handleLocalTrueMatchShopTapped() {
        let LocalTrueMatchHomeViewController = LocalTrueMatchShopViewController()
        self.navigationController?.setViewControllers([LocalTrueMatchHomeViewController], animated: false)
    }
    
    private func updateLocalTrueMatchScoreLabel() {
        LocalTrueMatchScoreLabel.text = "\(LocalTrueMatchScore)"
    }
}
