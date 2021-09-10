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

prisma.format.createMany({
  data: formats
}).then((r) => {
  console.log(r)
}).catch((r) => {
  console.log(r)
})
