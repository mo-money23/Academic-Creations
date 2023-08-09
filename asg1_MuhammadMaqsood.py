# Importing CSV and appropriate libraries
import csv
import math
from matplotlib import pyplot as plt
from tabulate import tabulate
from collections import Counter

# Creating and setting variables and empty lists/dictionaries
maxVal = -1
minVal = 1000
matrix = [[], [], [], [], []]
summary_table = [[], [], [], [], []]
col_names = ['Quiz', 'Assignments', 'Exercise', 'Projects', 'Total']
name_count = 0
sumofcol = 0
sumofcol2 = 0
std = 0
current_num = 0
num = 0
counter = 0

# Variables for histograms
x1 = []
y1 = []
col_count = 0
x2 = []
y2 = []
col_count2 = 0
x3 = []
y3 = []
col_count3 = 0
x4 = []
y4 = []
col_count4 = 0
x5 = []
y5 = []
col_count5 = 0

# Opening and reading the CSV file
with open("input.csv", "r") as csv_file:
    csv_reader = csv.reader(csv_file, delimiter=',')
    next(csv_reader) # Using the Next function to skip the first row of data (name of columns)
    for data in csv_reader:
      # Creating a loop to store the data into an appropriate list with proper indexes
      for i in range (5):
        matrix[i].append(data[i])

# Creating a loop to determine max, min, avg, std dev, MCV in each column using variables
    for col in range(5):
      max_num = maxVal
      min_num = minVal
      average = 0
      num_count = 0
      col_sum = 0
      matrix[col] = matrix[col][:-4] # Getting rid of empty cell spaces at the end of the data in CSV

# Creating another loop to check if the number in each column is numeric, setting it as current to determine max, min, avg
      for num in matrix[col]:
        if num.isnumeric():
          current = int(num)
          num_count += 1
          col_sum += current
          if current > max_num:
            max_num = current
          if current < min_num:
            min_num = current
        else:
          max_num = 'n/a'
          min_num = 'n/a'
          average = 'n/a'
          
      average = col_sum / num_count
      
# Loop to determine the standard deviation
      for i in matrix[col]:
        if i.isnumeric():
          var = int(i) - average
          sumofcol += (var*var)
          sumofcol2 = sumofcol/num_count
          std = math.sqrt(sumofcol2)

# Loop to determine most common value
      for i in matrix[col]:
        if i.isnumeric():
          occ_count = Counter(matrix[col])
          num = occ_count.most_common(1)[0][0]
          
# Adding each value into a dictionary for ease of recalling values
      summary_table[col].append(max_num)
      summary_table[col].append(min_num)
      summary_table[col].append(average)
      summary_table[col].append(std)
      summary_table[col].append(num)

# Loop created to generate table from summary_table dictionary which contains values
    for column in summary_table:
      table = [[col_names[name_count], ' '],['Maximum:', column[0]], ['Minimum:', column[1]], ['Average:', column[2]], ['Standard Deviation:', column[3]], ['Most Common Value:', column[4]]]
      print(tabulate(table, headers = 'firstrow', tablefmt = 'fancy_grid'))
      name_count += 1
      
# Loop created to generate histograms for displaying data
    for i in summary_table:
      x1.append(col_names[col_count])
      y1.append(i[0])
      col_count += 1


    plt.bar(x1, y1, color = 'r', width = 0.72, label = 'Max')
    plt.xlabel('Categories')
    plt.ylabel('Maximum')
    plt.title('Maximum of each Category')
    plt.legend()
    plt.show()

    for i in summary_table:
      x2.append(col_names[col_count2])
      y2.append(i[1])
      col_count2 += 1


    plt.bar(x2, y2, color = 'b', width = 0.72, label = 'Min')
    plt.xlabel('Categories')
    plt.ylabel('Minimum')
    plt.title('Minimum of each Category')
    plt.legend()
    plt.show()

    for i in summary_table:
      x3.append(col_names[col_count3])
      y3.append(i[2])
      col_count3 += 1


    plt.bar(x3, y3, color = 'g', width = 0.72, label = 'Avg')
    plt.xlabel('Categories')
    plt.ylabel('Average')
    plt.title('Average of each Category')
    plt.legend()
    plt.show()

    for i in summary_table:
      x4.append(col_names[col_count4])
      y4.append(i[3])
      col_count4 += 1


    plt.bar(x4, y4, color = 'm', width = 0.72, label = 'Std Dev')
    plt.xlabel('Categories')
    plt.ylabel('Standard Deviation')
    plt.title('Standard Deviation of each Category')
    plt.legend()
    plt.show()

    for i in summary_table:
      x5.append(col_names[col_count5])
      y5.append(i[4])
      col_count5 += 1


    plt.bar(x5, y5, color = 'c', width = 0.72, label = 'MCV')
    plt.xlabel('Categories')
    plt.ylabel('Most Common Value')
    plt.title('Most Common Value of each Category')
    plt.legend()
    plt.show()
    
