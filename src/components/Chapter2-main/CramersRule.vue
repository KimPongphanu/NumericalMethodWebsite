<template>
    <div class="container">
        <!-- Input Section -->
        <div id="box-1">

            <div id="boxleft">
                <!-- Section Title -->
                <div id="box-11">
                    <h3>Cramer's Rule</h3>
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



            <!-- Buttons Section -->

            <div id="box-right">
                <!-- Constant Vector Section -->
                <div id="box-13" v-if="numVariables > 0">
                    <h4>Constant Vector (B)</h4>
                    <div class="vector-section">
                        <div v-for="(value, index) in vectorB" :key="'b-' + index" class="vector-cell">
                            <input type="number" v-model.number="vectorB[index]" />
                        </div>
                    </div>
                </div>
            </div>

            <div id="box-last">
                <div id="box-14">
                    <button @click="randomizeMatrices">Randomize Test Data</button>
                    <button @click="calculateCramersRule">Calculate</button>
                </div>
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

        <!-- Output Section -->



    </div>
</template>

<script>
import { matrix, det } from "mathjs";

export default {
    name: "CramersRule",
    data() {
        return {
            numVariables: 2,
            matrixA: [],
            vectorB: [],
            solutions: []
        };
    },
    created() {
        // สร้างเมทริกซ์เมื่อสร้างคอมโพเนนต์ทันที
        this.initializeMatrices();
    },
    methods: {
        // ฟังก์ชันสำหรับการเตรียมค่าเริ่มต้นในเมทริกซ์ A และเวกเตอร์ B
        initializeMatrices() {
            this.matrixA = Array.from({ length: this.numVariables }, () =>
                Array(this.numVariables).fill(0)
            );
            this.vectorB = Array(this.numVariables).fill(0);
        },
        // ฟังก์ชันสุ่มค่าในเมทริกซ์และเวกเตอร์เพื่อใช้เป็น test case
        randomizeMatrices() {
            this.matrixA = this.matrixA.map(row => row.map(() => (Math.random() * 20 - 10).toFixed(2)));
            this.vectorB = this.vectorB.map(() => (Math.random() * 20 - 10).toFixed(2));
        },
        // ฟังก์ชันสำหรับการคำนวณ Cramer's Rule
        calculateCramersRule() {
            try {
                const originalMatrix = matrix(this.matrixA);
                const determinantA = det(originalMatrix);

                if (determinantA === 0) {
                    alert("The determinant of the coefficient matrix is zero. The system has no unique solution.");
                    return;
                }

                this.solutions = [];

                for (let i = 0; i < this.numVariables; i++) {
                    // สร้างเมทริกซ์ใหม่แทนที่ column ที่ i ด้วย vector B
                    const modifiedMatrix = originalMatrix.clone();
                    for (let j = 0; j < this.numVariables; j++) {
                        modifiedMatrix.set([j, i], this.vectorB[j]);
                    }

                    // คำนวณหาค่า determinant ของเมทริกซ์ที่ถูกแทนที่
                    const determinantModified = det(modifiedMatrix);

                    // คำนวณหาค่า xi
                    const solution = determinantModified / determinantA;
                    this.solutions.push(solution.toFixed(6));
                }
            } catch (error) {
                console.error("Error calculating Cramer's Rule:", error);
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
    /* ตั้งค่า top เป็น 0 เพื่อไม่ให้เลื่อนขึ้นไปชนขอบบน */
    /* margin-top: 40px; */
    /* กำหนดระยะห่างจากขอบบน */
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
    /* กำหนดความกว้างเพื่อให้แสดงเมทริกซ์ได้สวยงาม */
}

.matrix-grid {
    display: grid;
    grid-template-columns: repeat(auto-fill, minmax(80px, 1fr));
    /* ปรับให้แสดงจำนวนคอลัมน์ตามขนาดที่ต้องการ */
    gap: 10px;
}

.matrix-cell {
    border: 1px solid #ccc;
    /* เพิ่มกรอบให้กับช่องของเมทริกซ์ */
    padding: 5px;
    border-radius: 5px;
}

.vector-section {
    display: flex;
    flex-direction: column;
    align-items: center;
    gap: 10px;
}

/* #box-last{
    width: 300px;
    height: 300px;
    background-color: aqua;
} */

.vector-cell {
    border: 1px solid #ccc;
    /* เพิ่มกรอบให้กับช่องของเวกเตอร์ */
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
    border-radius: 8px;
    font-size: 18px;
}

#box-right {
    display: flex;
    flex-direction: column;
}

#box-last{
    display: flex;
    flex-direction: column;
}

h3,
h4 {
    text-align: center;
}
</style>
