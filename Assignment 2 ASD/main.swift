import Foundation

class Node<node: Equatable> {
    var value: node
    var left: Node?
    var right: Node?
    var neighbors: [Reference<Node>] = []

    init(_ value: node) {
        self.value = value
        self.left = nil
        self.right = nil
    }

    func addNeighbor(_ node: Node) {
        let weakNode = Reference(value: node)
        neighbors.append(weakNode)
    }

    func printNeighbors() {
        for ref in neighbors {
            if let node = ref.value {
                print(node.value)
            } else {
                print("Neighbor is absent")
            }
        }
    }
}

class Reference<T: AnyObject> {
    weak var value: T?

    init(value: T) {
        self.value = value
    }
}

class Tree<node: Equatable> {
    var root: Node<node>?

    init() {
        self.root = nil
    }

    func search(_ neededNode: node) -> Node<node>? {
        return searchHelper(root, neededNode)
    }

    private func searchHelper(_ current: Node<node>?, _ neededNode: node) -> Node<node>? {
        guard let currentNode = current else { return nil }

        if currentNode.value == neededNode {
            return currentNode
        }

        if let leftResult = searchHelper(currentNode.left, neededNode) {
            return leftResult
        }

        if let rightResult = searchHelper(currentNode.right, neededNode) {
            return rightResult
        }

        return nil
    }

    func printNodes() {
        Helper(root)
    }

    private func Helper(_ current: Node<node>?) {
        guard let currentNode = current else { return }

        Swift.print(currentNode.value)
        Helper(currentNode.left)
        Helper(currentNode.right)
    }

    func depth() -> Int {
        return depthHelper(root)
    }

    private func depthHelper(_ current: Node<node>?) -> Int {
        guard let currentNode = current else { return 0 }

        let leftDepth = depthHelper(currentNode.left)
        let rightDepth = depthHelper(currentNode.right)
        return max(leftDepth, rightDepth) + 1
    }
}

func addNode(root: Tree<String>, parentValue: String?, newValue: String, isLeft: Bool) {
    if root.root == nil {
        root.root = Node(newValue)
        print("Successfully added the root node!")
    } else if let parentValue = parentValue, let parentNode = root.search(parentValue) {
        if isLeft {
            if parentNode.left == nil {
                parentNode.left = Node(newValue)
                print("Successfully added left child!")
            } else {
                print("Left child already exists. Choose another action.")
            }
        } else {
            if parentNode.right == nil {
                parentNode.right = Node(newValue)
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
    let tree = Tree<String>()
    let isRunning = true

    while isRunning {
        print("1. Add a node",
              "2. Search for a node",
              "3. Print the whole tree",
              "4. Calculate the depth",
              "5. Add a neighbor",
              "6. Print all neighbors")

        if let choice = readLine() {
            switch choice {
            case "1":
                if tree.root == nil {
                    print("Enter the name of the root node:")
                    if let newValue = readLine() {
                        addNode(root: tree, parentValue: nil, newValue: newValue, isLeft: true)
                    }
                } else {
                    print("Enter the name of a parent node")
                    if let parentValue = readLine() {
                        print("Enter the name of a child node")
                        if let newValue = readLine() {
                            print("Do you want it to be a left or a right node? (L/R)")
                            if let side = readLine()?.uppercased(), side == "L" || side == "R" {
                                let isLeft = side == "L"
                                addNode(root: tree, parentValue: parentValue, newValue: newValue, isLeft: isLeft)
                            }
                        }
                    }
                }

            case "2":
                print("Enter node value to search:")
                if let searchValue = readLine() {
                    if let result = tree.search(searchValue) {
                        print("Node \(result.value) was found.")
                    } else {
                        print("This node was not found")
                    }
                }

            case "3":
                tree.printNodes()

            case "4":
                print("Depth of this tree is \(tree.depth())")

            case "5":
                print("Enter the node to add a neighbor to:")
                if let parentValue = readLine(), let parentNode = tree.search(parentValue) {
                    print("Enter the name of the neighbor node:")
                    if let neighborValue = readLine(), let neighborNode = tree.search(neighborValue) {
                        parentNode.addNeighbor(neighborNode)
                    } else {
                        print("Neighbor node not found.")
                    }
                } else {
                    print("Parent node not found.")
                }

            case "6":
                print("Enter the node to print the neighbors for:")
                if let nodeValue = readLine(), let node = tree.search(nodeValue) {
                    node.printNeighbors()
                } else {
                    print("This node was not found.")
                }

            default:
                print("Wrong command")
            }
        }
    }
}

main()
