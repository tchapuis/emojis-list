<template>
  <div>
    <form action="" @submit="submitForm">
      <div><input type="file" @change="updateImage"></div>
      <div>
        <label for="image-name">Image Name: </label>
        <input id="image-name" v-model="message" name="image-name" accept="image/*" type="text">
      </div>
      <button>SAVE</button>
    </form>
  </div>
</template>

<script>
export default {
  data () {
    return {
      message: '',
      files: []
    }
  },

  methods: {
    updateImage (files) {
      const target = files.currentTarget
      this.files = target.files
    },

    submitForm (e) {
      e.preventDefault()

      const formData = new FormData()
      formData.append('message', this.message)

      formData.append('file', this.files[0])

      this.$axios({
        method: 'POST',
        url: 'http://localhost:3000/api/v1/emojis',
        headers: {
          'content-type': 'multipart/form-data'
        },
        data: formData
      }).then((r) => {
        console.log(r)
      })

      console.log(this.message)
      console.log(this.files)
    }
  }
}
</script>
