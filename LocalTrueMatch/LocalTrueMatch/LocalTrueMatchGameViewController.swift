import UIKit
import SnapKit

class LocalTrueMatchGameViewController: UIViewController {
    
    private var LocalTrueMatchBackgroundImageView: UIImageView!
    private var LocalTrueMatchOtherBackImageView: UIImageView!
    private var LocalTrueMatchClickCounterBackImageView: UIImageView!
    private var LocalTrueMatchHomeButton: UIButton!
    private var LocalTrueMatchScoreBackImageView: UIImageView!
    private var LocalTrueMatchScoreLabel: UILabel!
    private var LocalTrueMatchClickCounterLabel: UILabel!
    private var LocalTrueMatchButtonGrid: [[UIButton]] = []
    
    private var LocalTrueMatchClickLimit = 5
    private var LocalTrueMatchClickCount = 0 {
        didSet {
            updateLocalTrueMatchClickCounterLabel()
        }
    }
    private var LocalTrueMatchLocalScore = 0
    private var LocalTrueMatchCellState: [[String]] = []

    private var LocalTrueMatchScore: Int {
        get { UserDefaults.standard.integer(forKey: "LocalTrueMatchScore") }
        set {
            UserDefaults.standard.set(newValue, forKey: "LocalTrueMatchScore")
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        generateLocalTrueMatchCellStates()
        setupLocalTrueMatchUI()
        setupLocalTrueMatchConstraints()
        updateLocalTrueMatchScoreLabel()
        updateLocalTrueMatchClickCounterLabel()
    }
    
    private func generateLocalTrueMatchCellStates() {
        var cellPool: Array<Any>
        if UserDefaults.standard.object(forKey: "LocalTrueMatchPurchasedItem") != nil {
            cellPool = Array(repeating: "LocalTrueMatchCellGold", count: 15) +
            Array(repeating: "LocalTrueMatchBlueCell", count: 10)
        } else {
            cellPool = Array(repeating: "LocalTrueMatchCellWhite", count: 15) +
            Array(repeating: "LocalTrueMatchBlueCell", count: 10)
        }
        
        cellPool.shuffle()
        
        for _ in 0..<5 {
            var row: [String] = []
            for _ in 0..<5 {
                row.append(cellPool.removeFirst() as! String)
            }
            LocalTrueMatchCellState.append(row)
        }
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
        
        LocalTrueMatchClickCounterBackImageView = UIImageView(image: UIImage(named: "LocalTrueMatchOtherBack"))
        LocalTrueMatchClickCounterBackImageView.contentMode = .scaleToFill
        view.addSubview(LocalTrueMatchClickCounterBackImageView)
        
        LocalTrueMatchClickCounterLabel = UILabel()
        LocalTrueMatchClickCounterLabel.font = UIFont(name: "Alagard-12px-unicode", size: 16)
        LocalTrueMatchClickCounterLabel.textColor = .white
        LocalTrueMatchClickCounterLabel.textAlignment = .center
        LocalTrueMatchClickCounterBackImageView.addSubview(LocalTrueMatchClickCounterLabel)
        
        LocalTrueMatchHomeButton = UIButton(type: .custom)
        LocalTrueMatchHomeButton.setImage(UIImage(named: "LocalTrueMatchHome"), for: .normal)
        LocalTrueMatchHomeButton.addTarget(self, action: #selector(handleLocalTrueMatchHomeTapped), for: .touchUpInside)
        LocalTrueMatchAddSound(to: LocalTrueMatchHomeButton)
        view.addSubview(LocalTrueMatchHomeButton)
        
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
        
        for i in 0..<5 {
            var buttonRow: [UIButton] = []
            for j in 0..<5 {
                let button = UIButton(type: .custom)
                button.setImage(UIImage(named: "LocalTrueMatchGreenCell"), for: .normal)
                button.tag = i * 5 + j
                button.addTarget(self, action: #selector(handleLocalTrueMatchCellTapped(_:)), for: .touchUpInside)
                LocalTrueMatchAddSound(to: button)
                LocalTrueMatchOtherBackImageView.addSubview(button)
                buttonRow.append(button)
            }
            LocalTrueMatchButtonGrid.append(buttonRow)
        }
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
            make.centerX.equalToSuperview()
            make.centerY.equalToSuperview()
            make.width.equalTo(300)
            make.height.equalTo(300)
        }
        
        LocalTrueMatchClickCounterBackImageView.snp.makeConstraints { make in
            make.top.equalTo(LocalTrueMatchOtherBackImageView.snp.bottom).offset(20)
            make.centerX.equalToSuperview()
            make.width.equalTo(200)
            make.height.equalTo(50)
        }
        
        LocalTrueMatchClickCounterLabel.snp.makeConstraints { make in
            make.center.equalToSuperview()
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
        
        let gridSize = 5
        let buttonSize = 50
        let spacing = (300 - (gridSize * buttonSize)) / (gridSize + 1)
        
        for (i, row) in LocalTrueMatchButtonGrid.enumerated() {
            for (j, button) in row.enumerated() {
                button.snp.makeConstraints { make in
                    make.width.height.equalTo(buttonSize)
                    make.top.equalTo(LocalTrueMatchOtherBackImageView).offset(spacing + i * (buttonSize + spacing))
                    make.leading.equalTo(LocalTrueMatchOtherBackImageView).offset(spacing + j * (buttonSize + spacing))
                }
            }
        }
    }
    
    private func updateLocalTrueMatchScoreLabel() {
        LocalTrueMatchScoreLabel.text = "\(LocalTrueMatchScore)"
    }
    
    private func updateLocalTrueMatchClickCounterLabel() {
        LocalTrueMatchClickCounterLabel.text = "Clicks: \(LocalTrueMatchClickLimit)"
    }
    
    @objc private func handleLocalTrueMatchHomeTapped() {
        let LocalTrueMatchHomeViewController = LocalTrueMatchHomeViewController()
        self.navigationController?.setViewControllers([LocalTrueMatchHomeViewController], animated: false)
    }
    
    @objc private func handleLocalTrueMatchCellTapped(_ sender: UIButton) {
        guard LocalTrueMatchClickCount < LocalTrueMatchClickLimit else { return }
        let row = sender.tag / 5
        let col = sender.tag % 5
        let cellState = LocalTrueMatchCellState[row][col]
        sender.setImage(UIImage(named: cellState), for: .disabled)
        sender.isEnabled = false
        if cellState == "LocalTrueMatchCellWhite" || cellState == "LocalTrueMatchCellGold"{
            LocalTrueMatchClickLimit += 1
            LocalTrueMatchLocalScore += 50
        }
        LocalTrueMatchClickLimit -= 1
        updateLocalTrueMatchClickCounterLabel()
        if LocalTrueMatchClickLimit <= 0 {
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                let LocalTrueMatchHomeViewController = LocalTrueMatchEndViewController()
                LocalTrueMatchHomeViewController.LocalTrueMatchLocalScore = self.LocalTrueMatchLocalScore
                self.navigationController?.setViewControllers([LocalTrueMatchHomeViewController], animated: false)
            }
        }
    }
}
