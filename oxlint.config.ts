import {defineConfig} from "oxlint";

export default defineConfig({
  $schema: "./node_modules/oxlint/configuration_schema.json",
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
  },
});
