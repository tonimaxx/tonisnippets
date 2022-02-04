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
def list_number(fromnumber, count):
    s = "x" * count
    return [i + fromnumber for i, _ in enumerate(list(s))]


print(list_number(1, 10))


# Create unique list from duplicate list
def unique_list(arr):
    return list(set(arr))


print(unique_list([1, 2, 3, 3, 4, 5]))
