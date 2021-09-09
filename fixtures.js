const { PrismaClient } = require('@prisma/client')
const prisma = new PrismaClient()

const formats = [
  {
    id: 1,
    mimetype: 'image/jpeg'
  },
  {
    id: 2,
    mimetype: 'image/gif'
  },
  {
    id: 3,
    mimetype: 'image/png'
  },
  {
    id: 4,
    mimetype: 'image/webp'
  }
]

formats.forEach((format) => {
  prisma.format.create({
    data: {
      id: format.id,
      mimetype: format.mimetype
    }
  }).then((r) => {
    console.log(r)
  }).catch((r) => {
    console.log(r)
  })
})
