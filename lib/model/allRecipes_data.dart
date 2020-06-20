class AllRecipesData {
  String id,
      title,
      serving,
      totalTime,
      recipeImage,
      sourceName,
      sourceUrl,
      sourceImage,
      ingredientName,
      ingredientPreparation,
      ingredientQuantity;

  AllRecipesData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    print(id);
  }
}
