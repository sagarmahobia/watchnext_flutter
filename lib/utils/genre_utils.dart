enum MovieGenres {
  Action,
  Adventure,
  Animation,
  Comedy,
  Crime,
  Documentary,
  Drama,
  Family,
  Fantasy,
  History,
  Horror,
  Music,
  Mystery,
  Romance,
  ScienceFiction,
  TVMovie,
  Thriller,
  War,
  Western,
}

extension MovieExtension on MovieGenres {
  int get id {
    return [
      28,
      12,
      16,
      35,
      80,
      99,
      18,
      10751,
      14,
      36,
      27,
      10402,
      9648,
      10749,
      878,
      10770,
      53,
      10752,
      37
    ][this.index];
  }
}

enum TVGenres {
  ActionAndAdventure,
  Animation,
  Comedy,
  Crime,
  Documentary,
  Drama,
  Family,
  Kids,
  Mystery,
  News,
  Reality,
  SciFiAndFantasy,
  Soap,
  Talk,
  WarAndPolitics,
  Western,
}

extension TVExtention on TVGenres {
  int get id {
    return [
      10759,
      16,
      35,
      80,
      99,
      18,
      10751,
      10762,
      9648,
      10763,
      10764,
      10765,
      10766,
      10767,
      10768,
      37
    ][this.index];
  }
}

String getMovieGenreById(int id) {
  if (id == 28) {
    return "Action";
  } else if (id == 12) {
    return "Adventure";
  } else if (id == 16) {
    return "Animation";
  } else if (id == 35) {
    return "Comedy";
  } else if (id == 80) {
    return "Crime";
  } else if (id == 99) {
    return "Documentary";
  } else if (id == 18) {
    return "Drama";
  } else if (id == 10751) {
    return "Family";
  } else if (id == 14) {
    return "Fantasy";
  } else if (id == 36) {
    return "History";
  } else if (id == 27) {
    return "Horror";
  } else if (id == 10402) {
    return "Music";
  } else if (id == 9648) {
    return "Mystery";
  } else if (id == 10749) {
    return "Romance";
  } else if (id == 878) {
    return "Science Fiction";
  } else if (id == 10770) {
    return "TV Movie";
  } else if (id == 53) {
    return "Thriller";
  } else if (id == 10752) {
    return "War";
  } else if (id == 37) {
    return "Western";
  } else {
    return "N/A";
  }
}

String getTvGenreById(int id) {
  if (id == 10759) {
    return "Action & Adventure";
  } else if (id == 16) {
    return "Animation";
  } else if (id == 35) {
    return "Comedy";
  } else if (id == 80) {
    return "Crime";
  } else if (id == 99) {
    return "Documentary";
  } else if (id == 18) {
    return "Drama";
  } else if (id == 10751) {
    return "Family";
  } else if (id == 10762) {
    return "Kids";
  } else if (id == 9648) {
    return "Mystery";
  } else if (id == 10763) {
    return "News";
  } else if (id == 10764) {
    return "Reality";
  } else if (id == 10765) {
    return "Sci-Fi & Fantasy";
  } else if (id == 10766) {
    return "Soap";
  } else if (id == 10767) {
    return "Talk";
  } else if (id == 10768) {
    return "War & Politics";
  } else if (id == 37) {
    return "Western";
  }
  return "N/A";
}
