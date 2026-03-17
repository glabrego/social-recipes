# Redesign Brief

## Goal

Redesign Social Recipes to feel modern, minimal, and premium without becoming generic or hard to use.

The redesign should:

- feel editorial and content-led rather than dashboard-like
- work well on mobile first, then scale up to desktop
- support light and dark themes with automatic system switching
- stay implementable in the current Rails 8 stack with Propshaft, importmap, Turbo, and app-owned CSS/JS

## Product Fit

This app is not a workflow product. It is a browsing and publishing product with a social layer:

- browse recipes from the homepage
- filter by kitchen, food type, and preference
- open recipe detail pages
- create and edit recipes
- favorite recipes and like kitchens
- view a user profile with published recipes and favorites
- allow admins to create taxonomy records

Because of that, the redesign should optimize for:

- readable content hierarchy
- strong image treatment
- clear metadata presentation
- low-friction actions
- comfortable form completion on mobile

It should not optimize for:

- enterprise density
- data-table patterns
- command-center dashboards
- visual gimmicks that overpower recipe content

## Recommended Direction

Working direction: `Editorial Utility`

This blends:

- editorial restraint and whitespace
- product-grade clarity in controls
- warm, tactile surfaces that suit food content
- minimal motion and strong typography

Why this is the best fit:

- recipes benefit from calm, image-first presentation
- filters and favorite actions still need crisp product UX
- the app is small enough to benefit from a strong visual identity instead of component-library blandness

## Reference Set

### 1. Kinfolk

Link: <https://www.kinfolk.com/>

Relevant traits:

- editorial pacing
- large quiet blocks of whitespace
- strong, understated type hierarchy
- content-first presentation

Fit for this app:

- homepage rhythm
- recipe cards
- recipe detail layout
- profile page presentation

Borrow:

- calm hierarchy
- spacious sectioning
- image-led storytelling

Avoid:

- over-magazine treatment on utility pages like forms

### 2. Aesop

Link: <https://www.aesop.com/>

Relevant traits:

- warm neutral palettes
- premium but restrained surfaces
- tactile visual language
- minimal navigation noise

Fit for this app:

- overall color direction
- light and dark surface design
- card styling
- form styling

Borrow:

- warm light theme
- rich but quiet dark theme
- premium material feel without gloss

Avoid:

- ecommerce-heavy information density

### 3. Apple Newsroom

Link: <https://www.apple.com/newsroom/>

Relevant traits:

- disciplined content hierarchy
- crisp spacing
- clean section transitions
- very strong readability on mobile

Fit for this app:

- homepage section layout
- profile page structure
- typography scale

Borrow:

- section discipline
- headline/subheadline rhythm
- clean responsive spacing

Avoid:

- overusing large hero treatment on every page

### 4. Linear

Link: <https://linear.app/>

Relevant traits:

- high interaction polish
- compact, precise controls
- minimal chrome
- strong state presentation

Fit for this app:

- filter chips and buttons
- small actions like favorite/like/edit/delete
- hover, focus, and pressed states

Borrow:

- precise micro-interactions
- control styling
- compact metadata blocks

Avoid:

- turning the app into a dark SaaS interface

### 5. Raycast

Link: <https://www.raycast.com/>

Relevant traits:

- ergonomic spacing
- sharp component polish
- fast-feeling interaction treatment
- minimal but intentional visuals

Fit for this app:

- small component refinement
- empty states
- action rows
- subtle transitions

Borrow:

- disciplined component polish
- subtle motion
- fast-feeling UI behavior

Avoid:

- desktop-app styling patterns that feel unnatural on the web

## Mobile and Theme Research

### Responsive behavior

Reference: <https://web.dev/articles/responsive-web-design-basics>

Important takeaway:

- use content-driven media queries and adapt layout by width, height, orientation, and related viewport features

Implication for this redesign:

- mobile is the default layout
- desktop should progressively enhance the layout instead of rearranging everything around a sidebar-first model

### Touch targets

Reference: <https://web.dev/articles/accessible-tap-targets>

Important takeaway:

- controls need comfortable touch target sizing

Implication for this redesign:

- all primary actions should be thumb-friendly
- favorite/like buttons must be comfortably tappable on small screens
- dense inline action links should be avoided

### Auto dark mode

References:

- <https://web.dev/articles/prefers-color-scheme>
- <https://developer.mozilla.org/en-US/docs/Web/CSS/Reference/At-rules/@media/prefers-color-scheme>
- <https://developer.mozilla.org/en-US/docs/Web/CSS/Reference/Properties/color-scheme>

Important takeaways:

- use `prefers-color-scheme` for automatic theme switching
- set `color-scheme: light dark` so native controls render correctly
- rely on CSS variables for theme tokens

Implication for this redesign:

- build a token-based theming system
- support light and dark from day one
- use automatic system preference first
- a manual theme toggle can be added later without restructuring the styles

## Visual System Recommendation

### Tone

- warm
- quiet
- tactile
- precise
- content-first

### Light theme

- background: warm ivory / parchment
- surfaces: off-white and soft stone
- text: charcoal / deep olive-black
- accent: muted saffron or burnt orange
- borders: soft sand / clay neutrals

### Dark theme

- background: deep cocoa / graphite
- surfaces: warm charcoal
- text: off-white, not pure white
- accent: softened amber / copper
- borders: low-contrast warm gray

### Typography

Recommendation:

- headlines: high-character serif
- UI text and metadata: neutral sans-serif

Reason:

- recipes benefit from editorial personality
- controls need modern clarity

Implementation note:

- use web-safe or easy-to-host fonts with strong mobile rendering
- avoid default system-only styling for the final visual pass

## Layout Strategy

### Global shell

- compact top navigation
- content container with generous outer spacing
- visible but restrained flash messages
- theme tokens applied globally

### Homepage

Recommended structure:

1. hero or featured recipe block
2. featured favorites section
3. recent recipes section
4. filters as:
   - inline section on desktop
   - collapsible sheet or compact drawer on mobile

Why:

- the current page is functional but visually flat
- filters are important, but they should not dominate small screens

### Recipe cards

Recommended traits:

- larger image area
- concise metadata row
- stronger title hierarchy
- cleaner spacing between content blocks

### Recipe detail

Recommended structure:

1. hero image
2. title and metadata
3. primary actions
4. ingredients
5. steps

Why:

- this makes the page easier to scan on mobile
- it gives the photo the prominence users expect from a recipe app

### Forms

Requirements:

- full-width inputs on mobile
- larger tap targets
- clearer section grouping
- stronger distinction between primary and destructive actions

### Profile page

Recommended structure:

- user identity block
- published recipes
- favorite recipes
- liked kitchens

This should read more like a curated profile than a dump of partials.

## Interaction Design

Keep motion subtle:

- slight lift or shadow change on cards
- smooth theme transition
- gentle reveal/stagger only where it helps orientation

Do not use:

- bouncing micro-interactions
- parallax
- floating glass overlays
- heavy motion in lists

## Fit With Current Stack

Current stack fit is good:

- Rails 8.1.2
- Propshaft
- importmap-rails
- Turbo
- app-owned CSS and JavaScript

This means we can implement the redesign with:

- CSS custom properties for theme tokens
- `prefers-color-scheme`
- semantic HTML and updated view markup
- minimal JS for navigation polish and theme behavior if needed later

No build tooling change is required.

## Recommended Implementation Order

### Phase 1: design tokens and shell

- define light and dark tokens
- redesign global layout
- redesign nav and flash messages
- set typography and spacing scale

### Phase 2: homepage and cards

- redesign home sections
- redesign filter presentation
- redesign shared recipe and taxonomy partials

### Phase 3: recipe detail and forms

- redesign recipe show
- redesign recipe create/edit
- redesign admin taxonomy forms
- redesign auth screens

### Phase 4: profile and polish

- redesign user profile
- add subtle motion
- improve empty states
- refine dark mode contrast

## Success Criteria

The redesign is successful if:

- the app feels clearly modern without looking like a template
- mobile browsing and form completion feel natural
- dark mode looks intentional, not inverted
- recipe pages feel premium and readable
- action controls remain obvious and fast to use
- the new visual system can be maintained with app-owned CSS rather than a UI framework

## Sources

- Kinfolk: <https://www.kinfolk.com/>
- Aesop: <https://www.aesop.com/>
- Apple Newsroom: <https://www.apple.com/newsroom/>
- Linear: <https://linear.app/>
- Raycast: <https://www.raycast.com/>
- Responsive web design basics: <https://web.dev/articles/responsive-web-design-basics>
- Accessible tap targets: <https://web.dev/articles/accessible-tap-targets>
- prefers-color-scheme: <https://web.dev/articles/prefers-color-scheme>
- MDN prefers-color-scheme: <https://developer.mozilla.org/en-US/docs/Web/CSS/Reference/At-rules/@media/prefers-color-scheme>
- MDN color-scheme: <https://developer.mozilla.org/en-US/docs/Web/CSS/Reference/Properties/color-scheme>
