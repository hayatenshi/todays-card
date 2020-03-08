require 'rails_helper'

RSpec.describe Article, type: :model do
  describe "#create" do
    context "can save" do
      it "is valid with all" do
        expect(build(:article, :article_with_image)).to be_valid
      end
    end

    context "can not save" do
      context "invalid without" do
        it "is invalid without title" do
          article = build(:article, :article_with_image, title: nil)
          article.valid?
          expect(article.errors[:title]).to include("can't be blank")
        end

        it "is invalid without text" do
          article = build(:article, :article_with_image, text: nil)
          article.valid?
          expect(article.errors[:text]).to include("can't be blank")
        end

        it "is invalid without category" do
          article = build(:article, :article_with_image, category: nil)
          article.valid?
          expect(article.errors[:category]).to include("must exist")
        end

        it "is invalid without images" do
          article = build(:article)
          article.valid?
          expect(article.errors[:images]).to include()
        end
      end

      context "invalid duplication" do
        it "is invalid duplication title" do
          article = create(:article, :article_with_image)
          a_article = build(:article, title: article.title)
          a_article.valid?
          expect(a_article.errors[:title]).to include("has already been taken")
        end

        it "is invalid duplication text" do
          article = create(:article, :article_with_image)
          a_article = build(:article, text: article.text)
          a_article.valid?
          expect(a_article.errors[:text]).to include("has already been taken")
        end

        it "is invalid duplication images" do
          article = create(:article, :article_with_image)
          a_article = build(:article, :article_with_image)
          a_article.valid?
          expect(a_article.errors[:images]).to include()
        end
      end
    end
  end
end
