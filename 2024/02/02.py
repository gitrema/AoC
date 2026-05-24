def parse_reports(file_path):
    reports = []
    with open(file_path, 'r') as file:
        for line in file:
            # Split the line by whitespace and convert each part to an integer
            report = list(map(int, line.split()))
            reports.append(report)
    return reports

# Example usage:
reports = parse_reports('input.txt')
# reports = parse_reports('test.txt')

def check_pairs(numbers):
    sort_order = numbers[0] < numbers[1]
    for i in range(len(numbers) - 1):
        if abs(numbers[i] - numbers[i+1]) > 3 or numbers[i] == numbers[i+1] or sort_order != (numbers[i] < numbers[i+1]):
            return 0
    return 1

def part1(reports):
    result = []
    for report in reports:
        result.append(check_pairs(report))
    return sum(result)

def part2(reports):
    result = []
    for report in reports:
        safe = check_pairs(report)
        i = 0
        while i < len(report) - 1 and safe == 0:
            safe = check_pairs(report[:i] + report[i+1:])
            i += 1
        result.append(safe)
    return sum(result)

print(part1(reports))
print(part2(reports))