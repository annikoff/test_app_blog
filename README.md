# Test application

[![Build Status](https://travis-ci.org/annikoff/test_app_blog.svg?branch=master)](https://travis-ci.org/annikoff/test_app_blog)
[![Code Climate](https://codeclimate.com/github/annikoff/test_app_blog/badges/gpa.svg)](https://codeclimate.com/github/annikoff/test_app_blog)
[![Test Coverage](https://codeclimate.com/github/annikoff/test_app_blog/badges/coverage.svg)](https://codeclimate.com/github/annikoff/test_app_blog/coverage)

### Test user data
- Email: user@example.com
- Password: 123456

### GET /api/v1/posts.json
```bash
curl http://<host>/api/v1/posts.json -u email:password
```

### POST /api/v1/posts.json
```bash
curl -v -H "Content-Type: application/json" -X POST --data-binary '{"title":"Title", "body":"Body"}' -u email:password http://0.0.0.0:3000/api/v1/posts.json
```

### PUT /api/v1/posts/:id.json
```bash
curl -v -H "Content-Type: application/json" -X PUT --data-binary '{"title":"New title"}' -u email:password http://0.0.0.0:3000/api/v1/posts/1.json
```

### GET /api/v1/posts/:id.json
```bash
curl http://<host>/api/v1/posts/1.json -u email:password
```

### DELETE /api/v1/posts/:id.json
```bash
curl -X DELETE http://<host>/api/v1/posts/1.json -u email:password
```
