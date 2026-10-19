# Arjoo Gautam — Secure Website Starter

A blue-and-white responsive personal portfolio and student-document portal. Includes profile/photo preview, About section, gallery preview, contact mail link, and Supabase Auth + private Storage integration scaffold.

## 1. Add your photo
Open the website, choose **Upload your photo**, and select your image. That photo preview is local to the current browser session. For a permanent public profile image, host it in a storage service and wire it to your profile settings before launch.

## 2. Create a Supabase project
1. Create a project at https://supabase.com/.
2. In Project Settings → API, copy the **Project URL** and the **publishable/anon public key**.
3. Put those values into `config.js` as `supabaseUrl` and `supabaseAnonKey`. These browser keys are intended to be public. **Never use a service-role key or database password in browser files.**
4. In Authentication settings, set your allowed site URL and redirect URLs to your eventual deployed site.
5. For account creation, configure email confirmation and SMTP as appropriate for your needs.

## 3. Create private document storage
1. In the Supabase dashboard, open SQL Editor.
2. Run the contents of `supabase-storage-policies.sql`.
3. Confirm the `private-documents` bucket is marked **private**.
4. Test with two separate user accounts: each account should only see its own files.
5. Use real private documents only after you have confirmed the policies and access rules.

The starter applies a 10 MB per-file limit and allows PDF, common image, DOC/DOCX and XLSX types. Change these limits intentionally if needed. The browser requests signed URLs that expire after 60 seconds for downloads.

## 4. Run and publish
- Quick local preview: open `index.html` in a modern browser. Authentication won't work until `config.js` is configured.
- Recommended simple hosting: Netlify, Cloudflare Pages, or GitHub Pages. Upload the site files (or connect a repository) and publish. These are static hosting options; Supabase supplies authentication and private storage.
- Add your deployed domain to Supabase Authentication URL configuration.
- Keep `index.html`, `style.css`, `script.js`, and `config.js` in the same folder.

## Important security notes
- This is a starter scaffold, not a professionally audited system. Review and test all storage policies before uploading personal IDs, marksheets, or other sensitive files.
- Use a unique strong password, email confirmation, HTTPS hosting, and two-factor authentication for your hosting/Supabase accounts.
- Public profile content and gallery preview are not private. Do not publish private IDs or certificates in a public website directory.
- The gallery/photo upload currently uses local browser previews only; it does not persist photos. A production public gallery needs its own storage bucket and explicit public/private policies.
- Contact form opens the visitor's email app; it does not send or store messages by itself.
