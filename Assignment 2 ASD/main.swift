import Foundation

class Tree<node: Equatable> {
    var value: node
    var left: Tree?
    var right: Tree?

    init(_ value: node) {
        self.value = value
        self.left = nil
        self.right = nil
    }

    func search(_ neededNode: node) -> Tree? {
        if value == neededNode {
            return self
        }
        if let leftResult = left?.search(neededNode) {
            return leftResult
        }
        if let rightResult = right?.search(neededNode) {
            return rightResult
        }
        return nil
    }

    func printNodes() {
        Swift.print(value)
        left?.printNodes()
        right?.printNodes()
    }

    func depth() -> Int {
        let leftDepth = left?.depth() ?? 0
        let rightDepth = right?.depth() ?? 0
        return max(leftDepth, rightDepth) + 1
    }
}

func addNode(root: Tree<String>, parentValue: String, newValue: String, isLeft: Bool) {
    if let parentNode = root.search(parentValue) {
        if isLeft {
            if parentNode.left == nil {
                parentNode.left = Tree(newValue)
                print("Successfully added left child!")
            } else {
                print("Left child already exists. Choose another action.")
            }
        } else {
            if parentNode.right == nil {
                parentNode.right = Tree(newValue)
                print("Successfully added right child!")
            } else {
                print("Right child already exists. Choose another action.")
            }
        }
    } else {
        print("Could not find the parent node")
    }
}

func main() {
    let root = Tree("Root")
    var isRunning = true

    while isRunning {
        print("1. Add a node",
              "2. Search for a node",
              "3. Print the whole tree",
              "4. Calculate the depth")
        
        if let choice = readLine() {
            switch choice {
            case "1":
                print("Enter the name of a parent node")
                if let parentValue = readLine() {
                    print("Enter the name of a child node")
                    if let newValue = readLine() {
                        print("Do you want it to be a left or a right node? (L/R)")
                        if let side = readLine()?.uppercased(), side == "L" || side == "R" {
                            let isLeft = side == "L"
                            addNode(root: root, parentValue: parentValue, newValue: newValue, isLeft: isLeft)
                        }
                    }
                }

            case "2":
                print("Enter node value to search:")
                if let searchValue = readLine() {
                    if let result = root.search(searchValue) {
                        print("This node was found")
                    } else {
                        print("This node was not found")
                    }
                }

            case "3":
                root.printNodes()

            case "4":
                print("Depth of this tree is \(root.depth())")

            default:
                print("Wrong command")
            }
        }
    }
}

main()
