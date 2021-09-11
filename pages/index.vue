<template>
  <div>
    <div class="p-2 mb-5 bg-warning">
      <div class="p-2">
        UPLOAD EMOJI
      </div>
      <form action="" @submit="submitForm">
        <div><input type="file" @change="updateImage"></div>
        <div>
          <label for="image-name">Image Name: </label>
          <input id="image-name" v-model="message" name="image-name" accept="image/*" type="text">
        </div>
        <button>SAVE</button>
      </form>
    </div>

    <div class="p-2 mb-5 bg-primary">
      <div class="p-2">
        SEARCH
      </div>
      <div>
        <label for="search">Search</label>
        <input id="search" v-model="emojiText" name="search" type="text" @input="search">
      </div>
    </div>

    <div class="p-2 mb-5 bg-danger">
      <div class="p-2">
        EMOJIS
      </div>
      <div class="d-flex flex-wrap">
        <div v-for="emoji of emojis" :key="emoji.id">
          <Emoji v-bind="{...emoji}" />
        </div>
      </div>
    </div>
  </div>
</template>

<script>
import Emoji from '../components/Emoji'
export default {
  components: { Emoji },
  data () {
    return {
      message: '',
      emojiText: '',
      emojis: [],
      timeOut: null
    }
  },

  fetch () {
    this.getAllEmojis()
  },

  methods: {
    getAllEmojis () {
      this.$axios({
        method: 'GET',
        url: '/emojis'
      }).then((r) => {
        this.emojis = r.data
      })
    },

    updateImage (files) {
      const target = files.currentTarget
      this.files = target.files
    },

    search (e) {
      console.log('write')
      const target = e.target.value.length
      clearTimeout(this.timeOut)
      this.timeOut = setTimeout(() => {
        console.log('fetch')
        if (target !== 0) {
          this.$axios({
            method: 'GET',
            url: `/emojis?q=${this.emojiText}`
          }).then((r) => {
            this.emojis = r.data
          })
        } else {
          this.getAllEmojis()
        }
      }, 500)
    },

    submitForm (e) {
      e.preventDefault()

      const formData = new FormData()
      formData.append('message', this.message)

      formData.append('file', this.files[0])

      this.$axios({
        method: 'POST',
        url: '/emojis',
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
  },
  fetchOnServer: false
}
</script>
