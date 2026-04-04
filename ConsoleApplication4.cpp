#include <iostream>
#include <vector>

class MaxFinder {
public:

    static int findMax(const int* arr, int size) {
        if (size <= 0 || arr == nullptr) {
            throw std::invalid_argument("Invalid array or size");
        }
        int maxVal = arr[0];
        std::cout << "mass:";
        for (int i = 1; i < size; ++i) {
            if (arr[i] > maxVal) {
                maxVal = arr[i];

            }
            std::cout << " " << arr[i];
        }
        return maxVal;
    }
};

int main() {
    std::vector<int> numbers;
    int n, value;

    try {

        // Демонстрация работы с обычным массивом
        int arr[] = { 5, 2, 8, 1, 9, 3, 7 };
        int maxArr = MaxFinder::findMax(arr, 7);
        std::cout << " Maximum in static array: " << maxArr << std::endl;

    }
    catch (const std::exception& e) {
        std::cerr << "Error: " << e.what() << std::endl;
        return 1;
    }

    return 0;
}