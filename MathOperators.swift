import Foundation

private var userDecimalPlaces = 0
private var num1: Double = 0.0
private var num2: Double = 0.0
private var userOperation: String = ""
private let OPERATIONS = ["+", "-", "*", "/", "^", "sqrt"]

func main() {
    print("\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n")
    print("Hello! Welcome to the calculator!")

    // Gets the user's input, if there weren't any error messages returned,
    // it calls the math function. If not, prints the error message.
    let errorMessage = getUserValues()!
    if errorMessage == "No errors" {
        print("Answer: \(arithmetic(num1, num2, userDecimalPlaces, userOperation))")
    } else {
        print(errorMessage)
    }
}

// Used to check if user's operator actually exists
private func isValidOperation(_ userOperation: String) -> Bool {
    return OPERATIONS.contains(userOperation)
}

// Method used to retrieve the user's input
private func getUserValues() -> String? {
    print("Enter how many decimal places you want in your answers: ", terminator: "")

    guard let decimalPlaces = Int(readLine()!) else {
        return "You must only enter a whole number!"
    }
    userDecimalPlaces = decimalPlaces

    // Asks the user for the operation they want to use
    print("Enter the operation you wish to perform\n")
    print("(+, -, *, /, ^, sqrt)\n>> ", terminator: "")

    let operation = readLine()!
    guard isValidOperation(operation) else {
        return "You must enter a listed operator!"
    }
    userOperation = operation

    // Gets numbers from the user. If the user wants to square root,
    // just tells them to enter one number.
    if userOperation.first != "s" {
        print("Enter num 1: ", terminator: "")
        guard let input1 = Double(readLine()!) else {
            return "You must only enter numbers!"
        }
        num1 = input1

        print("Enter num 2: ", terminator: "")
        guard let input2 = Double(readLine()!) else {
            return "You must only enter numbers!"
        }
        num2 = input2
    } else {
        print("Enter a number to square root: ", terminator: "")
        guard let input1 = Double(readLine()!) else {
            return "You must enter a valid number!"
        }
        num1 = input1
    }
    // Returns any error messages or lack thereof
    return errorCheck()
}

// Function used to catch any mathematically impossible operations
private func errorCheck() -> String {
    // Checks for division by 0
    if num2 == 0 && userOperation == "/" {
        return "You cannot divide by zero!"
    } else if num1 < 0 && userOperation == "sqrt" {
        return "You can't take the square root of a negative number!"
    }
    // If no errors were found, returns string saying no errors found
    return "No errors"
}

// Method used to do math and rounding. Returns a string that can be printed.
private func arithmetic(_ num1: Double, _ num2: Double, _ decimalPlaces: Int, _ operation: String) -> String {
    // Sets the decimal precision of the decimal formatter.
    let decimalFormatter = NumberFormatter()
    decimalFormatter.minimumFractionDigits = decimalPlaces
    decimalFormatter.maximumFractionDigits = decimalPlaces

    var result: Double = 0.0
    switch operation {
    case "+":
        result = num1 + num2
    case "-":
        result = num1 - num2
    case "*":
        result = num1 * num2
    case "/":
        result = num1 / num2
    case "^":
        result = pow(num1, num2)
    default:
        result = sqrt(num1)
    }
    return decimalFormatter.string(from: NSNumber(value: result)) ?? ""
}

// Function to scan integer input
extension Scanner {
    func scanInt() -> Int? {
        var intValue: Int = 0
        if self.scanInt(&intValue) {
            return intValue
        } else {
            return nil
        }
    }
}

// Function to scan double input
extension Scanner {
    func scanDouble() -> Double? {
        var doubleValue: Double = 0.0
        if self.scanDouble(&doubleValue) {
            return doubleValue
        } else {
            return nil
        }
    }
}

main()
