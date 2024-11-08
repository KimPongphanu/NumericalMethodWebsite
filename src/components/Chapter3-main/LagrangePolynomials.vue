<template>
    <div class="container">
        <!-- Input Section -->
        <div id="box-1">
            <div id="box-left">
                <!-- Section Title -->
                <div id="box-11">
                    <h3>Lagrange Polynomial Interpolation</h3>
                    <label>Number of Data Points (n):</label>
                    <input type="number" v-model.number="numPoints" min="2" max="10" @change="initializeData" />
                </div>

                <!-- Data Points Section -->
                <div id="box-12" v-if="numPoints > 0">
                    <h4>Data Points</h4>
                    <div class="data-grid" :style="{ gridTemplateColumns: `repeat(${Math.min(numPoints, 5)}, 1fr)` }">
                        <div v-for="(point, index) in dataPoints" :key="'point-' + index" class="data-cell" :style="{ marginBottom: index >= 5 ? '10px' : '0' }">
                            <label>X{{ index + 1 }}:</label>
                            <input type="number" v-model.number="dataPoints[index].x" />
                            <label>Y{{ index + 1 }}:</label>
                            <input type="number" v-model.number="dataPoints[index].y" />
                        </div>
                    </div>
                </div>
            </div>

            <!-- Buttons Section -->
            <div id="box-last">
                <div id="box-14">
                    <button @click="randomizeDataPoints">Randomize Test Data</button>
                    <button @click="calculateLagrangePolynomial">Calculate</button>
                </div>
                <!-- Output Section -->
                <div id="box-2" v-if="polynomial">
                    <h4>Lagrange Polynomial:</h4>
                    <p>{{ formattedPolynomial }}</p>
                </div>
            </div>
        </div>
    </div>
</template>

<script>
export default {
    name: "LagrangePolynomialInterpolation",
    data() {
        return {
            numPoints: 2,
            dataPoints: [],
            polynomial: ""
        };
    },
    created() {
        this.initializeData();
    },
    computed: {
        formattedPolynomial() {
            return this.polynomial.replace(/\s\+\s-/g, ' - ').replace(/\*\s\(/g, ' * (').replace(/\/\s\(/g, '/(');
        }
    },
    methods: {
        initializeData() {
            this.dataPoints = Array.from({ length: this.numPoints }, () => ({ x: 0, y: 0 }));
        },
        randomizeDataPoints() {
            this.dataPoints = this.dataPoints.map(() => ({
                x: parseFloat((Math.random() * 10).toFixed(2)),
                y: parseFloat((Math.random() * 10).toFixed(2))
            }));
        },
        calculateLagrangePolynomial() {
            try {
                const n = this.numPoints;
                let terms = [];

                for (let i = 0; i < n; i++) {
                    let term = `${this.dataPoints[i].y}`;
                    for (let j = 0; j < n; j++) {
                        if (i !== j) {
                            const denominator = this.dataPoints[i].x - this.dataPoints[j].x;
                            if (denominator === 0) {
                                alert("Duplicate x values detected. Please enter unique x values.");
                                return;
                            }
                            term += ` * (x - ${this.dataPoints[j].x.toFixed(2)}) / (${denominator.toFixed(6)})`;
                        }
                    }
                    terms.push(`(${term})`);
                }

                // Combine terms into a polynomial
                this.polynomial = terms.join(' + ');
            } catch (error) {
                console.error("Error calculating Lagrange Polynomial:", error);
                alert("An error occurred while calculating the polynomial. Please check your inputs.");
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
    font-size: 16px;
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

.data-grid {
    display: grid;
    grid-template-columns: repeat(auto-fill, minmax(80px, 1fr));
    gap: 10px;
}

.data-cell {
    border: 1px solid #ccc;
    padding: 5px;
    border-radius: 5px;
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
    width: 300px;
    height: auto;
    background-color: #3cff00;
    border-radius: 10px;
    overflow-y: auto;
    padding: 20px;
    display: flex;
    text-align: left;
    flex-direction: column;
    align-items: center;
    font-size: 18px;
}

h3,
h4 {
    text-align: center;
}
</style>
