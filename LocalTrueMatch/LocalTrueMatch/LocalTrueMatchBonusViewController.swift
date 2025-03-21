import UIKit
import SnapKit

class LocalTrueMatchBonusViewController: UIViewController {
    
    private var LocalTrueMatchBackgroundImageView: UIImageView!
    private var LocalTrueMatchWelcomeLabel: UILabel!
    private var LocalTrueMatchResultLabel: UILabel!
    private var LocalTrueMatchTapToOpenLabel: UILabel!
    private var LocalTrueMatchButton1: UIButton!
    private var LocalTrueMatchButton2: UIButton!
    private var LocalTrueMatchButton3: UIButton!
    private var LocalTrueMatchButtons: [UIButton] = []
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
    }
    
    private func setupLocalTrueMatchUI() {
        view.backgroundColor = .white
        
        LocalTrueMatchBackgroundImageView = UIImageView(image: UIImage(named: "LocalTrueMatchGameBack"))
        LocalTrueMatchBackgroundImageView.contentMode = .scaleAspectFill
        view.addSubview(LocalTrueMatchBackgroundImageView)
        
        LocalTrueMatchWelcomeLabel = UILabel()
        LocalTrueMatchWelcomeLabel.text = "Welcome"
        LocalTrueMatchWelcomeLabel.font = UIFont(name: "Alagard-12px-unicode", size: 24)
        LocalTrueMatchWelcomeLabel.textAlignment = .center
        LocalTrueMatchWelcomeLabel.textColor = .white
        view.addSubview(LocalTrueMatchWelcomeLabel)
        
        LocalTrueMatchResultLabel = UILabel()
        LocalTrueMatchResultLabel.text = ""
        LocalTrueMatchResultLabel.font = UIFont(name: "Alagard-12px-unicode", size: 18)
        LocalTrueMatchResultLabel.textAlignment = .center
        LocalTrueMatchResultLabel.textColor = .white
        view.addSubview(LocalTrueMatchResultLabel)
        
        LocalTrueMatchTapToOpenLabel = UILabel()
        LocalTrueMatchTapToOpenLabel.text = "Tap to open"
        LocalTrueMatchTapToOpenLabel.font = UIFont(name: "Alagard-12px-unicode", size: 14)
        LocalTrueMatchTapToOpenLabel.textAlignment = .center
        LocalTrueMatchTapToOpenLabel.textColor = .white
        view.addSubview(LocalTrueMatchTapToOpenLabel)
        
        LocalTrueMatchButton1 = createLocalTrueMatchButton()
        LocalTrueMatchButton2 = createLocalTrueMatchButton()
        LocalTrueMatchButton3 = createLocalTrueMatchButton()
        
        LocalTrueMatchButtons = [LocalTrueMatchButton1, LocalTrueMatchButton2, LocalTrueMatchButton3]
        
        view.addSubview(LocalTrueMatchButton1)
        view.addSubview(LocalTrueMatchButton2)
        view.addSubview(LocalTrueMatchButton3)
    }
    
    private func setupLocalTrueMatchConstraints() {
        LocalTrueMatchBackgroundImageView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        LocalTrueMatchWelcomeLabel.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalToSuperview().offset(50)
        }
        
        LocalTrueMatchResultLabel.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(LocalTrueMatchWelcomeLabel.snp.bottom).offset(20)
        }
        
        LocalTrueMatchButton1.snp.makeConstraints { make in
            make.width.height.equalTo(80)
            make.centerX.equalToSuperview().offset(-100)
            make.centerY.equalToSuperview()
        }
        
        LocalTrueMatchButton2.snp.makeConstraints { make in
            make.width.height.equalTo(80)
            make.centerX.equalToSuperview()
            make.centerY.equalToSuperview()
        }
        
        LocalTrueMatchButton3.snp.makeConstraints { make in
            make.width.height.equalTo(80)
            make.centerX.equalToSuperview().offset(100)
            make.centerY.equalToSuperview()
        }
        
        LocalTrueMatchTapToOpenLabel.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.bottom.equalToSuperview().offset(-50)
        }
    }
    
    private func createLocalTrueMatchButton() -> UIButton {
        let button = UIButton(type: .custom)
        button.setImage(UIImage(named: "LocalTrueMatchGoldBall"), for: .normal)
        button.addTarget(self, action: #selector(LocalTrueMatchButtonTapped(_:)), for: .touchUpInside)
        LocalTrueMatchAddSound(to: button)
        return button
    }
    
    @objc private func LocalTrueMatchButtonTapped(_ sender: UIButton) {
        let randomNumber = [200, 300, 500].randomElement()!
        LocalTrueMatchScore += randomNumber
        LocalTrueMatchResultLabel.text = "You got \(randomNumber)!"
        
        LocalTrueMatchButtons.forEach { $0.isEnabled = false }
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
            let LocalTrueMatchHomeViewController = LocalTrueMatchHomeViewController()
            self.navigationController?.setViewControllers([LocalTrueMatchHomeViewController], animated: false)
        }
    }
}
