import re

def parse_text_file(file_path):
    with open(file_path, 'r') as file:
        lines = file.readlines()
    return [line.strip() for line in lines]

instructions = parse_text_file('input.txt')

test = "xmul(2,4)%&mul[3,7]!@^do_not_mul(5,5)+mul(32,64]then(mul(11,8)mul(8,5))"

def extract_and_multiply_patterns(text):
    pattern = r'mul\((\d+),(\d+)\)'
    matches = re.findall(pattern, text)
    return sum([int(a) * int(b) for a, b in matches])

somma = 0
for inst in instructions:
    somma += extract_and_multiply_patterns(inst)
print(somma)

# sum = 0
# for i in range(len(instructions) - 1):
#     print(i)
#     sum += extract_and_multiply_patterns(instructions[0])
# print(sum)
