set_list = set()

set_list.add("1")
set_list.add("2")
set_list.add("1")


list_data = []

list_data.append("1")
list_data.append("2")
list_data.append("3")

set_list.update(list_data)
print(set_list)