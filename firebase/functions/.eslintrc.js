module.exports = {
    root: true,
    parser: "babel-eslint",
    extends: ["eslint:recommended", "google"],
    env: {
        es6: true,
        node: true,
    },
    // prettier-ignore
    rules: {
        "indent": ["error", 4],
        "quotes": ["error", "double"],
        "max-len": ["error", {"ignoreStrings": true}],
    },
};
