export function allNodes(obj: any, key: string, array?: any[]): string[] {
  array = array || []
  if ('object' === typeof obj) {
    for (const k in obj) {
      if (k === key) {
        array.push(obj[k])
      } else {
        allNodes(obj[k], key, array)
      }
    }
  }
  return array
}
