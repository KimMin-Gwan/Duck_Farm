import editdistance
from jamo import h2j, j2hcj

def decompose(text):
    return ''.join(j2hcj(h2j(text.replace(" ", ""))))

def search_similar(database, key_data):
    results = []
    decomposed_key_data = decompose(key_data)
    print(decomposed_key_data)
    for item in database:
        decomposed_item = decompose(item)
        print(decomposed_item)
        distance = editdistance.eval(decomposed_item, decomposed_key_data)
        print(item)
        print(f"완성 까지 남은 량{str(distance)} vs 원본 {str(len(decomposed_item))}")
        print(len(decomposed_item) - len(decomposed_key_data))

        if distance <= len(decomposed_item) - len(decomposed_key_data):
            results.append(item)
    return results

database = ["바나나", "바나나 주스", "바나나 우유", "바닐라 아이스크림", "바닐라 라떼", "오렌지 주스"]
key_data = "주스"
result = search_similar(database, key_data)
print(result)  # 예상 출력: ["바나나", "바나나 주스", "바나나 우유"]


