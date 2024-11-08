<template>
  <div class="container">
    <!-- Input Section -->
    <div id="box-1">
      <h3>Newton-Raphson Method</h3>
      <div>
        <label>f(x):</label>
        <input v-model="functionInput" placeholder="Enter function" />
        <button @click="randomFunction" id="btn1">Random</button>
      </div>
      <div>
        <label>f'(x):</label>
        <input v-model="derivativeInput" placeholder="Enter derivative" />
      </div>
      <div>
        <label>Initial Guess (x0):</label>
        <input type="number" v-model.number="initialGuess" />
      </div>
      <div>
        <label>Tolerance (ε):</label>
        <input type="number" v-model.number="tolerance" />
      </div>
      <button @click="calculateNewtonRaphson" id="btn2">Calculate</button>
    </div>

    <!-- Output Section -->
    <div id="box-2" v-if="iterations.length > 0">
      <h4>Iterations:</h4>
      <table border="1">
        <thead>
          <tr>
            <th>Iteration</th>
            <th>x</th>
            <th>f(x)</th>
            <th>f'(x)</th>
          </tr>
        </thead>
        <tbody>
          <tr v-for="(iteration, index) in iterations" :key="index">
            <td>{{ index + 1 }}</td>
            <td>{{ iteration.x }}</td>
            <td>{{ iteration.fx }}</td>
            <td>{{ iteration.fpx }}</td>
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
  name: "NewtonRaphson",
  data() {
    return {
      functionInput: "x^2 - 4",
      derivativeInput: "2 * x",
      initialGuess: 1,
      tolerance: 0.001,
      result: null,
      iterations: [],
      randomFunctions: [
        { f: "x^3 - 2*x - 5", fp: "3*x^2 - 2" },
        { f: "x^2 - 4", fp: "2 * x" },
        { f: "sin(x) - 0.5", fp: "cos(x)" },
        { f: "x^3 - 4*x + 1", fp: "3*x^2 - 4" },
        { f: "cos(x) - x", fp: "-sin(x) - 1" }
      ],
    };
  },
  methods: {
    randomFunction() {
      const randomIndex = Math.floor(Math.random() * this.randomFunctions.length);
      this.functionInput = this.randomFunctions[randomIndex].f;
      this.derivativeInput = this.randomFunctions[randomIndex].fp;
    },
    calculateNewtonRaphson() {
      let x0 = this.initialGuess;
      const f = (x) => evaluate(this.functionInput, { x });
      const fPrime = (x) => evaluate(this.derivativeInput, { x });
      this.iterations = [];

      let iterationCount = 0;
      const maxIterations = 1000;

      let x1;
      do {
        const fx = f(x0);
        const fpx = fPrime(x0);

        if (fpx === 0) {
          console.warn("Derivative is zero. Stopping iteration to avoid division by zero.");
          break;
        }

        x1 = x0 - fx / fpx;

        this.iterations.push({
          x: x0.toFixed(6),
          fx: fx.toFixed(6),
          fpx: fpx.toFixed(6),
        });

        if (Math.abs(x1 - x0) < this.tolerance) {
          break;
        }

        x0 = x1;
        iterationCount++;

        if (iterationCount >= maxIterations) {
          console.warn("Reached maximum iteration limit");
          break;
        }
      } while (Math.abs(f(x1)) >= this.tolerance);

      this.result = x1.toFixed(6);
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
