module.exports = {
  ignoreFiles: [
    'app/assets/builds/*',
    'archive/assets/*',
    'coverage/**/*',
    'node_modules/**/*',
  ],
  extends: 'stylelint-config-standard',
  overrides: [{
    files: ['**/*.scss'],
    extends: 'stylelint-config-standard-scss',
  }],
};
