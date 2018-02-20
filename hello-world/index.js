exports.handler = function (event, context, callback) {

    var stage = process.env.STAGE;

    callback(null, {
        statusCode: '200',
        body: 'Hello World!, from ' + process.env.STAGE + ' environment',
        headers: {
            'Content-Type': 'text/html; charset=utf-8'
        }
    })

}
