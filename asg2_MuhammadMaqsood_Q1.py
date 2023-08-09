# Variables
e = input("Enter a Postfix Expression: ") # Asking for input from user for a postfix expression
stack = []
split_lst = list(e.split())
counter = 0
oper_list = ["+","-","*","/"]
counter = 0

# Function to evaluate post fix expression
def evalPostfix(self):
    number_count = 0
    operand_count = 0

# for loop to look through the split list
    for i in split_lst:
        
# Conditional statements t check for operands
        if ((i == oper_list[0]) or (i == oper_list[1]) or (i == oper_list[2]) or (i == oper_list[3])):
            operand_count += 1

        else:
            number_count += 1
            
# Conditional statements to evaluate the postfix expression
    if number_count == operand_count + 1:
        for i in split_lst:
            if i == oper_list[0]:
                num2 = stack.pop()
                num1 = stack.pop()
                add = num1 + num2
                stack.append(add)
            elif i == oper_list[1]:
                num2 = stack.pop()
                num1 = stack.pop()
                subtract = num1 - num2
                stack.append(subtract)
            elif i == oper_list[2]:
                num2 = stack.pop()
                num1 = stack.pop()
                multiply = num1 * num2
                stack.append(multiply)
            elif i == oper_list[3]:
                num2 = stack.pop()
                num1 = stack.pop()
                divide = num1 / num2
                stack.append(divide)
            else :
                stack.append(int(i))

        print(stack[-1])

    elif ((len(split_lst) == 1) or (len(split_lst) == 2)):
        print("Error:", stack)

    else:
        print("Error:", split_lst) #printing results

evalPostfix(e)


