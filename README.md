# The Kong Initiative Tictail theme

This is a Sinatra app we use to do local development of the theme for [The Kong Initiative](http://www.konginitiative.com). It speeds up development by downloading your Tictail store data and let's you develop on your local machine instead of being stuck with the code editor on Tictail.

Be curious and try it! If you want to use yourself you'll have to change some stuff. Most likely in the `Gruntfile.js`. You'll figure it out…

Questions? Just [open an issue](https://github.com/kollegorna/kong-tictail-theme/issues).

This app is originally a fork of [javve/tictail-theme-builder](https://github.com/javve/tictail-theme-builder) so hats of to [@javve](https://twitter.com/javve) for sharing this in the first place!
We've improved it by making a lot of changes of the Ruby code and some other stuff to make it fit how we do things here at [Kollegorna](https://labs.kollegorna.se).

[The Kong Initiative](http://www.konginitiative.com) is an online store bringing you the widest snowboards around to the EU. We'll give you free shipping, great service and lots of joy.

## Requirements
* Ruby
* [Direnv](http://direnv.net/)
* [Bundler](https://rubygems.org/gems/bundler)
* [Node.js](http://nodejs.org)

## Setup locally
1. Clone repository
2. Make sure you have  and  installed.
3. `$ bundle install`
4. `$ npm install`
5. `$ bower install`
6. Set your Tictail credentials to .envrc file,  
  ```
  export TICTAIL_EMAIL=your-tictail@email.com  
  export TICTAIL_PASSWORD=your-tictail-password
  ```
7. Fetch your Tictail store data into `store.json` by this command:
  ```
  $ rake fetch
  ```

## Serve locally
  ```
  $ grunt
  ```

Then open [localhost:9292](http://localhost:9292).

## Render Tictail theme
  ```
  $ rake print
  ```

Your theme is now saved to both your __clipboard__ and to __theme.mustache__.

Then go ahead and paste it into the theme editor on Tictail. Win!!!

## Files

```
lib/
```
All the Ruby code that does the magic of downloading, serving and rendering the theme.

```
static/
```
Assets and and a local development helper (theme-builder.js).
Compiled CSS and JS goes into `static/assets/dist`.

```
templates/
```
The mustache templates for the actual store pages. And some helper stuff for local development (`templates/tictail/misc.mustache`).

```
views/
```
The Sinatra views…

## Things that differ in the local development vs Tictail.com
These are converted when you run `$ rake print`.

```
{{search}} --> {{{search}}}
{{social_buttons}} --> {{{social_buttons}}}
{{price_with_currency}} --> {{{price_with_currency}}}
{{children?}}{{/children}} --> {{#has_children?}}{{/has_children}}
{{store_description}}--> {{{store_description}}}
{{description}}--> {{{description}}}
```


## License

All code but the files listed in the folders below is licensed under the MIT License.

- /static/assets

