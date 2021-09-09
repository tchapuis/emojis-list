const path = require('path')

const express = require('express')

const bodyParser = require('body-parser')
const fileUpload = require('express-fileupload')
const { nanoid } = require('nanoid')
const sharp = require('sharp')

const { PrismaClient } = require('@prisma/client')
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

app.post('/emojis', async (req, res) => {
  const projectDir = process.cwd()
  const rName = nanoid()

  const name = req.body.message.length === 0 ? rName : req.body.message

  const publicDir = projectDir + '/public'

  const extname = path.extname(req.files.file.name)

  const pathFile = '/emojis/' + name + extname
  const fullPath = publicDir + pathFile

  const format = await prisma.format.findMany({
    where: {
      mimetype: req.files.file.mimetype
    }
  })

  const result = await prisma.image.create({
    data: {
      id: 1,
      name,
      path: pathFile,
      size: req.files.file.size,
      format_id: format[0].id
    }
  })

  console.log(format)
  return res.json({ data: 'data' })

  await sharp(req.files.file.data)
    .resize(48, 48)
    .toFile(publicDir + '/' + name + extname, (err, info) => {
      console.log(info)
      console.log(err)
    })

  res.json({ data: 'data' })
})

export default app
