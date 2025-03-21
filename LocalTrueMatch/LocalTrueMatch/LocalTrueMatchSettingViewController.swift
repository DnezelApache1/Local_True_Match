import UIKit
import SnapKit

class LocalTrueMatchSettingViewController: UIViewController {
    
    private var LocalTrueMatchBackgroundImageView: UIImageView!
    private var LocalTrueMatchHomeButton: UIButton!
    private var LocalTrueMatchSettingsLabel: UILabel!
    private var LocalTrueMatchSoundButton: UIButton!
    private var LocalTrueMatchVibroButton: UIButton!
    
    private var isLocalTrueMatchSoundOn: Bool {
        get { UserDefaults.standard.bool(forKey: "LocalTrueMatchSound") }
        set { UserDefaults.standard.set(newValue, forKey: "LocalTrueMatchSound") }
    }
    
    private var isLocalTrueMatchVibroOn: Bool {
        get { UserDefaults.standard.bool(forKey: "LocalTrueMatchVibro") }
        set { UserDefaults.standard.set(newValue, forKey: "LocalTrueMatchVibro") }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupLocalTrueMatchUI()
        setupLocalTrueMatchConstraints()
        updateLocalTrueMatchButtonsState()
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
        LocalTrueMatchSettingsLabel = UILabel()
        LocalTrueMatchSettingsLabel.text = "Settings"
        LocalTrueMatchSettingsLabel.font = UIFont(name: "Alagard-12px-unicode", size: 24)
        LocalTrueMatchSettingsLabel.textColor = .white
        LocalTrueMatchSettingsLabel.textAlignment = .center
        view.addSubview(LocalTrueMatchSettingsLabel)
        LocalTrueMatchSoundButton = UIButton(type: .custom)
        LocalTrueMatchSoundButton.addTarget(self, action: #selector(handleLocalTrueMatchSoundTapped), for: .touchUpInside)
        view.addSubview(LocalTrueMatchSoundButton)
        LocalTrueMatchVibroButton = UIButton(type: .custom)
        LocalTrueMatchVibroButton.addTarget(self, action: #selector(handleLocalTrueMatchVibroTapped), for: .touchUpInside)
        view.addSubview(LocalTrueMatchVibroButton)
        LocalTrueMatchAddSound(to: LocalTrueMatchHomeButton)
        LocalTrueMatchAddSound(to: LocalTrueMatchSoundButton)
        LocalTrueMatchAddSound(to: LocalTrueMatchVibroButton)
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
        LocalTrueMatchSettingsLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(50)
            make.centerX.equalToSuperview()
        }
        LocalTrueMatchSoundButton.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.centerX.equalToSuperview().offset(-100)
            make.height.equalTo(50)
            make.width.equalTo(150)
        }
        LocalTrueMatchVibroButton.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.centerX.equalToSuperview().offset(100)
            make.height.equalTo(50)
            make.width.equalTo(150)
        }
    }
    
    private func updateLocalTrueMatchButtonsState() {
        let soundImageName = isLocalTrueMatchSoundOn ? "LocalTrueMatchSound" : "LocalTrueMatchSoundOff"
        LocalTrueMatchSoundButton.setImage(UIImage(named: soundImageName), for: .normal)
        let vibroImageName = isLocalTrueMatchVibroOn ? "LocalTrueMatchVibro" : "LocalTrueMatchVibroOff"
        LocalTrueMatchVibroButton.setImage(UIImage(named: vibroImageName), for: .normal)
    }
    
    @objc private func handleLocalTrueMatchHomeTapped() {
        let LocalTrueMatchHomeViewController = LocalTrueMatchHomeViewController()
        self.navigationController?.setViewControllers([LocalTrueMatchHomeViewController], animated: false)
    }
    
    @objc private func handleLocalTrueMatchSoundTapped() {
        isLocalTrueMatchSoundOn.toggle()
        updateLocalTrueMatchButtonsState()
    }
    
    @objc private func handleLocalTrueMatchVibroTapped() {
        isLocalTrueMatchVibroOn.toggle()
        updateLocalTrueMatchButtonsState()
    }
}
