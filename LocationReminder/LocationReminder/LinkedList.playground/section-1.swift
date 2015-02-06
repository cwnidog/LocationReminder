// Playground - noun: a place where people can play

import UIKit

class ListNode
{
  var data: Int!
  var next: ListNode!
  
  init(number : Int)
  {
    self.data = number
    self.next = nil
  } // init()
} // ListNode

class LinkedList {
  var head : ListNode!
  var tail : ListNode!
  
  init (newNode : ListNode)
  {
    self.head = newNode
    self.tail = newNode
  }
  
  func addNodeAtHead(node : ListNode)
  {
    node.next = self.head
    self.head = node
  } // addNodeAtHead()
  
  func addNodeAtTail(node : ListNode)
  {
    self.tail.next = node
    self.tail = node
  } // addNodeAtTail()
  
} // Linked List

var newNum = 1
var newNode = ListNode(number: newNum)
var myList = LinkedList(newNode: newNode)

newNum = 37
newNode = ListNode(number: newNum)
myList.addNodeAtHead(newNode)

newNum = 1000
newNode = ListNode(number: newNum)
myList.addNodeAtTail(newNode)

var currNode = myList.head
while currNode != nil
{
  println(currNode.data)
  currNode = currNode.next
} // while currNode != nil

