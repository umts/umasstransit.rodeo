const js = require('@eslint/js');
const googleConfig = require('eslint-config-google');
const globals = require('globals');

module.exports = [
  {
    ignores: [
      'app/assets/builds/*',
      'coverage/*',
      'node_modules/*',
    ],
  },
  {
    files: ['**/*.js'],
    ...js.configs.recommended,
    ...googleConfig,
    rules: {
      ...js.configs.recommended.rules,
      ...googleConfig.rules,
      'max-len': ['error', {code: 120}],
      'valid-jsdoc': 'off',
      'require-jsdoc': 'off',
    },
  },
  {
    files: ['app/javascript/**/*.js'],
    languageOptions: {
      globals: {...globals.browser},
    },
  },
  {
    files: ['*.config.js'],
    languageOptions: {
      globals: {...globals.node},
    },
  },
];
