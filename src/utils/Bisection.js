import * as math from 'mathjs';

class BisectionMethod {
  constructor(func, lowerBound, upperBound, tolerance, maxIterations) {
    this.func = func;
    this.lowerBound = lowerBound;
    this.upperBound = upperBound;
    this.tolerance = tolerance;
    this.maxIterations = maxIterations;
  }

  solve() {
    let a = this.lowerBound;
    let b = this.upperBound;
    let tol = this.tolerance;
    let maxIter = this.maxIterations;
    let iterations = 0;

    if (math.evaluate(this.func, { x: a }) * math.evaluate(this.func, { x: b }) >= 0) {
      throw new Error("The function must have different signs at the bounds a and b.");
    }

    let c = a;
    while ((b - a) / 2 > tol && iterations < maxIter) {
      c = (a + b) / 2;
      let fc = math.evaluate(this.func, { x: c });

      if (fc === 0) {
        break; // เราพบรากที่แน่นอนแล้ว
      } else if (math.evaluate(this.func, { x: a }) * fc < 0) {
        b = c;
      } else {
        a = c;
      }

      iterations++;
    }

    let root = (a + b) / 2;
    let error = Math.abs(b - a) / 2;

    return {
      root: root,
      iterations: iterations,
      error: error,
    };
  }
}

export default BisectionMethod;
