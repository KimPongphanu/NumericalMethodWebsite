/* eslint-disable */
<template>
    <div class="container">
        <!-- Input Section -->
        <div id="box-1">
            <div id="box-left">
                <!-- Section Title -->
                <div id="box-11">
                    <h3>Multiple Linear Regression</h3>
                    <label>Number of Data Points (n):</label>
                    <input type="number" v-model.number="numPoints" min="2" max="10" @change="initializeData" />
                    <label>Number of Features (m):</label>
                    <input type="number" v-model.number="numFeatures" min="1" max="5" @change="initializeData" />
                </div>

                <!-- Data Points Section -->
                <div id="box-12" v-if="numPoints > 0 && numFeatures > 0">
                    <h4>Data Points</h4>
                    <div class="data-grid" :style="{ gridTemplateColumns: `repeat(${Math.min(numPoints, 5)}, 1fr)` }">
                        <div v-for="(point, index) in dataPoints" :key="'point-' + index" class="data-cell">
                            <div v-for="featureIndex in numFeatures" :key="'feature-' + featureIndex">
                                <label>X{{ index + 1 }}{{ featureIndex }}:</label>
                                <input type="number" v-model.number="dataPoints[index].features[featureIndex - 1]" />
                            </div>
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
                    <button @click="calculateMultipleLinearRegression">Calculate</button>
                </div>
                <!-- Output Section -->
                <div id="box-2" v-if="coefficients.length > 0">
                    <h4>Multiple Linear Regression Coefficients:</h4>
                    <ul>
                        <li>Intercept (a0) = {{ coefficients[0].toFixed(4) }}</li>
                        <li v-for="(coef, index) in coefficients.slice(1)" :key="'coef-' + index">Coefficient a{{ index + 1 }} = {{ coef.toFixed(4) }}</li>
                    </ul>
                </div>
            </div>
        </div>
    </div>
</template>

<script>
import * as math from "mathjs";

export default {
    name: "MultipleLinearRegression",
    data() {
        return {
            numPoints: 2,
            numFeatures: 1,
            dataPoints: [],
            coefficients: []
        };
    },
    created() {
        this.initializeData();
    },
    methods: {
        initializeData() {
            this.dataPoints = Array.from({ length: this.numPoints }, () => ({
                features: Array.from({ length: this.numFeatures }, () => 0),
                y: 0
            }));
        },
        randomizeDataPoints() {
            this.dataPoints = this.dataPoints.map(point => ({
                features: point.features.map(() => parseFloat((Math.random() * 10).toFixed(2))),
                y: parseFloat((Math.random() * 10).toFixed(2))
            }));
        },
        calculateMultipleLinearRegression() {
            try {
                const X = this.dataPoints.map(point => [1, ...point.features]);
                const Y = this.dataPoints.map(point => point.y);

                // Calculating (X^T * X)^-1 * X^T * Y
                const XT = math.transpose(X);
                const XTX = math.multiply(XT, X);
                if (math.det(XTX) === 0) {
                    throw new Error("Matrix is singular and cannot be inverted.");
                }
                const XTXInv = math.inv(XTX);
                const XTY = math.multiply(XT, Y);
                const coefficients = math.multiply(XTXInv, XTY);

                this.coefficients = coefficients;
            } catch (error) {
                console.error("Error calculating Multiple Linear Regression:", error);
                alert("An error occurred while calculating the coefficients. Please check your inputs. Matrix might be singular.");
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
