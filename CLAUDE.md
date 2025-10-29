# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Project Overview

Nathan Hessler's personal portfolio website for nathanhessler.com. Built with:

- **Astro 4.x** as the static site generator
- **Svelte** for interactive components (when needed)
- **Tailwind CSS** for styling (brutalist/experimental aesthetic to start)
- **Blog** with RSS feed (Markdown)
- **Presentations** as archived talks (various frameworks: reveal.js, marp, etc.)
- **Resume integration** on index/portfolio page
- **Cloudflare Pages** for deployment

## Repository Structure

```
nhessler.github.io/
├── site/                           # Main Astro website
│   ├── src/
│   │   ├── pages/
│   │   │   ├── index.astro         # Landing page + resume integration
│   │   │   ├── blog/               # Blog pages
│   │   │   │   ├── index.astro     # Blog listing
│   │   │   │   ├── [slug].astro    # Individual blog posts
│   │   │   │   └── rss.xml.js      # RSS feed
│   │   │   └── talks/
│   │   │       └── index.astro     # Talks archive/listing
│   │   ├── content/
│   │   │   ├── config.js           # Content collections config
│   │   │   └── blog/*.md           # Blog posts in Markdown
│   │   ├── data/
│   │   │   └── talks.json          # Talk metadata + published status
│   │   ├── components/             # Reusable Astro/Svelte components
│   │   ├── layouts/                # Page layouts
│   │   └── styles/
│   │       └── global.css          # Tailwind imports
│   ├── public/
│   │   └── fonts/homestead/        # Custom Homestead fonts (6 variants)
│   ├── package.json
│   ├── astro.config.mjs
│   └── svelte.config.js
│
├── talks/                          # Individual presentations
│   ├── talk-YYYY-name/             # Each talk is self-contained
│   │   ├── package.json            # Own dependencies/versions
│   │   ├── index.html
│   │   └── slides/
│   └── (more talks...)
│
├── dist/                           # Build output (gitignored)
│   ├── index.html                  # From site/
│   ├── blog/                       # From site/
│   ├── talks/
│   │   ├── index.html              # From site/ (listing page)
│   │   ├── YYYY-name/              # From talks/talk-YYYY-name/
│   │   └── (more talks...)
│   └── rss.xml
│
├── build-scripts/
│   └── build-all.sh                # Master build script
│
├── package.json                    # Root convenience scripts
├── .gitignore
└── CLAUDE.md
```

## Development Workflow

### Working on the Main Site

```bash
# From repo root
npm run dev

# Or manually
cd site
npm run dev
# Runs on localhost:4210
# Access via nathanhessler.test (Caddy) or localhost:4210
```

### Working on a Presentation

Presentations are developed one at a time and archived after giving the talk. Each talk can use different frameworks/versions.

```bash
cd talks/talk-2024-example
npm install
npm run dev
# Runs on localhost:8080 (or configured port)
# Point presentation.test → localhost:8080 in Caddy
```

**Important**: Configure each talk to use the same port (8080) since only one talk is worked on at a time. Set this in each talk's `package.json`:

```json
{
  "scripts": {
    "dev": "reveal-md slides.md --port 8080"
  }
}
```

### Publishing a Talk

1. Create talk folder in `talks/talk-YYYY-name/`
2. Develop with full git history (commit, branch, experiment freely)
3. When ready to publish, add entry to `site/src/data/talks.json`:

```json
{
  "talks": [
    {
      "id": "2024-example",
      "title": "My Talk Title",
      "date": "2024-10-15",
      "event": "Conference Name",
      "location": "City, State",
      "description": "Talk description",
      "published": true,
      "folder": "talk-2024-example",
      "slidesPath": "/talks/2024-example/",
      "pdfPath": "/talks/2024-example/slides.pdf"
    }
  ]
}
```

4. Build and deploy (talk-specific build script will be created when first talk is ready)

## Build Process

### Full Build for Deployment

```bash
npm run build
# Runs ./build-scripts/build-all.sh
# 1. Builds main Astro site → site/dist/
# 2. Copies to root dist/
# 3. Builds published talks (when build script exists)
# 4. Copies each talk to dist/talks/<talk-id>/
```

### Build Output Structure

- **Site generates**: `dist/talks/index.html` (the talks listing page)
- **Build script adds**: `dist/talks/2024-example/index.html` (actual slides)
- **No conflict**: Different paths entirely

### URLs After Deploy

- `/` - Landing page with resume integration
- `/blog/` - Blog index
- `/blog/post-slug/` - Individual blog posts
- `/rss.xml` - RSS feed
- `/talks/` - Archive of all published talks
- `/talks/2024-example/` - Individual presentation slides

## Key Concepts

### Presentations as Time Capsules

Each presentation is a snapshot in time:
- Built with specific version of framework (reveal.js v3, marp v2, etc.)
- Self-contained with own dependencies in package.json
- Never needs updating after talk is given
- May receive minor tweaks but unlikely to change frameworks
- Lives in `talks/` folder with full git history
- Only works on one talk at a time during development

### Published vs Unpublished Talks

- **Unpublished**: Exists in `talks/` folder but `"published": false` in talks.json (or not listed)
- Can develop, commit, and iterate without appearing on website
- **Published**: When `"published": true` in `site/src/data/talks.json`, gets built and deployed
- Useful for working on talks before they're given publicly

### Custom Fonts

The site uses custom Homestead fonts (6 variants) in `site/public/fonts/homestead/`:
- Homestead Regular, Display, Inline, One, Two, Three
- Render correctly in Safari but may have issues in Chrome/Firefox
- Consider using for headings/hero elements only
- Pair with reliable body font for cross-browser consistency

## Technology Stack

- **Framework**: Astro 4.x (static site generator with islands architecture)
- **Components**:
  - `.astro` files for static/SSR components (primary)
  - `.svelte` files for client-side interactivity (when needed)
- **Styling**: Tailwind CSS 4.x
- **Content**: Markdown for blog posts (can upgrade to MDX if interactive components needed)
- **Language**: JavaScript (no TypeScript in user code)
- **Package Manager**: npm
- **Deployment**: Cloudflare Pages
- **Local Dev**: Caddy for domain routing (nathanhessler.test, presentation.test)

## Development Commands

```bash
# Root-level convenience commands
npm run dev          # Start site dev server (cd site && npm run dev)
npm run build        # Run full build script
npm run preview      # Preview built site

# Site-specific
cd site
npm run dev          # Astro dev server on :4210
npm run build        # Build site only to site/dist/
npm run preview      # Preview production build

# Individual talk
cd talks/talk-YYYY-name
npm run dev          # Talk-specific dev server (framework-dependent)
npm run build        # Build talk to dist/
```

## Git Workflow

This project uses the **git-pretty-accept** merge workflow for feature branches. See `~/.claude/skills/git-pretty-accept.md` for details.

Small fixes can be committed directly to main when appropriate.

## Deployment

**Cloudflare Pages** configuration:
- Build command: `npm run build` (runs build-scripts/build-all.sh)
- Output directory: `dist`
- Branch: `main`
- Node version: 18+ (or latest LTS)

Push to main branch triggers automatic deployment.

## Design Philosophy

- **Brutalist/experimental aesthetic** to start
- **Potential multi-theme system** in future (same content, different styles via JS/CSS)
- **Tailwind CSS** for utility-first styling
- **Tailwind UI components** available as reference
- **Modern, clean architecture** with clear separation of concerns

## Notes for Development

- **Blog posts**: Use Markdown, can upgrade specific posts to MDX for interactive components
- **RSS feed**: Auto-generated from blog content collection at `/rss.xml`
- **Resume integration**: Approach TBD based on creative vision (interactive timeline? embedded PDF? structured sections?)
- **Theme switching**: Future consideration, not v1
- **Git history**: Preserved for fonts via `git mv`, maintain history for all major files
- **Working directory**: Stay at repo root, use relative paths or explicit `cd` when needed
