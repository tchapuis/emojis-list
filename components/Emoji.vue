<template>
  <div class="emoji" @click="clipboard(image.path)">
    <div>
      <img :src="image.path" :alt="image.name" class="h-10 w-10">
    </div>
    <div class="mt-2">
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
    @apply w-24 bg-gray-50 border-2 border-transparent p-2 cursor-pointer flex flex-col justify-center items-center transition transform
  }
  .emoji:hover {
    @apply scale-105 shadow border-primary-light
  }
</style>
