// https://eslint.org/docs/user-guide/configuring

module.exports = {
  root: true,
  parser: 'babel-eslint',
  parserOptions: {
    sourceType: 'module'
  },
  env: {
    browser: true,
  },
  extends: [
    // these disable eslint formatting rules that conflict with prettier
    'prettier',
    'prettier/vue'
  ],
  plugins: ['prettier'],
  // required to lint *.vue files
  plugins: [
    'html'
  ],
  // add your custom rules here
  'rules': {
    // allow paren-less arrow functions
    'arrow-parens': 0,
    // allow async-await
    'generator-star-spacing': 0,
    // allow debugger during development
    'no-debugger': process.env.NODE_ENV === 'production' ? 2 : 0,
    'semi': [2, "always"],
    'no-tabs': 0,
    'indent': 0,
    'eol-last': 0,
    'no-new': 0,
    'no-multiple-empty-lines': 0,
    'template-curly-spacing': [1, 'always']
  }
}
