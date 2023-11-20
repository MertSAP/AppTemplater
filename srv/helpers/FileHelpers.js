const fs = require('fs')
const util = require('util')
const readdir = util.promisify(fs.readdir)
const path = require('path')
const templateFolder = 'templateFiles'

module.exports = class FileHelpers {

  /*
    Retrives the contents of a file
  */
  readContents (file) {
    const directoryPath = path.join(__dirname, '..', '..', templateFolder, file)
    const fileContents = fs.readFileSync(directoryPath, 'utf8')
    const fileContentsJSON = JSON.parse(fileContents)
    return fileContentsJSON
  }

  /*
    Retrives a list of files in the template folder
  */
  async getFileList () {
    const directoryPath = path.join(__dirname, '..', '..', templateFolder)
    let names
    try {
      names = await readdir(directoryPath)
    } catch (err) {}
    if (names === undefined) {
      return {}
    } else {
      return names
    }
  }

  /*
    Writes a files to the template folder
  */
  outputFile (fileName, contents) {
    const reqPath = path.join(__dirname, '..', '..', templateFolder, fileName)

    fs.writeFile(reqPath, JSON.stringify(contents, null, 4), function (err) {
      if (err) {
        return false
      }
      return true
    })
  }
}
