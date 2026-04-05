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
    // Граничный случай: очень большой массив (не полный, но достаточно большой)
    int large[1000];
    for (int i = 0; i < 1000; ++i) large[i] = i;
    assert(MaxFinder::findMax(large, 1000) == 999);
    
    // Граничный случай: все отрицательные
    int neg[] = {-100, -200, -50, -999};
    assert(MaxFinder::findMax(neg, 4) == -50);
    
    // Граничный случай: макс. элемент в конце
    int end[] = {1, 2, 3, 4, 100};
    assert(MaxFinder::findMax(end, 5) == 100);
    
    // Граничный случай: макс. элемент в начале
    int begin[] = {100, 1, 2, 3};
    assert(MaxFinder::findMax(begin, 4) == 100);
    
    // Исключение: нулевой размер
    int dummy[] = {1, 2};
    bool caught = false;
    try {
        MaxFinder::findMax(dummy, 0);
    } catch (const std::invalid_argument&) {
        caught = true;
    }
    assert(caught);
    
    std::cout << "test_edge_cases: все тесты пройдены!" << std::endl;
    return 0;
}
