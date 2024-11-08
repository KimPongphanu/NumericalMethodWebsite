<template>

  <div class="container">

    <div>
      <section class="box1" style="display: flex">
        <h1>NUMERICAL METHOD</h1>
        <h1 v-if="chaptersArray.length > 0"> >> {{ chaptersArray.chapter }}</h1>
      </section>
    </div>

    <div>

      <section>

        <!-- <div class="menuChapter" v-if="chaptersDB.length">
          <div v-for="(chapther, index) in chaptersDB" :key="index" class="menuChapter-child" @click="selection(index)">
            <h1>{{ chapther.chapter }}</h1>
          </div>
        </div> -->
        <div v-if="isDropdownOpen">
          <navChapter @chapter-selected="handleChapterSelected" @chapter-array="handleChapterArray" />
        </div>

      </section>

    </div>

    <div class="boxChapter">
      <section>

        <div class="dropDown" v-if="isDropdownOpen">
          <div class="dropDownChild" v-for="(item, index) in chapterLists[selectedChapterIndex]" :key="index"
            :style="getItemStyle(chapterLists[selectedChapterIndex].length)" @click="ClickedDropdownMenu(index)"
            :class="{ selected: CurrentdropdownMenu === index }">
            <h1>{{ item.method }}</h1>
          </div>
        </div>


        <div class="mainContent">
          <section>
            <!-- <h1
              v-if="chapterLists && chapterLists[selectedChapterIndex] && chapterLists[selectedChapterIndex][CurrentdropdownMenu]">
              {{ chapterLists[selectedChapterIndex][CurrentdropdownMenu].method }}
            </h1> -->
            <div class="childContent">

              <div id="mainMethod">
                <div v-if="chapterLists[selectedChapterIndex][CurrentdropdownMenu] === methodC1[0]">
                  <BisectionMethod />
                </div>
                <div v-else-if="chapterLists[selectedChapterIndex][CurrentdropdownMenu] === methodC1[1]">
                  <FalsePositionMethod />
                </div>
                <div v-else-if="chapterLists[selectedChapterIndex][CurrentdropdownMenu] === methodC1[2]">
                  <OnePointIterationMethod />
                </div>
                <div v-else-if="chapterLists[selectedChapterIndex][CurrentdropdownMenu] === methodC1[3]">
                  <SecantMethod />
                </div>
                <div v-else-if="chapterLists[selectedChapterIndex][CurrentdropdownMenu] === methodC1[4]">
                  <NewtonRaphson />
                </div>
                <div v-else-if="chapterLists[selectedChapterIndex][CurrentdropdownMenu] === methodC2[0]">
                  <CramersRule />
                </div>
                <div v-else-if="chapterLists[selectedChapterIndex][CurrentdropdownMenu] === methodC2[1]">
                  <GaussElimination />
                </div>
                <div v-else-if="chapterLists[selectedChapterIndex][CurrentdropdownMenu] === methodC2[2]">
                  <GaussJordanMethod />
                </div>
                <div v-else-if="chapterLists[selectedChapterIndex][CurrentdropdownMenu] === methodC2[3]">
                  <InverseMatrixMethod />
                </div>
                <div v-else-if="chapterLists[selectedChapterIndex][CurrentdropdownMenu] === methodC2[4]">
                  <LuDecompositionMethod />
                </div>
                <div v-else-if="chapterLists[selectedChapterIndex][CurrentdropdownMenu] === methodC2[5]">
                  <CholeskyDecompositionMethod />
                </div>
                <div v-else-if="chapterLists[selectedChapterIndex][CurrentdropdownMenu] === methodC2[6]">
                  <JacobiIterationMethod />
                </div>
                <div v-else-if="chapterLists[selectedChapterIndex][CurrentdropdownMenu] === methodC2[7]">
                  <GaussSeidelIterationMethod />
                </div>
                <div v-else-if="chapterLists[selectedChapterIndex][CurrentdropdownMenu] === methodC2[8]">
                  <ConjugateGradientMethod />
                </div>
                <div v-else-if="chapterLists[selectedChapterIndex][CurrentdropdownMenu] === methodC3[0]">
                  <NewtonsDividedDifferences />
                </div>
                <div v-else-if="chapterLists[selectedChapterIndex][CurrentdropdownMenu] === methodC3[1]">
                  <LagrangePolynomials />
                </div>
                <div v-else-if="chapterLists[selectedChapterIndex][CurrentdropdownMenu] === methodC3[2]">
                  <SplineInterpolation />
                </div>
                <div v-else-if="chapterLists[selectedChapterIndex][CurrentdropdownMenu] === methodC4[0]">
                  <LinearRegression />
                </div>
                <div v-else-if="chapterLists[selectedChapterIndex][CurrentdropdownMenu] === methodC4[1]">
                  <PolynomialRegression />
                </div>
                <div v-else-if="chapterLists[selectedChapterIndex][CurrentdropdownMenu] === methodC4[2]">
                  <MultipleLinearRegression />
                </div>
                <div v-else-if="chapterLists[selectedChapterIndex][CurrentdropdownMenu] === methodC5[0]">
                  <TrapezoidalRule />
                </div>
                <div v-else-if="chapterLists[selectedChapterIndex][CurrentdropdownMenu] === methodC5[1]">
                  <CompositeTrapezoidalRule />
                </div>
                <div v-else-if="chapterLists[selectedChapterIndex][CurrentdropdownMenu] === methodC5[2]">
                  <SimpsonRule />
                </div>
                <div v-else-if="chapterLists[selectedChapterIndex][CurrentdropdownMenu] === methodC5[3]">
                  <CompositeSimpsonRule />
                </div>
              </div>

            </div>
          </section>

        </div>
      </section>
    </div>



  </div>

</template>

<script>
import navChapter from "./components/navChapter.vue";
import BisectionMethod from './components/Chapter1-main/BisectionMethod.vue';
import FalsePositionMethod from './components/Chapter1-main/FalsePositionMethod.vue';
import OnePointIterationMethod from './components/Chapter1-main/OnePointIteration.vue';
import SecantMethod from './components/Chapter1-main/SecantMethod.vue';
import NewtonRaphson from './components/Chapter1-main/NewtonRaphson.vue';
import CramersRule from './components/Chapter2-main/CramersRule.vue';
import GaussElimination from './components/Chapter2-main/GaussElimination.vue';
import GaussJordanMethod from './components/Chapter2-main/GaussJordanMethod.vue';
import InverseMatrixMethod from './components/Chapter2-main/InverseMatrixMethod.vue';
import LuDecompositionMethod from './components/Chapter2-main/LuDecompositionMethod.vue';
import CholeskyDecompositionMethod from './components/Chapter2-main/CholeskyDecompositionMethod.vue';
import JacobiIterationMethod from './components/Chapter2-main/JacobiIterationMethod.vue';
import GaussSeidelIterationMethod from './components/Chapter2-main/GaussSeidelIterationMethod.vue';
import ConjugateGradientMethod from './components/Chapter2-main/ConjugateGradientMethod.vue';
import NewtonsDividedDifferences from './components/Chapter3-main/NewtonsDividedDifferences.vue';
import LagrangePolynomials from './components/Chapter3-main/LagrangePolynomials.vue';
import SplineInterpolation from './components/Chapter3-main/SplineInterpolation.vue';
import LinearRegression from './components/Chapter4-main/LinearRegression.vue';
import PolynomialRegression from './components/Chapter4-main/PolynomialRegression.vue';
import MultipleLinearRegression from './components/Chapter4-main/MultipleLinearRegression.vue';
import TrapezoidalRule from './components/Chapter5-main/TrapezoidalRule.vue';
import CompositeTrapezoidalRule from './components/Chapter5-main/CompositeTrapezoidalRule.vue';
import SimpsonRule from './components/Chapter5-main/SimpsonRule.vue';
import CompositeSimpsonRule from './components/Chapter5-main/CompositeSimpsonRule.vue';





import axios from 'axios';

export default {
  name: 'App',
  components: {
    navChapter,
    BisectionMethod,
    FalsePositionMethod,
    OnePointIterationMethod,
    SecantMethod,
    NewtonRaphson,
    CramersRule,
    GaussElimination,
    GaussJordanMethod,
    InverseMatrixMethod,
    LuDecompositionMethod,
    CholeskyDecompositionMethod,
    JacobiIterationMethod,
    GaussSeidelIterationMethod,
    ConjugateGradientMethod,
    NewtonsDividedDifferences,
    LagrangePolynomials,
    SplineInterpolation,
    LinearRegression,
    PolynomialRegression,
    MultipleLinearRegression,
    TrapezoidalRule,
    CompositeTrapezoidalRule,
    SimpsonRule,
    CompositeSimpsonRule,
  },
  data() {
    return {
      isDropdownOpen: true,
      CurrentdropdownMenu: 0,
      chapterLists: [],
      methodC1: [],
      methodC2: [],
      methodC3: [],
      methodC4: [],
      methodC5: [],
      //bisection method
      selectedChapterIndex: 0,
      solution: null,
      variableCount: 2,
      chaptersArray: [],
    }
  },
  created() {
    this.chapterLists = [
      this.methodC1,
      this.methodC2,
      this.methodC3,
      this.methodC4,
      this.methodC5
    ];
    axios.get('http://localhost:3000/api/methods')
      .then(response => {
        if (response && response.data) {
          // วนลูปข้อมูลแต่ละแถวใน response.data
          response.data.forEach(item => {
            switch (item.chapter) {
              case 1:
                this.methodC1.push(item);
                // console.log(item);
                break;
              case 2:
                this.methodC2.push(item);
                // console.log(item);
                break;
              case 3:
                this.methodC3.push(item);
                // console.log(item);
                break;
              case 4:
                this.methodC4.push(item);
                // console.log(item);
                break;
              case 5:
                this.methodC5.push(item);
                // console.log(item);
                break;
              default:
                console.warn('Chapter not found in response data:', item.chapter);
                break;
            }
          });
        } else {
          console.warn('Invalid response data:', response.data);
        }
      })
      .catch(error => {
        console.error('Error fetching methods:', error);
      });
  },
  methods: {
    handleChapterSelected(index) {
      this.selectedChapterIndex = index; // เก็บค่า index ที่ได้รับจาก navChapter
    },
    handleChapterArray(array) {
      this.chaptersArray = array;
    },
    dropdown() {
      this.isDropdownOpen = !this.isDropdownOpen;
    },
    ClickedDropdownMenu(index) {
      this.CurrentdropdownMenu = index;
      this.solution = null;
    },
    getItemStyle(contentCount) {
      const containerWidth = 1330; // ความกว้างของ dropdown ทั้งหมด
      const widthPerItem = containerWidth / contentCount; // คำนวณความกว้างต่อคอนเทนต์
      return {
        width: `${widthPerItem}px`, // ส่งกลับค่า style ให้กับแต่ละคอนเทนต์
      };
    },
  },

};

</script>




<style>
@font-face {
  font-family: 'Jersey 25';
  src: url('@/assets/fonts/Jersey25-Regular.ttf') format('truetype');
}

#mainMethod {
  position: relative;
  top: 20px;
  width: 1300px;
  height: 480px;
  border-radius: 10px;
  /* background-color: #E9EED9; */
}

body {
  display: flex;
  font-family: sans-serif, Arial;
  max-width: 1366px;
  max-height: 708px;
  width: 1366px;
  height: 708px;
  padding: 0;
  margin-top: -10px;
  background-color: #06113C;
  overflow-x: hidden;
  overflow-y: hidden;
}

.container {
  width: 100vw;
  height: 100vh;
  position: relative;
  display: flex;
  flex-direction: column;
  justify-content: center;
  margin: 0 auto;
  align-items: center;
  box-sizing: border-box;
  overflow: hidden;
}


#app {

  font-family: Avenir, Helvetica, Arial, sans-serif;
  -webkit-font-smoothing: antialiased;
  -moz-osx-font-smoothing: grayscale;
  text-align: center;
  color: #2c3e50;

}

.box1 {
  display: flex;
  width: 1366px;
  height: 80px;
  background-color: #FF8C32;

}

.box1 h1 {
  position: relative;
  top: 20px;
  left: 30px;
  font-size: 48;
  color: white;
}

.menuChapter {
  display: inline-flex;
  flex-direction: row;
  background-color: #FFFFFF;

}

.menuChapter-child {
  display: flex;
  align-items: center;
  justify-content: center;
  /* width: 241.3333px; */
  width: 273.2px;
  height: 60px;
  font-size: 14px;
  font-family: monospace;
  cursor: pointer;
}

.menuChapter-child:nth-child(even) {
  background-color: #DDDDDD;
}

.menuChapter-child:nth-child(odd) {
  background-color: #FFFFFF;
}

.menuChapter:hover>:not(:hover) {
  filter: blur(5px);
  opacity: 0.5;
}

.boxChapter {
  display: flex;
  width: 1360px;
  height: 600px;
  /* background-color: #948979; */
  background-color: #EEEDEB;
  overflow: hidden;

}

.dropDown {
  margin-top: 30px;
  width: 1360px;
  height: 36px;
  display: flex;
  flex-direction: row;
  justify-content: center;
  align-items: center;

}

.dropDownChild {
  display: flex;
  align-items: center;
  justify-content: center;
  font-size: 10px;
  font-family: monospace;
  height: 50px;
  overflow: hidden;
  margin: 2px;
  background-color: #06113C;
  color: #FFFFFF;
  cursor: pointer;
}

.dropDownChild:hover {
  background-color: #B0B1B2;
  /* เปลี่ยนสีเมื่อ hover เพื่อแสดงการตอบสนองของเมนู */
}

.mainContent {
  width: 1360px;
  /* width: 90vw; */
  height: 480px;
}

.childContent {
  position: relative;
  align-items: center;
  justify-content: center;
  display: flex;
  flex-direction: row;
  gap: 5px;
}

.childContent>div {
  margin: 0;
}

#div-1 {
  width: 400px;
  height: 400px;
  background-color: #ffffffc4;
  border-radius: 10px;
}

.selected {
  background-color: rgb(255, 0, 0);
}
</style>
