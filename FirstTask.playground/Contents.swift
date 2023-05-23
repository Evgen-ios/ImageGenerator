// **Условия задачи:**
// На вход подается матрица A x B (1 <= A, B <= 10^3; 1 <= A * B <= 10^3). Значение каждой ячейки - целое число 0 или 1.
// Найти наименьшее расстояние от каждой ячейки до ближайшей ячейки со значением 1. Расстояние между соседними ячейками равно 1.

// Входная матрица:
// [[1,0,1],
// [0,1,0],
// [0,0,0]]

// Выходная матрица:
// [[0,1,0],
// [1,0,1],
// [2,1,2]]

let matrix = [[1,0,1],
              [0,1,0],
              [0,0,0]]

func minimumDistance(matrix: [[Int]]) -> [[Int]] {
    var result = matrix
    
    for row in 0..<matrix.count {
        for item in 0..<matrix[0].count {
            guard matrix[row][item] != 1 else {
                result[row][item] = 0
                continue
            }
            
            let leftDistance = item != 0 ? result[row][item-1] + 1 : Int.max
            let upDistance = row != 0 ? result[row-1][item] + 1 : Int.max
            result[row][item] = min(leftDistance, upDistance)
        }
    }
    return result
}

minimumDistance(matrix: matrix)
