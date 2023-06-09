import { compileToJs } from './compiler.js'
import { run } from './interpreter.js'
import { parse } from './parser.js'
export const logError = (error) => console.log('\x1b[31m', error, '\x1b[0m')
export const logSuccess = (output) => console.log(output, '\x1b[0m')
export const removeNoCode = (source) =>
  source
    .replace(/;.+/g, '')
    .replace(/[\s\s]+(?=[^"]*(?:"[^"]*"[^"]*)*$)/g, ' ')
    .trim()
export const isBalancedParenthesis = (sourceCode) => {
  let count = 0
  const stack = []
  const str = sourceCode.match(/\(|\)/g) ?? []
  const pairs = { ')': '(' }
  for (let i = 0; i < str.length; ++i)
    if (str[i] === '(') stack.push(str[i])
    else if (str[i] in pairs) if (stack.pop() !== pairs[str[i]]) ++count
  return count - stack.length
}
export const handleUnbalancedParens = (source) => {
  const diff = isBalancedParenthesis(source)
  if (diff !== 0)
    throw new SyntaxError(
      `Parenthesis are unbalanced by ${diff > 0 ? '+' : ''}${diff} ")"`
    )
  return source
}
export const runFromCompiled = (source, Extensions = {}, helpers = {}) => {
  const tree = parse(source)
  if (Array.isArray(tree)) {
    const compiled = compileToJs(tree, Extensions, helpers)
    const JavaScript = `${compiled.top}\n${compiled.program}`
    return eval(JavaScript)
  }
}
export const runFromInterpreted = (source, env) => {
  const tree = parse(source)
  if (Array.isArray(tree)) return run(tree, env)
}
