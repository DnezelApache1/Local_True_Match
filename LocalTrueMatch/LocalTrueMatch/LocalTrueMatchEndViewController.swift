import UIKit
import SnapKit

class LocalTrueMatchEndViewController: UIViewController {
    
    private var LocalTrueMatchBackgroundImageView: UIImageView!
    private var LocalTrueMatchOtherBackImageView: UIImageView!
    private var LocalTrueMatchEndGameLabel: UILabel!
    private var LocalTrueMatchScoreLabel: UILabel!
    private var LocalTrueMatchAgainButton: UIButton!
    private var LocalTrueMatchHomeButton: UIButton!
    
    private var LocalTrueMatchScore: Int {
        get { UserDefaults.standard.integer(forKey: "LocalTrueMatchScore") }
        set {
            UserDefaults.standard.set(newValue, forKey: "LocalTrueMatchScore")
        }
    }
    
    var LocalTrueMatchLocalScore = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        LocalTrueMatchPlaySound()
        LocalTrueMatchScore += LocalTrueMatchLocalScore
        setupLocalTrueMatchUI()
        setupLocalTrueMatchConstraints()
    }
    
    private func setupLocalTrueMatchUI() {
        view.backgroundColor = .white
        
        LocalTrueMatchBackgroundImageView = UIImageView(image: UIImage(named: "LocalTrueMatchGameBack"))
        LocalTrueMatchBackgroundImageView.contentMode = .scaleAspectFill
        view.addSubview(LocalTrueMatchBackgroundImageView)
        
        LocalTrueMatchOtherBackImageView = UIImageView(image: UIImage(named: "LocalTrueMatchOtherBack"))
        LocalTrueMatchOtherBackImageView.contentMode = .scaleToFill
        LocalTrueMatchOtherBackImageView.isUserInteractionEnabled = true
        view.addSubview(LocalTrueMatchOtherBackImageView)
        
        LocalTrueMatchEndGameLabel = UILabel()
        LocalTrueMatchEndGameLabel.text = "End Game"
        LocalTrueMatchEndGameLabel.font = UIFont(name: "Alagard-12px-unicode", size: 24)
        LocalTrueMatchEndGameLabel.textAlignment = .center
        LocalTrueMatchEndGameLabel.textColor = .white
        LocalTrueMatchOtherBackImageView.addSubview(LocalTrueMatchEndGameLabel)
        
        LocalTrueMatchScoreLabel = UILabel()
        LocalTrueMatchScoreLabel.text = "+\(LocalTrueMatchLocalScore)"
        LocalTrueMatchScoreLabel.font = UIFont(name: "Alagard-12px-unicode", size: 20)
        LocalTrueMatchScoreLabel.textAlignment = .center
        LocalTrueMatchScoreLabel.textColor = .white
        LocalTrueMatchOtherBackImageView.addSubview(LocalTrueMatchScoreLabel)
        
        LocalTrueMatchAgainButton = UIButton(type: .custom)
        LocalTrueMatchAgainButton.setImage(UIImage(named: "LocalTrueMatchAgain"), for: .normal)
        LocalTrueMatchAgainButton.addTarget(self, action: #selector(handleLocalTrueMatchAgainTapped), for: .touchUpInside)
        LocalTrueMatchAddSound(to: LocalTrueMatchAgainButton)
        LocalTrueMatchOtherBackImageView.addSubview(LocalTrueMatchAgainButton)
        
        LocalTrueMatchHomeButton = UIButton(type: .custom)
        LocalTrueMatchHomeButton.setImage(UIImage(named: "LocalTrueMatchHome"), for: .normal)
        LocalTrueMatchHomeButton.addTarget(self, action: #selector(handleLocalTrueMatchHomeTapped), for: .touchUpInside)
        LocalTrueMatchAddSound(to: LocalTrueMatchHomeButton)
        view.addSubview(LocalTrueMatchHomeButton)
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
        
        LocalTrueMatchOtherBackImageView.snp.makeConstraints { make in
            make.center.equalToSuperview()
            make.width.equalTo(300)
            make.height.equalTo(300)
        }
        
        LocalTrueMatchEndGameLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(20)
            make.centerX.equalToSuperview()
        }
        
        LocalTrueMatchScoreLabel.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.centerY.equalToSuperview()
        }
        
        LocalTrueMatchAgainButton.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.bottom.equalToSuperview().offset(-20)
            make.width.equalTo(150)
            make.height.equalTo(50)
        }
    }
    
    @objc private func handleLocalTrueMatchHomeTapped() {
        let LocalTrueMatchHomeViewController = LocalTrueMatchHomeViewController()
        self.navigationController?.setViewControllers([LocalTrueMatchHomeViewController], animated: false)
    }
    
    @objc private func handleLocalTrueMatchAgainTapped() {
        let LocalTrueMatchGameViewController = LocalTrueMatchGameViewController()
        self.navigationController?.setViewControllers([LocalTrueMatchGameViewController], animated: false)
    }
}
