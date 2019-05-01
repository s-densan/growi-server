import sys
import urllib.request
import json
from typing import List, Dict, Tuple
from enum import Enum, auto

class WebhookMethod(Enum):
    Post = auto()
    Get = auto()
class WebhookContentsType(Enum):
    Json = auto()
    UrlEncoded = auto()

def main(args :List[str]) -> int:
    if len(args) <= 1:
        return 1
    message = args[1]
    urls = {
       'notify_slack_system' : 'https://hooks.slack.com/services/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',
    }
    data = create_slack_data(message)
    post_webhook(urls['notify_slack_system'], data)
def create_slack_data(text :str):
    return {"text": text}

def create_slack_attachment_data(attachments :List[Tuple[str, str, str]]):
    res = []
    for atc in attachments:
        res.append(
            {
                "fallback":"fallback Test",
                "pretext":atc[0],
                "color":"#D00000",
                "fields":[
                    {
                        "title":atc[1],
                        "value":atc[2]
                    }
                ]
            }
        )

    return { "attachments":atc }   

def post_webhook(url :str, data :Dict, 
    method :WebhookMethod = WebhookMethod.Post, 
    contents_type :WebhookContentsType = WebhookContentsType.Json):
    """
    See also: https://qiita.com/jun1_0803/items/95cec2f149bdec82472d
    :return:
    """

    if method == WebhookMethod.Post:
        method_str = 'POST'
    elif method == WebhookMethod.Get:
        method_str = 'GET'
    else:
        raise Exception(f'Unknown webhook method : {method}')

    if contents_type == WebhookContentsType.Json:
        headers = {"Content-Type": "application/json"}
        send_data = json.dumps(data).encode("utf-8")
    elif contents_type == WebhookContentsType.UrlEncoded:
        headers = {"Content-Type": "application/x-www-form-urlencoded"}
        send_data = '???'
    else:
        raise Exception(f'Unknown contents type : {contents_type}')


    request = urllib.request.Request(url, data=send_data, method=method_str, headers=headers)
    print(send_data)
    with urllib.request.urlopen(request) as response:
        response_body = response.read().decode("utf-8")
        print(response_body)


def get_ifttt_webhook_url(event_name, webhook_id):
    url = "https://maker.ifttt.com/trigger/" + event_name + "/with/key/" + webhook_id
    return url


if __name__ == "__main__":
    main(sys.argv)



