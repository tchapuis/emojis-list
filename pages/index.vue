<template>
  <div>
    <form @submit="submitForm" action="">
      <div><input required @change="updateImage" type="file"></div>
      <div>
        <label for="image-name">Image Name: </label>
        <input id="image-name" name="image-name" v-model="message" type="text">
      </div>
      <button>SAVE</button>
    </form>
  </div>
</template>

<script lang="ts">
  import Vue from 'vue'
  export default Vue.extend({
    data() {
      return {
        message: '',
        files: [],
      }
    },

    methods: {
      updateImage(files: Event) {
        const target = files.currentTarget as HTMLInputElement;
        this.files = target.files
        // const file: File = target.files.item(0) as File;
        // if (target.files) this.files = file
      },

      submitForm(e: Event) {
        e.preventDefault()
        console.log(e)
      }
    }
  })
</script>
