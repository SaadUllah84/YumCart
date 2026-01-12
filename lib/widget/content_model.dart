class UnboardingContent{
 String image;
 String title;
 String description;
 UnboardingContent({required this.description, required this.image, required this.title});
}

List<UnboardingContent> contents=[
  UnboardingContent(
      description: 'Good Food\nFast Delivery ',
      image: 'images/screen1.png',
      title: "Select from Our\n   Best Menu"),
  UnboardingContent(
      description: "You can pay on cash on delivery\n And card payment also available",
      image: "images/screen2.png",
      title: "Easy and online payment"
  ),
  UnboardingContent(
      description:"Deliver your food on your Doorsteps" ,
      image: "images/screen3.png",
      title: "Quick delivery at Your DoorSteps"
  ),

];