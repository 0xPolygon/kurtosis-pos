def int_to_hex(n):
    if n == 0:
        return "0x0"

    # Handle the conversion using a for loop.
    # We can use a fixed upper limit for the number of digits we expect
    # For example, we can assume we're dealing with 16 hex digits (64 bits).
    # Therefore, the maximum value that can be processed is 16^16 - 1,
    # or approximately, 1152921504606846975.
    hex_digits_upper_limit = 16

    hex_chars = "0123456789abcdef"
    hex_string = ""
    for i in range(hex_digits_upper_limit):
        remainder = n % 16
        hex_string = hex_chars[remainder] + hex_string
        n = n // 16

        # Break early if no more digits are left to process.
        if n == 0:
            break

    return "0x" + hex_string
