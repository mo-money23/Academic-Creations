# Retrieved from slides (linked lists slide deck)
class LList:
    class Node:
        def __init__(self, val, next = None):
            self.val = val
            self.next = next

    def __init__(self):
        self.head = None
        self.size = 0
        
    def addFront(self, val):
        self.head = self.Node(val, self.head)
        self.size += 1

    def removeFront(self):
        if self.head is not None:
            self.head = self.head.next
            print("Successful Operation")

    def print(self):
        node = self.head
        if node is not None:
            print("[" , sep = '', end = '')
        while node is not None:
            if node.next == None:
                print(node.val, sep = ' ', end = '')

            else:
                print(node.val, sep = ' ', end = ',')

            node = node.next

        if self.head != None:
            print("]" , sep = '', end = '')

        if lst.count() == 0:
            print(" \nThe count is: 0 elements") # Printing 0 elements if list empty
        else:
            print(" \nThe count is:", lst.count())

# Function to check the count of the linked list
    def count(self):
        count, node = 0, self.head
        if node == None:
            print("Empty List")
            print("List NOT initialized") # Printing list is not initialized if list is null/empty
        while node is not None:
            count += 1
            node = node.next
        return count

    def addElement(self, index, val):
        if index > self.size or index < 0:
            print("the index", index, "is out of the range")
            return False
        if index == 0:
            self.addFront(val)
        else:
            node = self.head
            for i in range(0, index - 1):
                node = node.next
            node.next = self.Node(val, node.next)
        print("Successful Operation")
        self.size += 1

# Function to check if an element exists in the linked list
    def exists(self, value):
        node = self.head
        while node is not None:
            nodeValue = node.val
            if (nodeValue == value):
                return True
            node = node.next
        return False
            
# Testing the different functions
lst = LList()
lst.addFront(11)
lst.addElement(0,3)
lst.removeFront()
lst.print()



