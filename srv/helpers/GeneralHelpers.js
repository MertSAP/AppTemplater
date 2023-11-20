module.exports = class GeneralHelpers {
  /*
    Inserts a Spkace everytime a lowercase letter is followed by an uppercase letter
  */
  getLabel (Label) {

    Label = this.capitalizeFirstLetter(Label)
    return Label.replace(/([a-z])([A-Z])/g, '$1 $2')
  }

  capitalizeFirstLetter(string) {
    if(string === null) {
      return "";
    }
    return string.charAt(0).toUpperCase() + string.slice(1);
  }
}
