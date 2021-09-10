<template>
  <div class="emoji bg-light m-2 p-2 cursor-pointer rounded d-flex flex-column justify-content-center align-items-center" @click="clipboard(image.path)">
    <div>
      <img :src="image.path" :alt="image.name">
    </div>
    <div class="mt-2 emoji-name">
      {{ image.name }}
    </div>
  </div>
</template>

<script>
export default {

  props: {
    id: {
      type: Number,
      default: 0
    },
    createdAt: {
      type: String,
      default: ''
    },
    updateAt: {
      type: String,
      default: ''
    },
    image: {
      type: Object,
      default () {
        return {
          id: {
            type: Number,
            default: 0
          },
          name: {
            type: String,
            default: ''
          },
          path: {
            type: String,
            default: ''
          },
          size: {
            type: Number,
            default: 0
          }
        }
      }
    }
  },
  methods: {
    clipboard (i) {
      const publicFile = `${process.env.baseUrl}${i}`
      navigator.clipboard.writeText(publicFile)
    }
  }
}
</script>

<style>
.emoji {
  width: 72px;
  height: 72px;
}
.emoji-name {
  font-size: 1rem;
}
</style>
