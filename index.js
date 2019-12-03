// exports.handler = async (event) => {
//     if (event.httpMethod === 'GET') {
//         return getMovie(event);
//     }
//     if (event.httpMethod === 'POST'){
//         return createNewMovie(event);
//     }
// };

// const getMovie = event => {
//     let movie = {
//         title: 'Limitless',
//         format: 'DVD',
//         length: '01:30:56',
//         releaseYear: 2018,
//         rating: 4
//     };
//     return {
//         statusCode: 200,
//         body: JSON.stringify(movie)
//     };
// };

// const createNewMovie = event => {
//     let body = JSON.parse(event.body);
//     console.log('This is the new movie that was just added', body);
//     return {
//         statusCode: 200,
//         body: JSON.stringify({
//             message: 'New movie successfully added'
//         })
//     };
// };

console.log('Starting Function');

const AWS = require('aws-sdk');
const docClient = new AWS.DynamoDB.DocumentClient({region: 'us-east-1'});

exports.handler = function(e, ctx, callback){
    
    var params = {
        Item: {
            MovieId: 2,
            Title: 'Face Off',
            Format: 'DVD',
            Length: '01:30:56',
            ReleaseYear: 1987,
            Ratings: 4
        },
        
        TableName: 'MovieCollection'
    };
    
    docClient.put(params, function(err, data){
        if(err){
            callback(err, null);
        } else {
            callback(null, data);
        }
    });
};