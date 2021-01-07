use blogger

// The users collection should contain the fields name and email. 
//For the field _id, use ObjectId instead of String.

function insertUser(
	id,
	name,
	email
	){
	db.users.insert(
		{_id: ObjectId(id),
			name : name,
			email : email
		});
}

// Create 3 users.
// _id =  “5bb26043708926e438db6cad"

insertUser("5bb26043708926e438db6cad", "Ozge", "ozge@gmail.com")

// _id = “5bb26043708926e438db6cae”

insertUser("5bb26043708926e438db6cae", "Huseyin", "huso@gmail.com")

// _id = “5bb26043708926e438db6caf"

insertUser("5bb26043708926e438db6caf", "Mary", "mary01@gmail.com")


// List the contents of the users collection in pretty form

db.users.find().pretty()

// Search for user 5bb26043708926e438db6cad

db.users.find(
{"_id" : ObjectId("5bb26043708926e438db6cad")
})


// Create 3 blogs with fields: 
//title, body, slug, author, comments 
//(array with objects containing user_id, comment, approved, created_at), and category (array with objects containing name)

function insertBlog(
	title, 
	body, 
	slug, 
	author, 
	comments, 
	category
	){
	db.blogs.insert(
		{title:title, 
			body:body, 
			slug:slug, 
			author: ObjectId(author), 
			comments:comments, 
			category:category
		});
}


insertBlog(
    "Building Websites",
    "Hugo is a general-purpose website framework. Websites built with Hugo are extremely fast",
    "The-world's-fastest-framework-for-building-websites",
    "5bb26043708926e438db6cad",
    [
        {
            user_id:ObjectId("5bb26043708926e438db6cae"),
            comment: "There are lots of free themes to built a website.",
            approved: true,
            created_at: ISODate("2020-10-02"),
        },
        {
            user_id:ObjectId("5bb26043708926e438db6caf"),
            comment: "I created github webpage using a Hugo theme.",
            approved: true,
            created_at: ISODate("2020-02-02"),
        },
        ],
    [
        {name: "Websites"},
        {name: "Free Themes"}
        ]
)

insertBlog(
	"How to make latte",
	"Add two teaspoons granulated coffee in boiled water, mix it and put some milk foam. It’s ready to drink",
	"Making-latte",
	"5bb26043708926e438db6cae",
	[
	{
		    user_id:ObjectId("5bb26043708926e438db6caf"),
            comment: "I tried this and didn't like it",
            approved: false,
            created_at: ISODate("2020-10-02"),

	},
	 {
            user_id:ObjectId("5bb26043708926e438db6cad"),
            comment: "Making coffee latte is easy",
            approved: true,
            created_at: ISODate("2020-10-01"),
        },
        ],
    [
        {name: "Recipe"},
        {name: "Coffee Latte"}

	]
	)


insertBlog(
	"Learning Turkish",
	"Watch some Turkish movies with its subtitles and make some Turkish friends to practice",
	"Learn-Turkish",
	"5bb26043708926e438db6caf",
	[
	{
		    user_id:ObjectId("5bb26043708926e438db6cad"),
            comment: "I watched some Turkish series",
            approved: false,
            created_at: ISODate("2020-10-02"),

	},
	 {
            user_id:ObjectId("5bb26043708926e438db6cae"),
            comment: "I have lots of Turkish friends",
            approved: true,
            created_at: ISODate("2020-04-02"),
        },
        ],
    [
        {name: "Learning"},
        {name: "Turkish"}

	]
	)

// Get all comments by User 5bb26043708926e438db6caf across all posts displaying only the title and slug

db.blogs.find(
    {'comments':{ $elemMatch:{'user_id':ObjectId('5bb26043708926e438db6caf')}}},
    {_id:0, title:1, slug:1, "comments.comment.$":1}
).pretty()


// Select a blog via a case-insensitive regular expression 
// containing the word Framework in the body displaying only the title and body

db.blogs.find({body: /framework/i},{_id:0,title:1,body:1})
