const express = require('express')
const bodyParser = require('body-parser')
const fileUpload = require('express-fileupload')
const sharp = require('sharp')
const { PrismaClient } = require('@prisma/client')
const { getImagePath } = require('../../utils/getImagePath')

const prisma = new PrismaClient()

const app = express()

app.use(bodyParser.json())
app.use(bodyParser.urlencoded({ extended: true }))

app.use(fileUpload({
  createParentPath: true,
  limits: {
    fileSize: 10 * 1024 * 1024
  }
}))

app.get('/emojis', async (req, res) => {
  const query = req.query.q ?? ''

  const data = await prisma.emoji.findMany({
    where: {
      image: {
        name: {
          contains: query
        }
      }
    },
    include: {
      image: true
    }
  })

  return res.json(data)
})

app.post('/emojis', async (req, res) => {
  const imagePath = getImagePath(req.body.message, req.files.file)

  const format = await prisma.format.findMany({
    where: {
      mimetype: req.files.file.mimetype
    }
  })

  console.log(format)

  const image = await prisma.image.create({
    data: {
      name: imagePath.name,
      path: imagePath.pathFile,
      size: req.files.file.size,
      format_id: format[0].id
    }
  })

  await prisma.emoji.create({
    data: {
      image_id: image.id
    }
  })

  await sharp(req.files.file.data)
    .resize(48, 48)
    .toFile(imagePath.fullPath, (err, info) => {
      console.log(info)
      console.log(err)
    })

  return res.json({ data: 'data' })
})

export default app
