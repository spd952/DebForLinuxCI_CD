#include <cassert>
#include <iostream>
#include <stdexcept>

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
    bool exception_thrown;
    
    // Тест 1: передан nullptr
    exception_thrown = false;
    try {
        MaxFinder::findMax(nullptr, 5);
    } catch (const std::invalid_argument&) {
        exception_thrown = true;
    }
    assert(exception_thrown);
    
    // Тест 2: размер отрицательный
    int arr[] = {10, 20, 30};
    exception_thrown = false;
    try {
        MaxFinder::findMax(arr, -1);
    } catch (const std::invalid_argument&) {
        exception_thrown = true;
    }
    assert(exception_thrown);
    
    // Тест 3: размер = 0
    exception_thrown = false;
    try {
        MaxFinder::findMax(arr, 0);
    } catch (const std::invalid_argument&) {
        exception_thrown = true;
    }
    assert(exception_thrown);
    
    // Дополнительно: проверка, что при корректных данных исключение не бросается
    try {
        MaxFinder::findMax(arr, 3);
    } catch (...) {
        assert(false && "Не должно быть исключения");
    }
    
    std::cout << "test_negative: все тесты пройдены!" << std::endl;
    return 0;
}
