// Using Node.js style import
const Module = require('./mimalloc_wasm');

// Using ES6 style import
import Module from './mimalloc_wasm';

Module.onRuntimeInitialized = function() {
    // Call an exported function
    var result = Module._malloc(10);
    console.log(result);
}