/* eslint-disable */
<template>
    <div class="container">
        <!-- Input Section -->
        <div id="box-1">
            <div id="box-left">
                <!-- Section Title -->
                <div id="box-11">
                    <h3>Cholesky Decomposition Method</h3>
                    <label>Number of Variables (n):</label>
                    <input type="number" v-model.number="numVariables" min="2" max="4" @change="initializeMatrices" />
                </div>

                <!-- Coefficient Matrix Section -->
                <div id="box-12" v-if="numVariables > 0">
                    <h4>Coefficient Matrix (A)</h4>
                    <div class="matrix-grid" :style="{ gridTemplateColumns: `repeat(${numVariables}, 1fr)` }">
                        <div v-for="(row, rowIndex) in matrixA" :key="'row-' + rowIndex">
                            <div v-for="(value, colIndex) in row" :key="'col-' + colIndex" class="matrix-cell">
                                <input type="number" v-model.number="matrixA[rowIndex][colIndex]" />
                            </div>
                        </div>
                    </div>
                </div>
            </div>

            <!-- Constant Vector Section -->
            <div id="box-right">
                <div id="box-13" v-if="numVariables > 0">
                    <h4>Constant Vector (B)</h4>
                    <div class="vector-section">
                        <div v-for="(value, index) in vectorB" :key="'b-' + index" class="vector-cell">
                            <input type="number" v-model.number="vectorB[index]" />
                        </div>
                    </div>
                </div>
            </div>

            <!-- Buttons Section -->
            <div id="box-last">
                <div id="box-14">
                    <button @click="randomizeMatrices">Randomize Test Data</button>
                    <button @click="calculateCholeskyDecomposition">Calculate</button>
                </div>
                <!-- Output Section -->
                <div id="box-2" v-if="solutions.length > 0">
                    <h4>Solutions:</h4>
                    <ul>
                        <li v-for="(solution, index) in solutions" :key="'solution-' + index">
                            x{{ index + 1 }} = {{ solution }}
                        </li>
                    </ul>
                </div>
            </div>
        </div>
    </div>
</template>

<script>
import { matrix } from "mathjs";

export default {
    name: "CholeskyDecompositionMethod",
    data() {
        return {
            numVariables: 2,
            matrixA: [],
            vectorB: [],
            solutions: []
        };
    },
    created() {
        this.initializeMatrices();
    },
    methods: {
        initializeMatrices() {
            this.matrixA = Array.from({ length: this.numVariables }, () =>
                Array(this.numVariables).fill(0)
            );
            this.vectorB = Array(this.numVariables).fill(0);
        },
        randomizeMatrices() {
            let symmetricMatrix = Array.from({ length: this.numVariables }, () =>
                Array(this.numVariables).fill(0).map(() => Math.random() * 5 + 1) // Generate positive values to ensure semi-definiteness
            );

            // Make the matrix symmetric and positive semi-definite
            for (let i = 0; i < this.numVariables; i++) {
                for (let j = i; j < this.numVariables; j++) {
                    symmetricMatrix[j][i] = symmetricMatrix[i][j];
                }
                // Ensure diagonal elements are large enough to make the matrix positive definite
                symmetricMatrix[i][i] += this.numVariables;
            }

            this.matrixA = symmetricMatrix.map(row => row.map(value => value.toFixed(2)));
            this.vectorB = this.vectorB.map(() => (Math.random() * 10).toFixed(2));
        },
        calculateCholeskyDecomposition() {
            try {
                const n = this.numVariables;
                const A = matrix(this.matrixA)._data;
                const B = matrix(this.vectorB)._data;

                // Check if matrix A is positive semi-definite
                for (let i = 0; i < n; i++) {
                    if (A[i][i] <= 0) {
                        alert("The coefficient matrix must be positive semi-definite. Please check your inputs.");
                        return;
                    }
                }

                // Perform Cholesky Decomposition
                let L = Array(n).fill(0).map(() => Array(n).fill(0));

                for (let i = 0; i < n; i++) {
                    for (let j = 0; j <= i; j++) {
                        let sum = 0;
                        for (let k = 0; k < j; k++) {
                            sum += L[i][k] * L[j][k];
                        }
                        if (i === j) {
                            if (A[i][i] - sum <= 0) {
                                alert("The coefficient matrix must be positive semi-definite. Please check your inputs.");
                                return;
                            }
                            L[i][j] = Math.sqrt(A[i][i] - sum);
                        } else {
                            L[i][j] = (A[i][j] - sum) / L[j][j];
                        }
                    }
                }

                // Solve Ly = B
                let y = Array(n).fill(0);
                for (let i = 0; i < n; i++) {
                    let sum = 0;
                    for (let k = 0; k < i; k++) {
                        sum += L[i][k] * y[k];
                    }
                    y[i] = (B[i] - sum) / L[i][i];
                }

                // Solve L^T x = y
                let x = Array(n).fill(0);
                for (let i = n - 1; i >= 0; i--) {
                    let sum = 0;
                    for (let k = i + 1; k < n; k++) {
                        sum += L[k][i] * x[k];
                    }
                    x[i] = (y[i] - sum) / L[i][i];
                }

                this.solutions = x.map(value => value.toFixed(6));
            } catch (error) {
                console.error("Error calculating Cholesky Decomposition Method:", error);
                alert("An error occurred while calculating the solutions. Please check your inputs.");
            }
        }
    }
};
</script>

<style scoped>
body {
    display: flex;
    flex-direction: row;
    align-items: center;
}

input {
    width: 80px;
    height: 30px;
    margin: 5px;
}

label {
    font-size: 20px;
    margin-bottom: 5px;
}

button {
    width: 150px;
    height: 35px;
    margin-top: 15px;
}

.container {
    position: relative;
    top: 20px;
    width: 1300px;
    height: 460px;
    display: flex;
    flex-direction: row;
    gap: 20px;
    overflow: auto;
}

#box-1 {
    position: relative;
    top: 0;
    margin-top: 40px;
    width: 1200px;
    height: 650px;
    background-color: #FEFBF6;
    display: flex;
    flex-direction: row;
    align-items: center;
    gap: 20px;
    border-radius: 8px;
    padding: 20px;
    box-sizing: border-box;
    overflow-y: auto;
}

#box-left {
    display: flex;
    flex-direction: column;
    gap: 15px;
}

#box-right {
    display: flex;
    flex-direction: column;
}

#box-last {
    display: flex;
    flex-direction: column;
}

#box-11 {
    display: flex;
    flex-direction: column;
    align-items: center;
    gap: 10px;
}

#box-12 {
    display: flex;
    flex-direction: column;
    align-items: center;
    gap: 15px;
    width: 600px;
}

.matrix-grid {
    display: grid;
    grid-template-columns: repeat(auto-fill, minmax(80px, 1fr));
    gap: 10px;
}

.matrix-cell {
    border: 1px solid #ccc;
    padding: 5px;
    border-radius: 5px;
}

.vector-section {
    display: flex;
    flex-direction: column;
    align-items: center;
    gap: 10px;
}

.vector-cell {
    border: 1px solid #ccc;
    padding: 5px;
    border-radius: 5px;
}

#box-13 {
    display: flex;
    flex-direction: column;
    align-items: center;
    gap: 10px;
}

#box-14 {
    position: sticky;
    top: 0;
    display: flex;
    flex-direction: column;
    align-items: center;
    gap: 10px;
    background-color: #f7fef6;
    padding: 10px;
    border-radius: 8px;
    z-index: 10;
}

#box-2 {
    width: 200px;
    height: 200px;
    background-color: #3cff00;
    border-radius: 10px;
    overflow-y: auto;
    padding: 20px;
    display: flex;
    flex-direction: column;
    align-items: center;
    font-size: 18px;
}

h3,
h4 {
    text-align: center;
}
</style>
