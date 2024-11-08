<template>
  <div class="container">
    <!-- Input Section -->
    <div id="box-1">
      <h3>Secant Method</h3>
      <div>
        <label>f(x):</label>
        <input v-model="functionInput" placeholder="Enter function" />
        <button @click="randomFunction" id="btn1">Random</button>
      </div>
      <div>
        <label>Initial Guess 1 (x0):</label>
        <input type="number" v-model.number="x0" />
      </div>
      <div>
        <label>Initial Guess 2 (x1):</label>
        <input type="number" v-model.number="x1" />
      </div>
      <div>
        <label>Tolerance (ε):</label>
        <input type="number" v-model.number="tolerance" />
      </div>
      <button @click="calculateSecant" id="btn2">Calculate</button>
    </div>

    <!-- Output Section -->
    <div id="box-2" v-if="iterations.length > 0">
      <h4>Iterations:</h4>
      <table border="1">
        <thead>
          <tr>
            <th>Iteration</th>
            <th>x0</th>
            <th>x1</th>
            <th>x2</th>
            <th>f(x2)</th>
          </tr>
        </thead>
        <tbody>
          <tr v-for="(iteration, index) in iterations" :key="index">
            <td>{{ index + 1 }}</td>
            <td>{{ iteration.x0 }}</td>
            <td>{{ iteration.x1 }}</td>
            <td>{{ iteration.x2 }}</td>
            <td>{{ iteration.fx2 }}</td>
          </tr>
        </tbody>
      </table>
      <div v-if="result !== null">
        <h4>Final Result:</h4>
        <p>Root: {{ result }}</p>
      </div>
    </div>
  </div>
</template>

<script>
import { evaluate } from "mathjs";

export default {
  name: "SecantMethod",
  data() {
    return {
      functionInput: "x^2 - 4",
      x0: 0,
      x1: 3,
      tolerance: 0.001,
      result: null,
      iterations: [],
      randomFunctions: [
        "x^3 - 2*x - 5",
        "x^2 - 4",
        "sin(x) - 0.5",
        "x^3 - 4*x + 1",
        "cos(x) - x",
        "log(x) - 1",
        "x^3 - 6*x^2 + 11*x - 6",
        "tan(x) - x"
      ],
    };
  },
  methods: {
    randomFunction() {
      const randomIndex = Math.floor(Math.random() * this.randomFunctions.length);
      this.functionInput = this.randomFunctions[randomIndex];
    },
    calculateSecant() {
      let x0 = this.x0;
      let x1 = this.x1;
      const f = (x) => evaluate(this.functionInput, { x });
      this.iterations = [];
      let x2;
      let iterationCount = 0;
      const maxIterations = 1000;

      do {
        x2 = x1 - (f(x1) * (x1 - x0)) / (f(x1) - f(x0));
        const fx2 = f(x2);

        this.iterations.push({
          x0: x0.toFixed(6),
          x1: x1.toFixed(6),
          x2: x2.toFixed(6),
          fx2: fx2.toFixed(6),
        });

        if (Math.abs(x2 - x1) < this.tolerance) {
          break;
        }

        x0 = x1;
        x1 = x2;
        iterationCount++;

        if (iterationCount >= maxIterations) {
          console.warn("Reached maximum iteration limit");
          break;
        }
      } while (Math.abs(x2 - x1) >= this.tolerance);

      this.result = x2.toFixed(6);
    },
  },
};
</script>

<style scoped>
body {
  font-family: cursive;
  display: flex;
  flex-direction: row;
  align-items: center;
}

input {
  width: 300px;
  height: 30px;
}

label {
  font-size: 15px;
  font-weight: 580;
}

table {
  width: 100%;
  border-collapse: collapse;
  margin-top: 20px;
}

.container {
  width: 1300px;
  height: 500px;
  display: flex;
  flex-direction: row;
  gap: 10px;
}

table th,
table td {
  padding: 10px;
  text-align: center;
}

#box-1 {
  width: 400px;
  height: 450px;
  background-color: #F8FAE5;
  display: flex;
  flex-direction: column;
  align-items: center;
  gap: 10px;
  border-radius: 10px;
}

#box-1 > div {
  display: flex;
  flex-direction: column;
}

#box-2 {
  width: 600px;
  height: 450px;
  background-color: #F8FAE5;
  overflow-y: auto;
  border-radius: 10px;
}

#btn1 {
  background-color: #124076;
  color: #FFFFFF;
  position: relative;
  top: 10px;
  left: 225px;
  border-radius: 5px;
  font-size: 12px;
  width: 80px;
  height: 30px;
}

#btn2 {
  position: relative;
  top: 15px;
  background-color: #7F9F80;
  border-radius: 5px;
  font-size: 16px;
  width: 120px;
  height: 40px;
  font-weight: 620;
  border: none;
  color: #FFFFFF;
}

#btn1:hover, #btn2:hover {
  background-color: red;
  transition: 0.2s ease-in;
  border: none;
}
</style>
