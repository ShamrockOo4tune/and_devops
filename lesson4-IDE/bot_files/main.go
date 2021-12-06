package main
import (
  "net/http"
  "io/ioutil"
  "encoding/json"
  "fmt"
  "log"
  "bytes"
  "strconv"
  "strings"
  "regexp"
)

func main() {
  botApi := "https://api.telegram.org/bot"
  botUrl := botApi + botToken
  offset := 0
  for ;; {
    updates, err := getUpdates(botUrl, offset) //Fetch new updates from bot
    if err != nil {
      log.Println("Something went wrong: ", err.Error())
    }
    for _, update := range updates {
      err = respond(botUrl, update) //Send reply to bot
      offset = update.UpdateId + 1
    }
    fmt.Println(updates)
  }
}


func getUpdates(botUrl string, offset int) ([]Update, error) {
  resp, err := http.Get(botUrl + "/getUpdates" + "?offset=" + strconv.Itoa(offset))
  if err != nil {
    return nil, err
  }
  defer resp.Body.Close()
  body, err := ioutil.ReadAll(resp.Body)
  if err != nil {
    return nil, err
  }
  var restResponse RestResponse
  err = json.Unmarshal(body, &restResponse)
  if err != nil {
    return nil, err
  }
  return restResponse.Result, nil
}


func respond(botUrl string, update Update) (error) {
  var botMessage BotMessage
  botMessage.ChatId = update.Message.Chat.ChatId

  // Depending on on users message in chat:
  if update.Message.Text == "Git" {
    link := "https://github.com/" + githubAccount + "/" + githubRepo
    linkResponse, _ := http.Get(link)
    if linkResponse.StatusCode != 200 {
      botMessage.Text = "Something went wrong with internet, invalid githubAccount= " + githubAccount + " or invalid githubRepo= " + githubRepo
      log.Println(botMessage.Text)
    } else {
      botMessage.Text = link
    }

  } else if update.Message.Text == "Tasks" {
    botMessage.Text = "Task #: Directory Name:\n"
    for i, name := range get_tasks() {
      botMessage.Text += ("Task" + strconv.Itoa(i+1) + ":\t" + name + "\n")
    }
    if botMessage.Text == "Task #: Directory Name:\n" {
      botMessage.Text = "No tasks has been found in this repo: " + githubRepo
    }

  } else if (strings.HasPrefix(update.Message.Text, "Task") && regexp.MustCompile(`Task[1-9][0-9]*$`).FindString(update.Message.Text) == update.Message.Text) {
    taskNo, _  := strconv.Atoi(update.Message.Text[4:])
    botMessage.Text = getDirLink(taskNo)

  } else {
    botMessage.Text = "I don`t know what does \"" + update.Message.Text + "\" mean.\nPlease try: \"Git\" or \"Tasks\" or \"Task1\""
  }

  buf, err := json.Marshal(botMessage)
  if err != nil {
    return err
  }
  _, err = http.Post(botUrl + "/sendMessage", "application/json", bytes.NewBuffer(buf))
  if err != nil {
    return err
  }
  return nil
}

func get_repo_contents() ([]ContentObj) {
  responce, _ := http.Get("https://api.github.com/repos/" + githubAccount + "/" + githubRepo + "/contents")
  responce_body, _ := ioutil.ReadAll(responce.Body)
  responce.Body.Close()
  var contents []ContentObj
  _ = json.Unmarshal(responce_body, &contents)
  return contents
}

func get_tasks() ([]string) {
  var object_list []string
  for _, object := range get_repo_contents() {
    if object.Type == "dir" {
      object_list = append(object_list, object.Name)
    }
  }
  return object_list
}

func getDirLink(taskNo int) (dirLink string) {
  var object_url []string
  for _, object := range get_repo_contents() {
    if object.Type == "dir" {
      object_url = append(object_url, object.HTMLURL)
    }
  }
  if len(object_url) >= taskNo {
    return object_url[taskNo-1]
  } else {
    return "no Task" + strconv.Itoa(taskNo) + " has has been found in this repo: " + githubRepo
  }
}
