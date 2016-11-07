//
//  GameViewController.swift
//  Hangman
//
//  Created by Shawn D'Souza on 3/3/16.
//  Copyright © 2016 Shawn D'Souza. All rights reserved.
//

import UIKit

class GameViewController: UIViewController {
    
    @IBOutlet weak var letterTextField: UITextField!
    @IBOutlet weak var incorrectGuessesLabel: UILabel!
    @IBOutlet weak var wordLabel: UILabel!
    @IBOutlet weak var hangmanPic: UIImageView!
    
    var phrase: String = "";
    var blanks: NSMutableArray = NSMutableArray();
    var incorrectGuesses: NSMutableArray = NSMutableArray();
    var correct: Bool = false;
    var counter: Int = 1;
    var imgName: String = "hangman1.gif"
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        let hangmanPhrases = HangmanPhrases()
        phrase = hangmanPhrases.getRandomPhrase()
        for i in 0...(phrase.characters.count-1){
            if(String(phrase[phrase.index(phrase.startIndex, offsetBy: i)]) == " "){
                blanks.add(" ")
            }
            else{
                blanks.add("_")
            }
        }
        wordLabel.text = blanks.componentsJoined(by: " ")
        print(phrase)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func GuessButton(_ sender: Any) {
        if(letterTextField != nil){
            let guess = letterTextField.text
            for i in 0...(phrase.characters.count-1){
                if(guess == String(phrase[phrase.index(phrase.startIndex, offsetBy: i)])){
                    blanks[i] = guess
                    correct = true
                    wordLabel.text = blanks.componentsJoined(by: " ")
                }
            }
            if(phrase == blanks.componentsJoined(by: "")){
                let alert = UIAlertController(title: "Game Over", message: "You WIN!", preferredStyle: UIAlertControllerStyle.alert)
                alert.addAction(UIAlertAction(title: "Start Over", style: UIAlertActionStyle.default, handler: nil))
                self.present(alert, animated: true, completion: nil)
                reset()
                return
            }
            if(correct == false){
                incorrectGuesses.add(guess)
                incorrectGuessesLabel.text = incorrectGuesses.componentsJoined(by: " ")
                counter += 1
                if(counter < 7){
                    imgName = "hangman" + String(counter) + ".gif"
                    hangmanPic.image = UIImage(named: imgName)
                }
                else{
                    let alert = UIAlertController(title: "Game Over", message: "You lose", preferredStyle: UIAlertControllerStyle.alert)
                    alert.addAction(UIAlertAction(title: "Start Over", style: UIAlertActionStyle.default, handler: nil))
                    self.present(alert, animated: true, completion: nil)
                    reset()
                    return
                    
                }
                
            }
            correct = false
        }
    }

   
    func reset(){
        phrase = "";
        blanks = NSMutableArray();
        incorrectGuesses = NSMutableArray();
        correct = false;
        counter = 1;
        imgName = "hangman1.gif"
        letterTextField.text = ""
        let hangmanPhrases = HangmanPhrases()
        phrase = hangmanPhrases.getRandomPhrase()
        for i in 0...(phrase.characters.count-1){
            if(String(phrase[phrase.index(phrase.startIndex, offsetBy: i)]) == " "){
                blanks.add(" ")
            
            }
            else{
                blanks.add("_")
            }
            
        }
        wordLabel.text = blanks.componentsJoined(by: " ")
        hangmanPic.image = UIImage(named: "hangman1.gif")
        incorrectGuessesLabel.text = ""
        
    }
    
    
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
