-- Run in Supabase SQL Editor after creating your project.
-- Creates a private storage bucket and policies so each signed-in user can only
-- list, upload, download (through signed URLs), and delete files in their own folder.
-- File path format: <auth user UUID>/<filename>

insert into storage.buckets (id, name, public, file_size_limit, allowed_mime_types)
values (
  'private-documents',
  'private-documents',
  false,
  10485760,
  array[
    'application/pdf',
    'image/jpeg',
    'image/png',
    'image/webp',
    'application/msword',
    'application/vnd.openxmlformats-officedocument.wordprocessingml.document',
    'application/vnd.openxmlformats-officedocument.spreadsheetml.sheet'
  ]
)
on conflict (id) do update
set public = false,
    file_size_limit = 10485760,
    allowed_mime_types = excluded.allowed_mime_types;

create policy "Users can list files in own folder"
on storage.objects for select
to authenticated
using (
  bucket_id = 'private-documents'
  and (storage.foldername(name))[1] = auth.uid()::text
);

create policy "Users can upload files to own folder"
on storage.objects for insert
to authenticated
with check (
  bucket_id = 'private-documents'
  and (storage.foldername(name))[1] = auth.uid()::text
);

create policy "Users can delete files in own folder"
on storage.objects for delete
to authenticated
using (
  bucket_id = 'private-documents'
  and (storage.foldername(name))[1] = auth.uid()::text
);
