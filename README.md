# Particle Jekyll Theme

![](./particle.jpg)

This is a simple and minimalist template for Jekyll designed for developers that want to show of their portfolio.

The Theme features:

- SASS (compiled by Jekyll)
- Sweet Scroll
- Particle.js
- Font Awesome and Devicon icons
- Google Analytics
- Info Customization

## Basic Setup

1. [Install Jekyll](http://jekyllrb.com)
2. Clone the particle theme: `git clone https://github.com/nrandecker/particle.git`
3. Edit `_config.yml` to personalize your site.

## Site and User Settings

You have to fill some informations on `_config.yml` to customize your site.

```
# Site settings
description: A blog about lorem ipsum dolor sit amet
baseurl: "" # the subpath of your site, e.g. /blog/
url: "http://localhost:3000" # the base hostname & protocol for your site

# User settings
username: Lorem Ipsum
user_description: Anon Developer at Lorem Ipsum Dolor
user_title: Anon Developer
email: anon@anon.com
twitter_username: lorem_ipsum
github_username:  lorem_ipsum
gplus_username:  lorem_ipsum
```

**Don't forget to change your url before you deploy your site!**

## Color and Particle Customization
- Color Customization
  - Edit the sass variables
- Particle Customization
  - Edit the json data in particle function in app.js
  - Refer to [Particle.js](https://github.com/VincentGarreau/particles.js/) for help

## Layout

    _config.yml            site settings
    _includes/, _layouts/  Liquid templates
    _sass/                 SCSS partials
    assets/css/main.scss   stylesheet entrypoint (Jekyll compiles -> main.css)
    assets/js/             hand-written JS, served as-is
    assets/fonts/, img/    static assets, copied verbatim
    index.html             the page
    CNAME                  custom domain, copied into the build

## Running locally

    make serve    # http://localhost:4000, rebuilds and reloads on change
    make build    # build once into _site/
    make clean    # remove build output and caches

The Makefile uses a native Ruby toolchain if `bundle` is on your PATH, and
otherwise runs everything in a `ruby:3.3` container — so Docker alone is
enough, no local Ruby needed. Gems are cached in `vendor/bundle`.

To drive Jekyll directly instead:

    bundle install
    bundle exec jekyll serve

The Makefile is local-only; it plays no part in deployment.

## Deployment

Pushing to `main` triggers `.github/workflows/pages.yml`, which builds the
site with Jekyll and publishes it to GitHub Pages. Build output is **not**
committed — do not check in `_site/`, and make content edits to the source
files above rather than to generated HTML.

## Questions

Having any issues file a [GitHub Issue](https://github.com/nrandecker/particle/issues/new).

## License

This theme is free and open source software, distributed under the The MIT License. So feel free to use this Jekyll theme anyway you want.

## Credits

This theme was partially designed with the inspiration from these fine folks
- [Willian Justen](https://github.com/willianjusten/will-jekyll-template)
- [Vincent Garreau](https://github.com/VincentGarreau/particles.js/)
