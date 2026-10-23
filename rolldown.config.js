import { defineConfig } from "rolldown";

export default defineConfig({
  input: "app/javascript/application.js",
  output: {
    dir: "app/assets/builds",
    entryFileNames: "[name].js",
    format: "esm",
    sourcemap: true,
  },
});
