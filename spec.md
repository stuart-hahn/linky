# Specifications for the Rails Assessment

Specs:
- [x] Using Ruby on Rails for the project
- [x] Include at least one has_many relationship (x has_many y; e.g. User has_many Recipes)
    > User has_many :links
- [x] Include at least one belongs_to relationship (x belongs_to y; e.g. Post belongs_to User)
    > Link belongs_to :user
- [x] Include at least two has_many through relationships (x has_many y through z; e.g. Recipe has_many Items through Ingredients)
    > User has_many :communities, through: :links
    > Community has_many :users, through: :links
    > User has_many :commented_links, through: :comments, source: :link
    > Link has_many :users, through: :comments
- [x] Include at least one many-to-many relationship (x has_many y through z, y has_many x through z; e.g. Recipe has_many Items through Ingredients, Item has_many Recipes through Ingredients)
    > User has_many :communities, through: :links
    > Community has_many :users, through: :links
- [x] The "through" part of the has_many through includes at least one user submittable attribute, that is to say, some attribute other than its foreign keys that can be submitted by the app's user (attribute_name e.g. ingredients.quantity)
    > Links have two user submittable attributes (title and url)
    > Comments have one user submittable attribute (body)
- [x] Include reasonable validations for simple model objects (list of model objects with validations e.g. User, Recipe, Ingredient, Item)
    > Link validates :title, presence: true, uniqueness: { case_sensitive: false }
    > Link validates :url, presence: true
    > Community validates :title, presence: true, uniqueness: { case_sensitive: false }
    > Comment validates :body, presence: true
- [x] Include a class level ActiveRecord scope method (model object & class method name and URL to see the working feature e.g. User.most_recipes URL: /users/most_recipes)
    > Comment scope :newest, -> { order(created_at: :desc) }
    > Link scope :hottest, -> { order(hot_score: :desc) }
    > Link scope :newest, -> { order(created_at: :desc) }
    > Community scope :alphabetized, -> { order(:title)}
    > Community scope :most_links, -> {left_joins(:links).group('communities.id').order('count(links.community_id) desc')}
- [x] Include signup (how e.g. Devise)
    > Devise
- [x] Include login (how e.g. Devise)
    > Devise
- [x] Include logout (how e.g. Devise)
    > Devise
- [x] Include third party signup/login (how e.g. Devise/OmniAuth)
    > Devise + Omniauthable (github)
- [x] Include nested resource show or index (URL e.g. users/2/recipes)
    > /communities/1/links
    > /links/5/comments
- [x] Include nested resource "new" form (URL e.g. recipes/1/ingredients/new)
    > /links/1/comments/new
    > /communities/2/links/new
- [x] Include form display of validation errors (form URL e.g. /recipes/new)
    > forms render 'shared/errors' partial, and that displays validation errors

Confirm:
- [ ] The application is pretty DRY
- [ ] Limited logic in controllers
- [ ] Views use helper methods if appropriate
- [ ] Views use partials if appropriate