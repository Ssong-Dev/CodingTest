import Foundation

import UIKit
import Foundation


class Node<T: Comparable> {
    var data: T
    var left: Node?
    var right: Node?
    
    init(data: T) {
        self.data = data
    }
}

class BinarySearchTree<T: Comparable> {
    var root: Node<T>?
    var resultCount = 0
    func insert(_ data: T) {
        guard let root = self.root else {
            return self.root = Node.init(data: data)
        }
        
        var currentNode = root
        while true {
            if currentNode.data == data { return }
            if currentNode.data > data {
                guard let nextNode = currentNode.left else {
                    return currentNode.left = Node.init(data: data)
                }
                currentNode = nextNode
            } else {
                guard let nextNode = currentNode.right else {
                    return currentNode.right = Node.init(data: data)
                }
                currentNode = nextNode
            }
        }
    }
    
    func search(from data: T) -> Bool {
        if root == nil { return false }
        
        var currentNode = root
        while let node = currentNode {
            if node.data == data {
                return true
            }
            if node.data > data {
                currentNode = node.left
            } else {
                currentNode = node.right
            }
        }
        return false
    }
    
    func remove(from data: T) -> Bool {
        guard let root = self.root, root.data != data else { return false }
        
        var parentNode = root
        var currentNode: Node? = root
        
        //삭제할 노드 탐색
        while let node = currentNode {
            if node.data == data {
                break
            }
            if node.data > data {
                currentNode = node.left
            } else {
                currentNode = node.right
            }
            parentNode = node
        }
        
        guard let deleteNode = currentNode else {       //탐색 실패
            return false
        }
        
        
        // 1. 자식이 없는 노드 삭제(Leaf Node)
        if deleteNode.left == nil && deleteNode.right == nil {
            if parentNode.data > data {
                parentNode.left = nil
            } else {
                parentNode.right = nil
            }
            return true
        }
        
        // 2. 자식이 1개 있는 노드 삭제
        if (deleteNode.left != nil) && (deleteNode.right == nil) {
            if parentNode.data > data {
                parentNode.left = deleteNode.left
            } else {
                parentNode.right = deleteNode.left
            }
            return true
        }
        if (deleteNode.left == nil) && (deleteNode.right != nil) {
            if parentNode.data > data {
                parentNode.left = deleteNode.right
            } else {
                parentNode.right = deleteNode.right
            }
            return true
        }
        
        // 3. 자식이 2개 있는 노드 삭제
        guard let rightNode = deleteNode.right else { return false }

        var changeNode = rightNode
        var changeParentNode = rightNode

        while let nextNode = changeNode.left {
            changeParentNode = changeNode
            changeNode = nextNode
        }

        if let rightNode = changeNode.right {
            changeParentNode.left = rightNode
        } else {
            changeParentNode.left = nil
        }

        if parentNode.data > data {
            parentNode.left = changeNode
        } else {
            parentNode.right = changeNode
        }

        // Delete Node의 왼쪽, 오른쪽 자식을 changeNode에게 이식
        changeNode.left = deleteNode.left
        changeNode.right = deleteNode.right
        
        return true
    }
}

extension BinarySearchTree {
    func drawDiagram() {
        print(diagram(for: self.root))
    }
    
    private func diagram(for node: Node<T>?,
                         _ top: String = "",
                         _ root: String = "",
                         _ bottom: String = "") -> String {
        guard let node = node else {
            return root + "nil\n"
        }
        if node.left == nil && node.right == nil {
            return root + "\(node.data)\n"
        }
        return diagram(for: node.right, top + " ", top + "┌──", top + "│ ")
            + root + "@@\(node.data)\n"
            + diagram(for: node.left, bottom + "│ ", bottom + "└──", bottom + " ")
    }
}
func calcmin(_ b:[Int])->[Int]{
    var minArr:[Int] = []
    var t = b[0]
    for item in b{
        if t > item
        {
            t = item
        }
        minArr.append(t)
    }
    return minArr
}
func solution(_ a:[Int]) -> Int {
    if a.count < 2
    {
        return a.count
    }
    let result = Set(calcmin(a) + calcmin(a.reversed()))
   
    return result.count
    
}



//solution([-16,27,65,-2,58,-92,-71,-68,-61,-33])
solution([-33, -61, -68, -71, -92, 58, -2, 65, 27, -16])
//solution([-1, 9, -5])


