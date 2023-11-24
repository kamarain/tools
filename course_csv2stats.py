import csv
import matplotlib.pyplot as plt
import numpy as np

csv_filename = '/home/kamarain/Downloads/DATA.ML.100-2023-2024-1-TAU Arvioinnit.csv'

exercises_tot_colno=14-1
hw_tot_colno=24-1
tests_tot_colno=27-1
points_tot_colno=30-1
grade_colno=31-1

exercise_points = []
homework_points = []
test_points = []
tot_points = []
grades = []
with open(csv_filename) as csv_file:
    csv_reader = csv.reader(csv_file, delimiter=',')
    line_count = 0
    for row in csv_reader:
        if line_count == 0:
            print(f'Column names are {", ".join(row)}')
            line_count += 1
        else:
            exercise_points.append(row[exercises_tot_colno])
            homework_points.append(row[hw_tot_colno])
            test_points.append(row[tests_tot_colno])
            tot_points.append(row[points_tot_colno])
            grades.append(row[grade_colno])
    print(f'Processed {line_count} lines.')

# Histogram plots
exercise_points_int = [eval(i) for i in exercise_points]
plt.hist(exercise_points_int, bins=[0, 10, 20, 30, 40, 50, 60])
plt.title('Exercise points histogram')
plt.show()

homework_points_int = [eval(i) for i in homework_points]
plt.hist(homework_points_int, bins=[0, 5, 10, 15, 20])
plt.title('Homework points histogram')
plt.show()

test_points_int = [eval(i) for i in test_points]
plt.hist(test_points_int, bins=[0, 5, 10, 15, 20, 25])
plt.title('Online points histogram')
plt.show()

tot_points_int = [eval(i) for i in tot_points]
plt.hist(tot_points_int, bins=[0, 20, 40, 60, 80, 100, 120, 140])
plt.title('Total points histogram')
plt.show()

grades_int = [eval(i) for i in grades]
plt.hist(grades_int, bins=[-0.5, 0.5, 1.5, 2.5, 3.5, 4.5, 5.5])
plt.title('Grades histogram')
plt.show()

# Correlation plots

r = np.corrcoef(exercise_points_int, test_points_int)
plt.plot(exercise_points_int, test_points_int,'ko')
plt.title('Correlation of exercise vs online points (correlation: %.3f)' % r[0,1])
plt.show()

r = np.corrcoef(homework_points_int, test_points_int)
plt.plot(homework_points_int, test_points_int,'ko')
plt.title('Correlation of homework vs online points (correlation: %.3f)' % r[0,1])
plt.show()

r = np.corrcoef(exercise_points_int, test_points_int)
plt.plot(tot_points_int, grades_int,'ko')
plt.title('Correlation of total points vs grade')
plt.show()
