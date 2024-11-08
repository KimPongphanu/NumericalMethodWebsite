<template>
  <div class="container">
    <!-- Input Section -->
    <div id="box-1">
      <h3>False Position Method</h3>
      <div>
        <label>f(x):</label>
        <input v-model="functionInput" placeholder="Enter function" />
        <button @click="randomFunction" id="btn1">Random</button>
      </div>
      <div>
        <label>Lower Bound (a):</label>
        <input type="number" v-model.number="lowerBound" />
      </div>
      <div>
        <label>Upper Bound (b):</label>
        <input type="number" v-model.number="upperBound" />
      </div>
      <div>
        <label>Tolerance (ε):</label>
        <input type="number" v-model.number="tolerance" />
      </div>
      <button @click="calculateFalsePosition" id="btn2">Calculate</button>
    </div>

    <!-- Output Section -->
    <div id="box-2" v-if="iterations.length > 0">
      <h4>Iterations:</h4>
      <table border="1">
        <thead>
          <tr>
            <th>Iteration</th>
            <th>a</th>
            <th>b</th>
            <th>c</th>
            <th>f(c)</th>
          </tr>
        </thead>
        <tbody>
          <tr v-for="(iteration, index) in iterations" :key="index">
            <td>{{ index + 1 }}</td>
            <td>{{ iteration.a }}</td>
            <td>{{ iteration.b }}</td>
            <td>{{ iteration.c }}</td>
            <td>{{ iteration.fc }}</td>
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
  name: "FalsePositionMethod",
  data() {
    return {
      functionInput: "x^2 - 4",
      lowerBound: 0,
      upperBound: 3,
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
    calculateFalsePosition() {
      let a = this.lowerBound;
      let b = this.upperBound;
      const f = (x) => evaluate(this.functionInput, { x });
      let c;
      this.iterations = [];

      let iterationCount = 0;
      do {
        c = (a * f(b) - b * f(a)) / (f(b) - f(a));
        const fc = f(c);

        this.iterations.push({
          a: a.toFixed(6),
          b: b.toFixed(6),
          c: c.toFixed(6),
          fc: fc.toFixed(6),
        });

        if (f(a) * fc < 0) {
          b = c;
        } else {
          a = c;
        }

        iterationCount++;
        if (iterationCount > 1000) {
          console.warn("Reached maximum iteration limit");
          break;
        }
      } while (Math.abs(f(c)) > this.tolerance);

      this.result = c.toFixed(6);
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
