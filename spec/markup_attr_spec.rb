require "spec_helper"

describe MarkupAttr do
  let(:markdown) { File.read(File.dirname(__FILE__) + "/fixtures/content.markdown") }
  let(:textile) { File.read(File.dirname(__FILE__) + "/fixtures/content.textile") }

  it "sets class methods" do
    expect(Post).to respond_to(:markup_attr)
    expect(Post).to respond_to(:markup_attr_options)
  end

  it "generates formatted content" do
    post = create_post
    expect(post.formatted_content).not_to be_blank
    expect(post.formatted_excerpt).not_to be_blank
  end

  it "formats content using markdown" do
    post = create_post(:content => markdown)
    text = post.formatted_content

    expect(text).to have_tag("strong", text: "formatted")
    expect(text).to have_tag("em", text: "text")
    expect(text).to have_tag("a[href='http://example.com']", text: "http://example.com")
    expect(text).to have_tag("ul", count: 1)
    expect(text).to have_tag("p", count: 4)

    expect(text).not_to have_tag("h1", text: "Some title")
    expect(text).not_to have_tag("script")
    expect(text).not_to have_tag("a[title=Example]")
    expect(text).not_to have_tag("img")
  end

  it "formats content using textile" do
    post = create_comment(:content => textile)
    text = post.formatted_content

    expect(text).to have_tag("strong", text: "formatted")
    expect(text).to have_tag("em", text: "text")
    expect(text).to have_tag("a[href='http://example.com']", text: "http://example.com")
    expect(text).to have_tag("ul", count: 1)
    expect(text).to have_tag("p", count: 4)

    expect(text).not_to have_tag("h1", text: "Some title")
    expect(text).not_to have_tag("script")
    expect(text).not_to have_tag("a[title=Example]")
    expect(text).not_to have_tag("img")
  end

  it "keeps content when format is :html" do
    post = create_post(:excerpt => "<p>some text</p>")

    allow(Markdown).to receive_messages :new => double("content").as_null_object
    expect(Markdown).not_to receive(:new).with(:html, post.excerpt)

    text = post.formatted_excerpt
    expect(text).to have_tag("p", text: /some text/)
  end

  it "skips parsing when attribute hasn't changed" do
    post = create_post
    expect(Markdown).not_to receive(:new)
    post.save
  end

  it "parses content when attribute has changed" do
    post = create_post
    post.content = "Check this out: <http://example.com> "
    post.save
    expect(post.formatted_content).to have_tag("a[href='http://example.com']", text: "http://example.com")
  end

  it "parses content when formatted attribute is blank" do
    post = create_post
    post.formatted_content = ""
    post.save
    expect(post.formatted_content).not_to be_blank
  end

  it "skips sanitize" do
    expect(MarkupAttr::Sanitize).not_to receive(:html)
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
