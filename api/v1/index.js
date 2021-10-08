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

app.post('/emojis', async (req, res, next) => {
  const imagePath = getImagePath(req.body.message, req.files.file)
  let format

  try {
    format = await prisma.format.findUnique({
      where: {
        mimetype: req.files.file.mimetype
      },
      rejectOnNotFound: true
    })
  } catch (e) {
    return next(e)
  }

  const emoji = await prisma.emoji.create({
    data: {
      image: {
        create: {
          name: imagePath.name,
          path: imagePath.pathFile,
          size: req.files.file.size,
          format_id: format.id
        }
      }
    },
    include: {
      image: true
    }
  })

  await sharp(req.files.file.data)
    .resize(48, 48)
    .toFile(imagePath.fullPath, (err) => {
      if (err !== null) {
        console.log(err)
      }
    })

  await prisma.$disconnect()
  return res.json({ emoji })
})

export default app
