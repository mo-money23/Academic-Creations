# Tree node code from Data 311 slide 09 on trees
class TreeNode:
    def __init__(self, value, left=None, right=None):
        self.left = left
        self.right = right
        self.value = value
        self.parent = None

    def insertTree(self, value):
        if self.value is None:
            self.value = self.Node(value)
            return
        p = self.value
        prev = None
        while p is not None:
            prev = p
            if value < p.value:
                p = p.left
            else:
                p = p.right
            if value < prev.value:
                prev.left = self.Node(value)
            else:
                prev.right = self.Node(value)

# Function that prints the tree design, from slides
def printTree(self, indent = 0):
    if self.right is not None:
        printTree(self.right, indent + 4)
    print( " " * indent, end = "")
    print(self.value)
    if self.left is not None:
        printTree(self.left, indent + 4)

# Function that searches the tree for a value, from slides
def searchTree(self, value):
    while self.value is not None:
        if self.value == value:
            return True
        if value < self.value:
            self = self.left
        else:
            self = self.right
    return False

# Function that finds the max value in the tree    
def treeMax(self):
    if self is not None:
        maxVal = self.value
        lmax = treeMax(self.left)
        rmax = treeMax(self.right)
        if (lmax > maxVal):
            maxVal = lmax
        if (rmax > maxVal):
            maxVal = rmax
        return maxVal
    else:
        return float('-inf') # Placing a bound so that the max does not fall into it

# Function that finds the min value from the tree       
def treeMin(self):
    if self is not None:
        minVal = self.value
        lmin = treeMin(self.left)
        rmin = treeMin(self.right)
        if lmin < minVal:
            minVal = lmin
        if rmin < minVal:
            minVal = rmin
        return minVal
    else:
        return float('inf') # Placing a bound so that the max does not fall into it

# Function that finds the sum of the tree
def treeNodeSum(self):
    if self is not None:
       nodeSum = (self.value + treeNodeSum(self.left) + treeNodeSum(self.right))
       return nodeSum
    else:
        return 0

# Function that finds the number of nodes
def amountOfNodes(self):
    if self is not None:
        treeSize = (amountOfNodes(self.left) + amountOfNodes(self.right) + 1)
        return treeSize 
    else:
        return 0    

# Building tree from slides
root = TreeNode(20)
root.left = TreeNode(10)
root.left.left = TreeNode(5)
root.left.left.right = TreeNode(7)
root.right = TreeNode(30)
root.right.left = TreeNode(25)
root.right.right = TreeNode(35)
root.right.right.right = TreeNode(100)

# Printing functions
printTree(root)
print(searchTree(root, 7))
print("The max of the BST is:", treeMax(root))
print("The min of the BST is:", treeMin(root))
print("The sum of the BST is:", treeNodeSum(root))
print("The amount of nodes in the BST is:", amountOfNodes(root))



            
