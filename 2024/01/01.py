def parse_file(file_name):
    with open(file_name, 'r') as file:
        lines = file.readlines()
    first_numbers = []
    second_numbers = []
    for line in lines:
        first, second = line.split()
        first_numbers.append(int(first))
        second_numbers.append(int(second))
    return sorted(first_numbers), sorted(second_numbers)

def part1(list1, list2):    
    return sum([y-x if (x<y) else x-y for x, y in zip(list1, list2)])

def part2(list1, list2):
    return sum([x * list2.count(x) for x in list1])

if __name__ == '__main__':
    file_name = 'input.txt'
  # file_name = 'test.txt'
    left_numbers, right_numbers = parse_file(file_name)
    print(part1(left_numbers, right_numbers))
    print(part2(left_numbers, right_numbers))