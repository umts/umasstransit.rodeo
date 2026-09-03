export default {
  ignoreFiles: [
    "app/assets/builds/**/*",
    "archive/assets/**/*",
    "coverage/**/*",
    "node_modules/**/*",
    "public/assets/**/*",
  ],
  extends: "stylelint-config-standard",
  overrides: [
    {
      files: ["**/*.scss"],
      extends: "stylelint-config-standard-scss",
    },
  ],
};
