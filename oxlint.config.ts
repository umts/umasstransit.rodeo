import { defineConfig } from "oxlint";

export default defineConfig({
  $schema: "./node_modules/oxlint/configuration_schema.json",
  ignorePatterns: ["app/javascript/controllers/index.js", "vendor/assets/**"],
  plugins: [
    "eslint",
    "unicorn",
    "oxc",
    // "import", TODO: Enable when migrated to ESM.
    "promise",
  ],
  categories: {
    correctness: "error",
    suspicious: "warn",
    pedantic: "warn",
    perf: "error",
    restriction: "error",
  },
  rules: {
    "eslint/class-methods-use-this": "off",
    "eslint/no-alert": "off",
    "import/no-default-export": "off",
    "import/no-unassigned-import": "off",
    "unicorn/no-anonymous-default-export": "off",
    "unicorn/no-array-reduce": "off",
  },
});
