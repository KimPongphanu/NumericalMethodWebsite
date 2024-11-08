<template>
    <div class="menuChapter" v-if="chaptersDB.length">
        <div v-for="(chapther, index) in chaptersDB" :key="index" class="menuChapter-child" @click="selection(index)">
            <h1>{{ chapther.chapter }}</h1>
        </div>
    </div>
</template>

<script>
import axios from 'axios';
export default {
    data() {
        return {
            chaptersDB: [],
            select : null,
            solution : 0,
        }
    },
    created() {
        axios.get('http://localhost:3000/api/chapters')
            .then(response => {
                this.chaptersDB = response.data;
            })
            .catch(error => {
                console.error('Error fetching chapters:', error);
            });
    },
    methods: {
        selection(index) {
            this.select = index;
            this.solution = null;
            this.$emit("chapter-selected", index);
            this.$emit("chapter-array",this.chaptersDB);
        },
    }
}
</script>