
import UIKit
import AVFoundation

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    var talker = AVSpeechSynthesizer()

    let numOfMax = 50

    var nums: [Int] = []

    var currentIndex = 0

    @IBOutlet weak var selectionNumLabel: UILabel!
    
    @IBOutlet weak var tableV: UITableView! {
        didSet {
            tableV.delegate = self
            tableV.dataSource = self
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        for i in 0...numOfMax {
            nums.append(i)
        }

        nums.shuffle()

        print(nums)
    }

    @IBAction func tappedBtn(_ sender: Any) {
        let selectionNum = nums[currentIndex]
        speak(text: String(selectionNum))
        selectionNumLabel.text = String(selectionNum)
        currentIndex = currentIndex + 1
        tableV.reloadData()

    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return currentIndex
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "MyCell")!
        cell.textLabel?.text = String(currentIndex - indexPath.row) + "番目： " + String(nums[currentIndex - indexPath.row - 1])
        return cell
    }

    func speak(text: String){

        var gobis = ["だよ", "です", "でした", "やんけ", "っす", "だわよ", "だってばよ", "だと思いました", "ですにーーの", "万1千", "億円ダウト"]
        gobis.shuffle()
        // 話す内容をセット
        let utterance = AVSpeechUtterance(string: text + gobis[0])
        // 言語を日本に設定
        utterance.voice = AVSpeechSynthesisVoice(language: "ja-JP")
        // 実行
        self.talker.speak(utterance)
    }

}

