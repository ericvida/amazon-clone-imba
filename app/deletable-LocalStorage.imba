
class localStorageService
	products = [{name:'one'},{name:'two'},{name:'three'},{name:'four'}]
	def constructor
		setProducts(products)
		getProducts!
	def test
		console.log 'test'
	def setLocal key, val
		window.localStorage.setItem(key, val)
	def getLocal key
		window.localStorage.getItem(key)
	def setProducts value
		window.localStorage.setItem('products', value)
	def getProducts
		window.localStorage.getItem('products')
	def clear
		window.localStorage.clear!
	def remove item
		window.localStorage.removeItem(item)
	def storageAvailable(type)
		let storage
		try 
			storage = window[type]
			let x = '__storage_test__'
			storage.setItem(x, x)
			storage.removeItem(x)
			return true
				
let ls = new localStorageService
extend tag Element
	get ls
		return ls
export default ls