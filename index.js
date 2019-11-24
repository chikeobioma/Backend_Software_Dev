exports.handler = async (event) => {
    if (event.httpMethod === 'GET') {
        return getMovie(event);
    }
    if (event.httpMethod === 'POST'){
        return createNewMovie(event);
    }
};

const getMovie = event => {
    let movie = {
        title: 'Limitless',
        format: 'DVD',
        length: '01:30:56',
        releaseYear: 2018,
        rating: 4
    };
    return {
        statusCode: 200,
        body: JSON.stringify(movie)
    };
};

const createNewMovie = event => {
    let body = JSON.parse(event.body);
    console.log('This is the new movie that was just added', body);
    return {
        statusCode: 200,
        body: JSON.stringify({
            message: 'New movie successfully added'
        })
    };
};
