package main

type Update struct {
  UpdateId int		`json:"update_id"`
  Message Message	`json:"message"`
}

type Message struct {
  Chat Chat		`json:"chat"`
  Text string		`json:"text"`
}

type Chat struct {
  ChatId int		`json:"id"`
}

type RestResponse struct {
  Result []Update	`json:"result"`
}

type BotMessage struct {
  ChatId int		`json:"chat_id"`
  Text string		`json:"text"`
}

type ContentObj struct {
  Name string           `json:"name"`
  Path string           `json:"path"`
  SHA string            `json:"sha"`
  Size int              `json:"size"`
  URL string            `json:"url"`
  HTMLURL string        `json:"html_url"`
  GitURL string         `json:"git_url"`
  DownloadURL string    `json:"download_url"`
  Type string           `json:"type"`
  Links Links           `json:"_links"`
}

type Links struct {
  Self string   `json:"self"`
  Git string    `json:"git"`
  HTML string   `json:"html"`
}
