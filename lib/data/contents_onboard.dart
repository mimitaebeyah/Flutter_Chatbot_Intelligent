class OnboardContent {
  String image;
  String text;
  String descripcion;

  OnboardContent(
      {required this.image, required this.text, required this.descripcion});
}

List<OnboardContent> contents = [
  OnboardContent(
    text: "Introduction",
    image: "assets/images/TransBot.png",
    descripcion:
        "Bonjour, je suis ChatGBT, un grand modéle de langue formé par OpenAI. Je peux répondre à des questions avec divers sujets, générer du texte. je suis en cours de progrés, alors soyez patient avec moi.",
  ),
  OnboardContent(
    text: "Comment utiliser le chatbot ?",
    image: "assets/images/Reading.png",
    descripcion:"Pour utiliser ChatGPT, vous pouvez simplement lui poser une qustion ou lui donner prompt et il généra une réponse."
  ),

];
