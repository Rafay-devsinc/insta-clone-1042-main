# README

# Insta-Clone-1042

Rails test project.

## Installation

Use the package manager [bundle](https://bundler.io) to install respective gems.

```bash
bundle install
```

## Details

A Instagram Cone which works mostly like an actual instagram social application. The app has following modules

- Users
  - User can Register on app and login.
  - User can have a display picture.
- Post

  - User can Post Images with caption on instagram
  - A user can delete/edit his/her own post.
  - A user can like his/others posts.

- Comments

  - A user can comment on his and others posts
  - A user can delete/edit his/her own comments.
  - A post can have many comments.
  - A user can edit/delete his/her comments on posts.

- Followers

  - Users can follow each other
  - User account can be set as private or public.
  - Private posts only be show when a follow request is accepted by the user

- Search
  - User can search other users.
  - User can follow/unfollow searched user

## Notes

- This project is deployed on Heroku with main branch.
- Main and testcases are the final 2 branches of the code.


For Running the K8s : Follow the commands folder in k8s folder and run those in terminal.


Jenkins Status:
[![Build Status](https://170b3039aabb.ngrok-free.app/job/Insta-clone-pipeline/badge/icon)](https://170b3039aabb.ngrok-free.app/job/Insta-clone-pipeline/)

