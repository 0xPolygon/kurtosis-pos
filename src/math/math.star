def sum(array):
    total = 0
    for n in array:
        total += n
    return total


def pow(base, exponent):
    result = 1
    for _ in range(exponent):
        result *= base
    return result
