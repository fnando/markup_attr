# Markup Attribute

Markup Attribute is an ActiveRecord plugin that integrates
Markdown, Textile and `sanitize` helper method into a single
plugin.

## Installation

Install the plugin with

    gem install markup_attr

Install the markup language you want to use. For Markdown, install it using

    gem install redcarpet

If you prefer Textile, install it using

    gem install RedCloth

## Usage

All you need to do is call the method +markup_attr+ from your model.

```ruby
class Post < ActiveRecord::Base
  markup_attr :content,
    :format       => :markdown,
    :tags         => %w(p a em strong ul li),
    :attributes   => %w(href)
end
```

The example above expects the table `posts` to have two columns: `content`
and `formatted_content`. This example is also filtering the allowed tags and
attributes. If you don't want to limit what will be saved, just go with
something like this

```ruby
class Post < ActiveRecord::Base
  markup_attr :content, :format => :textile
end
```

To save normalized HTML, if you don't want to use Markdown or Textile, set
`:format` to `:html`.

```ruby
class Post < ActiveRecord::Base
  markup_attr :content, :format => :html
end
```

If you don't want the content to be sanitized at all, you can set `:sanitize`
to `false`. This is specially useful if you're the editor or something like
that.

```ruby
class Post < ActiveRecord::Base
  markup_attr :content,
    :format       => :html,
    :sanitize     => false
end
```

You can instantiate a markup object any time:

```ruby
markup = MarkupAttr::Markup.new(:markdown, 'some text')
markup = MarkupAttr::Markup.new(:textile,  'some text')
puts markup.to_html
```

To set the Redcarpet Markdown renderer, you can just do something like this:

```ruby
# This is the default engine.
MarkupAttr::Markdown.engine = Redcarpet::Markdown.new(Redcarpet::Render::HTML)
```

To sanitize a given HTML, use the `html` method:

```ruby
MarkupAttr::Sanitize.html('<script>alert(document.cookie)</script>')

MarkupAttr::Sanitize.html('<script>alert(document.cookie)</script>',
  :tags => %w(p a em strong img ul li ol)
)

MarkupAttr::Sanitize.html('<script>alert(document.cookie)</script>',
  :attributes => %w(href title alt)
)
```

To remove all tags, use the `strip_tags` method:

```ruby
MarkupAttr::Sanitize.strip_tags('<strong>PWNED</strong>')
```

## Maintainer

* Nando Vieira (http://simplesideias.com.br)

## License

(The MIT License)

Permission is hereby granted, free of charge, to any person obtaining
a copy of this software and associated documentation files (the
'Software'), to deal in the Software without restriction, including
without limitation the rights to use, copy, modify, merge, publish,
distribute, sublicense, and/or sell copies of the Software, and to
permit persons to whom the Software is furnished to do so, subject to
the following conditions:

The above copyright notice and this permission notice shall be
included in all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED 'AS IS', WITHOUT WARRANTY OF ANY KIND,
EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF
MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.
IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY
CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT,
TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE
SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
