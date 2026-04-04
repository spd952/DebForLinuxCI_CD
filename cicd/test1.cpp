#include <cassert>
#include <iostream>

// Подключаем класс MaxFinder (дублируем для самодостаточности или выносите в header)
class MaxFinder {
public:
    static int findMax(const int* arr, int size) {
        if (size <= 0 || arr == nullptr) {
            throw std::invalid_argument("Invalid array or size");
        }
        int maxVal = arr[0];
        for (int i = 1; i < size; ++i) {
            if (arr[i] > maxVal) {
                maxVal = arr[i];
            }
        }
        return maxVal;
    }
};

int main() {
    // Тест 1: обычный массив положительных чисел
    int arr1[] = {5, 2, 8, 1, 9, 3, 7};
    assert(MaxFinder::findMax(arr1, 7) == 9);
    
    // Тест 2: массив с отрицательными и положительными
    int arr2[] = {-10, 0, 20, -5, 15};
    assert(MaxFinder::findMax(arr2, 5) == 20);
    
    // Тест 3: массив из одного элемента
    int arr3[] = {42};
    assert(MaxFinder::findMax(arr3, 1) == 42);
    
    // Тест 4: все элементы одинаковы
    int arr4[] = {7, 7, 7, 7};
    assert(MaxFinder::findMax(arr4, 4) == 7);
    
    std::cout << "test_basic: все тесты пройдены!" << std::endl;
    return 0;
}
