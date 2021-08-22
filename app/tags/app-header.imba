import './header-search.imba'
import './header-logo.imba'
import './header-right-icons.imba'
tag app-header < header
	css & 
		h:16tw 
		bg:cooler9 
		d:flex
		ai:center
		fld:row
	def render
		<self>
			<header-logo>
			<header-search>
			<header-right-icons>
