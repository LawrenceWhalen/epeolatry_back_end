<!-- PROJECT SHIELDS -->

[![Contributors][contributors-shield]][contributors-url]
[![Forks][forks-shield]][forks-url]
[![Stargazers][stars-shield]][stars-url]
[![Issues][issues-shield]][issues-url]

<!-- PROJECT LOGO -->
<br />
<p align="center">
  <a href="https://github.com/othneildrew/Best-README-Template">
    <img src="https://user-images.githubusercontent.com/72179421/127915894-7ac33fe7-7205-455a-a273-3543535f75a0.png" alt="Logo" width="195" height="195">
  </a>

  <h3 align="center">e . p . e . o . l . a . t . r . y | backend</h3>
  <p align="center">
    a carefully crafted collection of API endpoints to cater to and be consumed by epeolatry | FRONT END
    <br />
    <a href="DEMOHTTPHERE">View Demo</a>
    ·
    <a href="BUGREPORTHTTPHERE">Report Bug</a>
    ·
    <a href="FEATUREREQUESTHTTPHERE">Request Feature</a>
  </p>
</p>



<!-- TABLE OF CONTENTS -->
<details open="open">
  <summary>Table of Contents</summary>
  <ol>
    <li>
      <a href="#about-the-project">About The Project</a>
      <ul>
        <li><a href="#built-with">Built With</a></li>
      </ul>
    </li>
    <li>
      <a href="#getting-started">Getting Started</a>
      <ul>
        <li><a href="#prerequisites">Prerequisites</a></li>
        <li><a href="#installation">Installation</a></li>
      </ul>
    </li>
    <li><a href="#usage">Usage</a></li>
    <li><a href="#roadmap">Roadmap</a></li>
    <li><a href="#contributing">Contributing</a></li>
  </ol>
</details>



<!-- ABOUT THE PROJECT -->
## About The Project
An API Integration built to bridge [epeolatry | FRONT END](https://github.com/Caleb1991/epeolatry_front_end.git) to GoogleBooks - allowing users not only to track their literary/vocabulary journey <em>within</em> our app, but also to edit their Google Bookshelves, Reading Lists, etc. <em>through</em> our app.

### Built With

* [Ruby | v](https://www.ruby-lang.org/en/)
* [Rails | v](https://rubyonrails.org/)

<!-- GETTING STARTED -->
## Getting Started

Visit us on [Heroku](https://epeolatry-back-end.herokuapp.com/) <strong>OR</strong> | If you'd prefer a more behind-the-scenes tour, run through [LocalHost:3000](http://localhost:3000/) - starting with the steps below.

### Prerequisites

- You may <em>want</em> to browse the Google Books API Docs
- You will <strong>need</strong> to request an API Key
- <strong><em>I'd recommend both</em></strong> | You can do either [HERE](https://developers.google.com/books/docs/overview) 

### Installation (if running locally)

1. Fork and clone this repo
2. Add Figaro to Gemfile
   ```sh
   #epeolatry_front_end/gemfile
   
   #group :development, :test do
   gem 'figaro'
   #end
   ```
3. Add your API Key
   ```sh
   #config/application.yml
   
   API_KEY = 'ENTER YOUR API'
   ``` 
3. Install gem packages by running `bundle`
4. Setup the database by running `rails db:{drop,create,migrate}`
5. Run `rails s` and navigate to http://localhost:3000

<!-- USAGE -->
## Usage

Below are all included endpoints, along with necessary params.
* All with append to base connector http://localhost:3000 or https://epeolatry-back-end.herokuapp.com ([Heroku](https://epeolatry-back-end.herokuapp.com))

### Books:

| Method   | URL                      | Detail             | Params                                             |
| -------- | ------------------------ | ------------------ | -------------------------------------------------- |
| `GET`    | `/api/v1/user/books`     | Reader's Books     | { auth_token: 'the users auth_token from google' } |
| `GET`    | `/api/v1/book/search’`         | Book Search Results   | { search: 'search words', page: 'which page of returns, defaults to first page if not passed' } |
| `POST`    | `/api/v1/user/books`     | Add a Book to Reader's Library     | { volume_id: book_id, auth_token: auth_token_for_user, shelf_id: ‘2, 3, or 4’ } |
| `DELETE`    | `/api/v1/user/books/:volume_id`     | Remove Book From Reader's Library     | { auth_token: auth_token_for_user, shelf_id: ‘2, 3, or 4’ } |


### Words:

| Method   | URL                      | Detail             | Params                                             |
| -------- | ------------------------ | ------------------ | -------------------------------------------------- |
| `GET`    | `/api/v1/word/search`     | Word Search Results     | params[:q] = <'word you want to search example - caterwaul'> |
| `POST`    | `/api/v1/user/words`     | Add Word to Glossary for given Book     | { word: 'word to look up and create', volume_id: book_id, user_id: user_id } |
| `GET`    | `/api/v1/user/words`     | Reader's Glossary of Words     | { user_id: user_id } |


<!-- EXAMPLES -->
## EXAMPLES

### Reader's Books
* GET https://epeolatry-back-end.herokuapp.com/api/v1/user/books | params: { auth_token: 'the users auth_token from google' }

```

[{:id=>"PCcOMbEydAIC",
  :type=>"book_and_shelf",
  :attributes=>
   {:title=>"Lilith's Brood",
    :authors=>["Octavia E. Butler"],
    :genres=>["Fiction"],
    :description=>
     "The complete series about an alien species that could save humanity after nuclear apocalypse—or destroy it—from “one of science fiction’s finest writers” (The New York Times). The newest stage in human evolution begins in outer space. Survivors ...",
    :shelves=>["Reading now"]}},
 {:id=>"ZrNzAwAAQBAJ",
  :type=>"book_and_shelf",
  :attributes=>
   {:title=>"The Three-Body Problem",
    :authors=>["Cixin Liu"],
    :genres=>["Fiction"],
    :description=>
     "Soon to be a Netflix Original Series! “War of the Worlds for the 21st century.” – Wall Street Journal The Three-Body Problem is the first chance for English-speaking readers to experience the Hugo Award-winning phenomenon from China's most ...",
    :shelves=>["Reading now"]}},
 {:id=>"8thMLkahggcC",
  :type=>"book_and_shelf",
  :attributes=>
   {:title=>"Parable of the Sower",
    :authors=>["Octavia E. Butler"],
    :genres=>["Fiction"],
    :description=>
     "A New York Times Notable Book: In 2025, with the world descending into madness and anarchy, one woman begins a fateful journey toward a better future. “A stunner.” —Flea, musician and actor, TheWall Street Journal Lauren Olamina and her family ...",
    :shelves=>["Reading now", "To read"]}},
 {:id=>"yrYUvgAACAAJ",
  :type=>"book_and_shelf",
  :attributes=>
   {:title=>"All You Need Is Kill",
    :authors=>["Hiroshi Sakurazaka"],
    :genres=>["Fiction"],
    :description=>
     "When the alien Mimics invade, Keiji Kiriya is just one of many recruits shoved into a suit of battle armor called a Jacket and sent out to kill. Keiji dies on the battlefield, only to be reborn each morning to fight and die again and again. On ...",
    :shelves=>["Reading now"]}},
 {:id=>"inYs79gV4UQC",
  :type=>"book_and_shelf",
  :attributes=>
   {:title=>"Snow Crash",
    :authors=>["Neal Stephenson"],
    :genres=>["Fiction"],
    :description=>
     "\"This Snow Crash thing--is it a virus, a drug, or a religion?\" Juanita shrugs. \"What's the difference?\" The only relief from the sea of logos is within the well-guarded borders of the Burbclaves. Is it any wonder that most sane folks have ...",
    :shelves=>["To read"]}}]
    
```


### Word Search Results
* GET https://epeolatry-back-end.herokuapp.com/api/v1/word/search | params: { word: 'word to look up and create', volume_id: book_id, user_id: user_id }

```


'https://epeolatry-back-end.herokuapp.com/api/v1/word/search'
  params[:word] = <'word you want to search example - caterwaul'>

{:data=>
  {:id=>"caterwaul",
   :type=>"word_poro",
   :attributes=>
    {:word=>"caterwaul",
     :definition=>"Make a shrill howling or wailing noise like that of a cat.",
     :phonetic=>"/ˈkædərˌwɔl/",
     :phonetic_link=>"https://lex-audio.useremarkable.com/mp3/caterwaul_us_1.mp3",
     :part_of_speech=>"intransitive verb",
     :synonyms=>nil,
     :example=>"he seems to think that singing soulfully is to whine and caterwaul tunelessly"
   }
  }
 }
    
```


<!-- ROADMAP -->
## Roadmap

See the [open issues](https://github.com/othneildrew/Best-README-Template/issues) for a list of proposed features (and known issues).



<!-- CONTRIBUTING -->
## Contributing

Contributions are what make the open source community such an amazing place to be learn, inspire, and create. Any contributions you make are **greatly appreciated**.

1. Fork the Project
2. Create your Feature Branch (`git checkout -b feature/AmazingFeature`)
3. Commit your Changes (`git commit -m 'Add some AmazingFeature'`)
4. Push to the Branch (`git push origin feature/AmazingFeature`)
5. Open a Pull Request


<!-- MARKDOWN LINKS & IMAGES -->
<!-- https://www.markdownguide.org/basic-syntax/#reference-style-links -->
[contributors-shield]: https://img.shields.io/github/contributors/LawrenceWhalen/epeolatry_back_end.svg?style=for-the-badge
[contributors-url]: https://github.com/LawrenceWhalen/epeolatry_back_end/graphs/contributors
[forks-shield]: https://img.shields.io/github/forks/LawrenceWhalen/epeolatry_back_end.svg?style=for-the-badge
[forks-url]: https://github.com/LawrenceWhalen/epeolatry_back_end/network/members
[stars-shield]: https://img.shields.io/github/stars/LawrenceWhalen/epeolatry_back_end.svg?style=for-the-badge
[stars-url]: https://github.com/LawrenceWhalen/epeolatry_back_end/stargazers
[issues-shield]: https://img.shields.io/github/issues/LawrenceWhalen/epeolatry_back_end.svg?style=for-the-badge
[issues-url]: https://github.com/LawrenceWhalen/epeolatry_back_end/issues
[product-screenshot]: images/screenshot.png
