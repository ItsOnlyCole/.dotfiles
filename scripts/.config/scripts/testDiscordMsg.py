# web library
import http.client


def send(message):
    # your webhook URL for notifications channel on BDE
    webhookurl = "https://discordapp.com/api/webhooks/617937086091362315/KCpLOhQ1eH5Imp2v4pKdqWimhNQHxH7DjZZbuQQozTJlVX1DdfWtdaRZZroveN8_2a4-"

    # compile the form data (BOUNDARY can be anything)
    formdata = "------:::BOUNDARY:::\r\nContent-Disposition: form-data; name=\"content\"\r\n\r\n" + message + "\r\n------:::BOUNDARY:::--"

    # get the connection and make the request
    connection = http.client.HTTPSConnection("discordapp.com")
    connection.request("POST", webhookurl, formdata, {
        'content-type': "multipart/form-data; boundary=----:::BOUNDARY:::",
        'cache-control': "no-cache",
        })

    # get the response
    response = connection.getresponse()
    result = response.read()

    # return back to the calling function with the result
    return result.decode("utf-8")


# send the messsage and print the response
send("<@313457905397530634> I love you mi amor!!! <3")
