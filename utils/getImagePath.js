const path = require('path')
const { nanoid } = require('nanoid')

module.exports.getImagePath = (imageName, file) => {
  const projectDir = process.cwd()
  const rName = nanoid()

  const name = imageName.length === 0 ? rName : imageName
  const publicDir = projectDir + '/public'
  const extname = path.extname(file.name)

  const now = new Date().getTime()
  const pathFile = '/emojis/' + name + '_' + now + extname
  const fullPath = publicDir + pathFile

  return {
    name,
    pathFile,
    fullPath
  }
}
