//
//  ViewController.swift
//  ListRandom
//
//  Created by Gianni De Leon on 16/2/24.
//

import UIKit
//MARK: #Class ViewController
class ViewController: UIViewController {
	//MARK: - Outlet
	@IBOutlet weak var mealUITableView: UITableView!
	//MARK: - Variables
	var meals = [Meal]()
	//MARK: - Functions
	override func viewDidLoad() {
		super.viewDidLoad()
		configInitial()
		getMeals()
	}
	
	func configInitial(){
		self.mealUITableView.register(UINib(nibName: "MealTableViewCell", bundle: nil), forCellReuseIdentifier: "MealTableViewCell")
		self.mealUITableView.dataSource = self
		self.mealUITableView.delegate = self
	}
	
	func getMeals(){
		var request = URLRequest(url: URL(string: "https://www.themealdb.com/api/json/v1/1/random.php")!,timeoutInterval: Double.infinity)
		request.httpMethod = "GET"
		
		let task = URLSession.shared.dataTask(with: request) { data, response, error in
			guard let data = data else {
				print(String(describing: error))
				return
			}
			do{
				let decod = JSONDecoder()
				let meals = try decod.decode(MealResponse.self, from: data)
				if !self.isExsists(meal: meals.meals[0]){
					self.meals.append(meals.meals[0])
				}
				if self.meals.count < 20 {
					self.getMeals()
				}else{
					DispatchQueue.main.async {
						self.mealUITableView.reloadData()
					}
				}
			} catch {
				print("error")
			}
			
		}
		
		task.resume()
	}
	
	func isExsists(meal: Meal) -> Bool{
		if self.meals.isEmpty {
			return false
		}
		for mealAux in self.meals {
			if mealAux.idMeal == meal.idMeal{
				return true
			}
		}
		return false
	}


}
//MARK: ##Extension
extension ViewController : UITableViewDataSource, UITableViewDelegate{
	//MARK: - Functions
	func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		return self.meals.count
	}
	
	func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		let cell = tableView.dequeueReusableCell(withIdentifier: "MealTableViewCell", for: indexPath) as! MealTableViewCell
		let meal = meals[indexPath.row]
		cell.titleUILabel.text = meal.strMeal
		cell.descriptionUILabel.text = meal.strCategory + " - " + meal.strArea
		cell.setImage(strMealThumb: meal.strMealThumb)
		return cell
	}
	
	func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
		let meal = self.meals[indexPath.row]
		guard let url = URL(string: meal.strYoutube ?? "")else{
			print("\(meal.strYoutube ?? "vacio") no es una url")
			return
		}
		goToUrl(url: url)
	}
	
	func goToUrl(url:URL){
		UIApplication.shared.open(url)
	}
	
	
}

