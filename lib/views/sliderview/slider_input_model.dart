class SliderInputModel {
  final String url;
  final String sliderTitle;
  final String pictureType;
  final bool isEmbedded;
  final bool isAd;

  SliderInputModel(
      {this.url, this.sliderTitle, this.pictureType, this.isEmbedded = false, this.isAd = false});
}
