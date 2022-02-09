"""
write a program to verify the given number is palindrome or not
ex: 121 - Palindrome
    345 - Not Palindrome
"""

# Algorithmic Version
def is_palindrome(str):
    # create reverse string
    s = list(str)
    _rstr = []
    for i in range(len(s)):
        _rstr.append(s[len(s)-1-i])
    rstr = ''.join(_rstr)
    return 121 if str == rstr else 345

print(is_palindrome("madam")) # 121
print(is_palindrome("hello")) # 345

exit()

# Short version
def is_palindrome_easy(str):
    return 121 if str == str[::-1] else 345



def duplicate_least(str):
    s = list(str)
    x = {x:s.count(x) for x in set(s)}
    all_values = list(x.values())
    min_key = min(all_values)
    p = [i for i, k in x.items() if k == min_key]
    return p

print(duplicate_least("aabbcdef"))

exit()


str = "maps,maps,maps,toni,toni,toni,toni,books,button,learn,start,phone,call,hangout,gvc,future,meeting,tech,shop,google,maps,books,button,learn,start,phone,call,hangout,google, gvc,future,meeting,tech,shop, google"
str = "a,b,b,c,c,d"

def most_repeat(str):
    s = str.replace(' ','').split(",")
    x = {x:s.count(x) for x in set(s)}

    all_values = list(x.values())

    max_key = max(all_values)

    p = [i for i,k in x.items() if k == max_key]
    return p

print(most_repeat(str))

exit()

def merge_array(*arg):
    unsorted_list = []
    sorted_list = []
    for a in arg:
        unsorted_list.extend(a)

    while unsorted_list:
        minimum = unsorted_list[0]
        for item in unsorted_list:
            if item < minimum:
                minimum = item
        sorted_list.append(minimum)
        unsorted_list.remove(minimum)

    return sorted_list

print(merge_array([7,2,3],[4,5,6]))

exit()

def reverse_string(str):
    slice = str[::-1]

    rev = []
    for i in range(len(str)):
        rev.append(str[len(str)-i-1])

    return ''.join(rev)

print(reverse_string("abcdef"))

exit()

"""
Create function that returns output list of number grouped by the first digit
Eg.  input [11,12,13,14,15,21,22,23,24,31,32,33]
output ['11,12,13,14,15', '21,22,23,24', '31,32,33']
#HCL #GOOGLE
"""

i = [11, 12, 13, 14, 15, 21, 22, 23, 24, 31, 32, 33]
print(type(i))


def group_number(intlist):
    group = {}
    for i in intlist:
        left = str(i)[0:1]
        if left in group:
            group[left] += f",{str(i)}"
        else:
            group[left] = str(i)
    return list(group.values())


print(group_number(i))

exit()


# Find the highest number
def find_highest(arr, highest_no):
    arr_sorted = sorted(set(arr))[::-1]
    return arr_sorted[highest_no - 1]


s = 1, 2, 3, 4, 5, 6, 7, 6, 5, 4, 8, 3
print(find_highest(s, 1))

# Find all most repeat
str = "maps,maps,maps,toni,toni,toni,toni,books,button,learn,start,phone,call,hangout,gvc,future,meeting,tech,shop,google,maps,books,button,learn,start,phone,call,hangout,google, gvc,future,meeting,tech,shop, google"


def most_repeat(str):
    s = str.replace(' ', '').split(",")
    x = {x: s.count(x) for x in set(s)}
    all_values = list(x.values())
    max_key = max(all_values)
    p = [i for i, k in x.items() if k == max_key]
    return p


print(most_repeat(str))


# Create list for number without using range
def list_number(start, count):
    s = "x" * count
    return [i + start for i, _ in enumerate(list(s))]


print(list_number(1, 10))


# Create unique list from duplicate list
def unique_list(arr):
    return list(set(arr))


print(unique_list([1, 2, 3, 3, 4, 5]))
