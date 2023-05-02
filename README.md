# Store images using `ActiveStorage`

### Store an image:
send a `POST` request on `/photos` with 
`{
  'caption': 'image-caption',
  'image': 'image-file'
}`

it stores the image after these validations and transformations:

#### Validations:
- 'caption' should be less than 100 characters
- 'image' should be attached
- 'image' format must be 'jpg', 'jpeg' or 'png'
- 'image' size should be less than 200KB

#### Transformations:
- 'image' is resized to 300 x 300
- 'image' filename is renamed to the `id` of the `Photo` record in the database

and it responds with a status code of `201` and JSON containing the newly created image record. for example: 

`{
        "id": 10,
        "caption": "nature",
        "image": "/rails/active_storage/blobs/redirect/aJlpmFpdf0/10.jpg"
    }`
    
### Get all images:

send a `GET` request on `/photos` and it will return an array of all stored images:

`[{
        "id": 1,
        "caption": "nature",
        "image": "/rails/active_storage/blobs/redirect/eyJfcmFpb/1.jpg"
    },
    {
        "id": 2,
        "caption": "nature",
        "image": "/rails/active_storage/blobs/redirect/kkufcmFpbH/2.jpg"
    }, ...]`
