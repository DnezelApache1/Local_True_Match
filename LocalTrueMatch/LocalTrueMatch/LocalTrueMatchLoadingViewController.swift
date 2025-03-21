import UIKit
import SnapKit

class LocalTrueMatchLoadingViewController: UIViewController {
    
    private var LocalTrueMatchBackgroundImageView: UIImageView!
    private var LocalTrueMatchLoadingLabel: UILabel!
    private var LocalTrueMatchWhiteBallImageView: UIImageView!
    
    private var LocalTrueMatchTimer: Timer?
    private var LocalTrueMatchIsWhiteBall: Bool = true
    private var LocalTrueMatchLoadingTextState: Int = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupLocalTrueMatchUI()
        setupLocalTrueMatchConstraints()
        startLocalTrueMatchAnimations()
        navigateToNextControllerAfterDelay()
    }
    
    private func setupLocalTrueMatchUI() {
        view.backgroundColor = .white
        LocalTrueMatchBackgroundImageView = UIImageView(image: UIImage(named: "LocalTrueMatchLoadingBack"))
        LocalTrueMatchBackgroundImageView.contentMode = .scaleAspectFill
        view.addSubview(LocalTrueMatchBackgroundImageView)
        LocalTrueMatchWhiteBallImageView = UIImageView(image: UIImage(named: "LocalTrueMatchWhiteBall"))
        LocalTrueMatchWhiteBallImageView.contentMode = .scaleAspectFit
        view.addSubview(LocalTrueMatchWhiteBallImageView)
        LocalTrueMatchLoadingLabel = UILabel()
        LocalTrueMatchLoadingLabel.text = "Loading."
        LocalTrueMatchLoadingLabel.font = UIFont(name: "Alagard-12px-unicode", size: 20)
        LocalTrueMatchLoadingLabel.textAlignment = .center
        LocalTrueMatchLoadingLabel.textColor = .white
        view.addSubview(LocalTrueMatchLoadingLabel)
    }
    
    private func setupLocalTrueMatchConstraints() {
        LocalTrueMatchBackgroundImageView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        LocalTrueMatchWhiteBallImageView.snp.makeConstraints { make in
            make.center.equalToSuperview()
            make.width.height.equalTo(100)
        }
        LocalTrueMatchLoadingLabel.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.bottom.equalToSuperview().offset(-50)
        }
    }
    
    private func startLocalTrueMatchAnimations() {
        LocalTrueMatchTimer = Timer.scheduledTimer(timeInterval: 0.5, target: self, selector: #selector(updateLocalTrueMatchAnimations), userInfo: nil, repeats: true)
    }
    
    private func navigateToNextControllerAfterDelay() {
         DispatchQueue.main.asyncAfter(deadline: .now() + 3.0) {
             let hasLaunchedBefore = UserDefaults.standard.bool(forKey: "LocalTrueMatchHasLaunched")
             let nextViewController: UIViewController
             
             if hasLaunchedBefore {
                 nextViewController = LocalTrueMatchHomeViewController()
             } else {
                 if UserDefaults.standard.object(forKey: "LocalTrueMatchSound") == nil {
                     UserDefaults.standard.set(true, forKey: "LocalTrueMatchSound")
                 }
                 if UserDefaults.standard.object(forKey: "LocalTrueMatchVibro") == nil {
                     UserDefaults.standard.set(true, forKey: "LocalTrueMatchVibro")
                 }
                 UserDefaults.standard.set(true, forKey: "LocalTrueMatchHasLaunched")
                 nextViewController = LocalTrueMatchBonusViewController()
             }
             
             self.navigationController?.setViewControllers([nextViewController], animated: false)
         }
     }
    
    @objc private func updateLocalTrueMatchAnimations() {
        LocalTrueMatchLoadingTextState = (LocalTrueMatchLoadingTextState + 1) % 3
        switch LocalTrueMatchLoadingTextState {
        case 0:
            LocalTrueMatchLoadingLabel.text = "Loading."
        case 1:
            LocalTrueMatchLoadingLabel.text = "Loading.."
        case 2:
            LocalTrueMatchLoadingLabel.text = "Loading..."
        default:
            break
        }
        if LocalTrueMatchIsWhiteBall {
            LocalTrueMatchWhiteBallImageView.image = UIImage(named: "LocalTrueMatchGoldBall")
        } else {
            LocalTrueMatchWhiteBallImageView.image = UIImage(named: "LocalTrueMatchWhiteBall")
        }
        LocalTrueMatchIsWhiteBall.toggle()
    }
    
    deinit {
        LocalTrueMatchTimer?.invalidate()
        LocalTrueMatchTimer = nil
    }
}
