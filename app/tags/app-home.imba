import './home-banner'
import './home-categories'
import './home-products'
tag app-home < div
	css .home-section
		d:flex p:6tw bg:cooler1 fld:column fl:1
	def render
		<self.home-section>
			<home-banner>
			<home-categories>		
			<home-deals>
