enum Robot {
    case goLeft(inputArray: Array<Int>, index: Int)
    case goRight(inputArray: Array<Int>, index: Int)
    
    func go () -> Int {
        switch self {
        case .goLeft(let inputArray, let index):
            guard index >= 0 && index < inputArray.count else {
                return -1;
            }
            
            guard inputArray.count != 1 else {
                return 0;
            }
            
            var startValue = inputArray[index]
            
            for i in stride(from: index - 1, to: 0, by: -1) {
                if (inputArray[i] >= startValue) {
                    return i
                }
                else {
                    startValue = inputArray[i]
                }
            }
            
            return -1
            
            
        case .goRight(let inputArray, let index):
            guard index >= 0 && index < inputArray.count else {
                return -1
            }
            
            guard inputArray.count != 1 else {
                return 0;
            }
            
            var startValue = inputArray[index]
            
            for i in index + 1 ..< inputArray.count {
                if (inputArray[i] >= startValue) {
                    return i
                }
                else {
                    startValue = inputArray[i]
                }
            }
            
            return -1
        }
    }
}


var testArray = [1, 2, 3, 4, 6, 8, 1, 4]
var myRobot = Robot.goRight(inputArray: testArray, index: 1)

var ram: Array<Int> = []

while testArray.count > 0 {
    switch myRobot {
    case .goLeft( _, _):
        var index = myRobot.go()
        
        if (index != -1) {
            ram.append(testArray.remove(at: index))
        }
        else {
            index = 0
        }
        
        myRobot = Robot.goRight(inputArray: testArray, index: index)
    case .goRight(_, _):
        var index = myRobot.go()
        
        if (index != -1) {
            ram.append(testArray.remove(at: index))
        }
        else {
            index = testArray.count - 1
        }
        
        myRobot = Robot.goLeft(inputArray: testArray, index: index)
    }
}



print(ram)
