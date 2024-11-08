<template>
    <div class="container">
        <!-- Input Section -->
        <div id="box-1">
            <div id="box-left">
                <!-- Section Title -->
                <div id="box-11">
                    <h3>Spline Interpolation</h3>
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
                    <button @click="calculateSplineInterpolation">Calculate</button>
                </div>
                <!-- Output Section -->
                <div id="box-2" v-if="splines.length > 0">
                    <h4>Spline Interpolations:</h4>
                    <ul>
                        <li v-for="(spline, index) in splines" :key="'spline-' + index">
                            Spline {{ index + 1 }}: {{ spline }}
                        </li>
                    </ul>
                </div>
            </div>
        </div>
    </div>
</template>

<script>
export default {
    name: "SplineInterpolation",
    data() {
        return {
            numPoints: 2,
            dataPoints: [],
            splines: []
        };
    },
    created() {
        this.initializeData();
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
        calculateSplineInterpolation() {
            try {
                const n = this.numPoints;
                let splines = [];

                for (let i = 0; i < n - 1; i++) {
                    const x0 = this.dataPoints[i].x;
                    const y0 = this.dataPoints[i].y;
                    const x1 = this.dataPoints[i + 1].x;
                    const y1 = this.dataPoints[i + 1].y;

                    // Linear spline equation between two points
                    const slope = (y1 - y0) / (x1 - x0);
                    const spline = `y = ${slope.toFixed(6)} * (x - ${x0.toFixed(2)}) + ${y0.toFixed(6)}`;

                    splines.push(spline);
                }

                this.splines = splines;
            } catch (error) {
                console.error("Error calculating Spline Interpolation:", error);
                alert("An error occurred while calculating the splines. Please check your inputs.");
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
