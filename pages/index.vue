<template>
  <div class="container mx-auto px-2 py-5">
    <h1 class="text-center text-6xl mb-6 text-primary-light">
      Emoji list
    </h1>
    <div class="mb-5 bg-gray-50 border-2 border-gray-300 p-6">
      <h2 class="text-center mb-4 text-xl">
        Add a new emoji
      </h2>
      <form class="text-center space-y-6" @submit="submitForm">
        <div class="flex items-center justify-center w-full">
          <label class="flex flex-col p-4 border-4 border-primary-light border-dashed cursor-pointer transition hover:bg-gray-100 hover:border-primary">
            <span v-if="!previewUrl" class="flex flex-col items-center justify-center">
              <svg
                xmlns="http://www.w3.org/2000/svg"
                class="w-12 h-12 text-primary-light group-hover:text-primary"
                viewBox="0 0 20 20"
                fill="currentColor"
              >
                <path
                  fill-rule="evenodd"
                  d="M4 3a2 2 0 00-2 2v10a2 2 0 002 2h12a2 2 0 002-2V5a2 2 0 00-2-2H4zm12 12H4l4-8 3 6 2-4 3 6z"
                  clip-rule="evenodd"
                />
              </svg>
              <span class="pt-1 text-sm tracking-wider text-primary-light group-hover:text-primary">
                Select a photo</span>
            </span>
            <input type="file" class="opacity-0 hidden" @change="updateImage">
            <img v-if="previewUrl" :src="previewUrl" class="h-20 w-20" alt="preview">
          </label>
        </div>
        <div class="flex justify-center">
          <label for="image-name" class="sr-only">Image Name: </label>
          <input
            id="image-name"
            v-model="message"
            name="image-name"
            type="text"
            placeholder="Image name"
          >
        </div>
        <button class="btn-grad">
          SAVE
        </button>
      </form>
    </div>

    <div class="mb-5">
      <label for="search" class="sr-only">Search</label>
      <input
        id="search"
        v-model="emojiText"
        name="search"
        type="text"
        placeholder="Search"
        class="w-full"
        required
        @input="search"
      >
    </div>

    <div class="mb-5 bg-danger">
      <div class="flex flex-wrap gap-3 justify-center">
        <Emoji v-for="emoji of emojis" :key="emoji.id" v-bind="{...emoji}" />
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
      timeOut: null,
      previewUrl: null
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
      if (target.files.length !== 0) {
        this.previewUrl = URL.createObjectURL(target.files[0])
      }
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
        this.emojis.push(r.data.emoji)
      })
    }
  },
  fetchOnServer: false
}
</script>
