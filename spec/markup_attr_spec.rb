require "spec_helper"

describe MarkupAttr do
  let(:markdown) { File.read(File.dirname(__FILE__) + "/fixtures/content.markdown") }
  let(:textile) { File.read(File.dirname(__FILE__) + "/fixtures/content.textile") }

  it "sets class methods" do
    Post.should respond_to(:markup_attr)
    Post.should respond_to(:markup_attr_options)
  end

  it "generates formatted content" do
    post = create_post
    post.formatted_content.should_not be_blank
    post.formatted_excerpt.should_not be_blank
  end

  it "formats content using markdown" do
    post = create_post(:content => markdown)
    text = post.formatted_content

    text.should have_tag("strong", "formatted")
    text.should have_tag("em", "text")
    text.should have_tag("a[href='http://example.com']", "http://example.com")
    text.should have_tag("ul", 1)
    text.should have_tag("p", 4)

    text.should_not have_tag("h1", "Some title")
    text.should_not have_tag("script")
    text.should_not have_tag("a[title=Example]")
    text.should_not have_tag("img")
  end

  it "formats content using textile" do
    post = create_comment(:content => textile)
    text = post.formatted_content

    text.should have_tag("strong", "formatted")
    text.should have_tag("em", "text")
    text.should have_tag("a[href='http://example.com']", "http://example.com")
    text.should have_tag("ul", 1)
    text.should have_tag("p", 4)

    text.should_not have_tag("h1", "Some title")
    text.should_not have_tag("script")
    text.should_not have_tag("a[title=Example]")
    text.should_not have_tag("img")
  end

  it "keeps content when format is :html" do
    post = create_post(:excerpt => "<p>some text</p>")

    Markdown.stub :new => mock("content").as_null_object
    Markdown.should_not_receive(:new).with(:html, post.excerpt)

    text = post.formatted_excerpt
    text.should have_tag("p", /some text/)
  end

  it "skips parsing when attribute hasn't changed" do
    post = create_post
    Markdown.should_not_receive(:new)
    post.save
  end

  it "parses content when attribute has changed" do
    post = create_post
    post.content = "Check this out: <http://example.com> "
    post.save
    post.formatted_content.should have_tag("a[href='http://example.com']", "http://example.com")
  end

  it "parses content when formatted attribute is blank" do
    post = create_post
    post.formatted_content = ""
    post.save
    post.formatted_content.should_not be_blank
  end

  it "skips sanitize" do
    MarkupAttr::Sanitize.should_not_receive(:html)
    create_task
  end

  private
  def create_post(options={})
    Post.create({
      :title => "Some title",
      :content => "some content",
      :excerpt => "some content"
    }.merge(options))
  end

  def create_comment(options={})
    Comment.create({
      :content => "some content"
    }.merge(options))
  end

  def create_task(options={})
    Task.create({
      :content => "some content"
    }.merge(options))
  end
end
