enum Robot<T: Comparable> : Equatable {
    case goLeft(inputArray: Array<T>, index: Int)
    case goRight(inputArray: Array<T>, index: Int)
    case done
    
    func go () -> (Robot<T>, T?) {
        switch self {
        case .goLeft(var inputArray, let index):
            
            guard index >= 0 && index < inputArray.count else {
                return (.done, nil);
            }
            
            guard inputArray.count != 1 else {
                return (.done, inputArray[0]);
            }
            
            var startValue = inputArray[index]
            
            for i in stride(from: index - 1, to: 0, by: -1) {
                if (inputArray[i] >= startValue) {
                    let ramValue = inputArray.remove(at: i)
                    return (.goRight(inputArray: inputArray, index: i), ramValue)
                }
                else {
                    startValue = inputArray[i]
                }
            }
            
            return (.goRight(inputArray: inputArray, index: 0), nil)
            
            
        case .goRight(var inputArray, let index):
            guard index >= 0 && index < inputArray.count else {
                return (.done, nil);
            }
            
            guard inputArray.count != 1 else {
                return (.done, inputArray[0]);
            }
            
            var startValue = inputArray[index]
            
            for i in index + 1 ..< inputArray.count {
                if (inputArray[i] >= startValue) {
                    let ramValue = inputArray.remove(at: i)
                    return (.goLeft(inputArray: inputArray, index: i - 1), ramValue)
                }
                else {
                    startValue = inputArray[i]
                }
            }
            
            return (.goLeft(inputArray: inputArray, index: inputArray.count - 1), nil)
        case .done:
            return (.done, nil)
        }
    }
}


var testArray = [1, 2, 3, 4, 6, 8, 1,  4]
var myRobot = Robot.goRight(inputArray: testArray, index: 1)

var ram: Array<Int> = []

while myRobot != .done {
    let (newRobot, ramValue) = myRobot.go()
    myRobot = newRobot
    
    if let ramValue = ramValue {
        ram.append(ramValue)
    }
}

print(ram)
