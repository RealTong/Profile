// Variables used by Scriptable.
// These must be at the very top of the file. Do not edit.
// icon-color: red; icon-glyph: terminal;

// SubCounter.js for Scriptable: https://github.com/amirsaam/SubCounter-for-Scriptable

// Change NULL to your prefered Terminal username (only lowercase) you geek!
const user = "RealTong"

// Change NULL to your usernames
async function ErFunction() {
  return {
    github: await fetchData("github", "RealTong"),
    instagram: await fetchData("instagram", "RealTong1"),
    twitter: await fetchData("twitter", "Real_Tong1")
  }
}
// ErFunction is a work of Erfan Khavarian (https://github.com/ErFUN-KH)

const data = await ErFunction()
const widget = createWidget(data)
Script.setWidget(widget)
Script.complete()

function createWidget(data) {
  console.log(data)
  const w = new ListWidget()
  const bgColor = new LinearGradient()
  bgColor.colors = [new Color("#29323c"), new Color("#1c1c1c")]
  bgColor.locations = [0.0, 1.0]
  w.backgroundGradient = bgColor
  w.setPadding(12, 15, 15, 12)
  w.spacing = 6

  const time = new Date()
  const dfTime = new DateFormatter()
  dfTime.locale = "zh"
  dfTime.useMediumDateStyle()
  dfTime.useNoTimeStyle()
  
  // Terminal Logon
  const firstLine = w.addText(`${user}@here:~$ show my status`)
  firstLine.textColor = Color.white()
  firstLine.textOpacity = 0.7
  firstLine.font = new Font("Menlo", 11)
  // Today's Date
  const timeLine = w.addText(`[🗓] ${dfTime.string(time)}`)
  timeLine.textColor = Color.white()
  timeLine.font = new Font("Menlo", 11)
  // Phone's Battery State
  const batteryLine = w.addText(`[🔋] ${renderBattery()}`)
  batteryLine.textColor = new Color("#6ef2ae")
  batteryLine.font = new Font("Menlo", 11)
  // GitHub Follower Count
  const githubLine = w.addText(`[📟] GitHub: ${data.github}`)
  githubLine.textColor = new Color("#ff9468")
  githubLine.font = new Font("Menlo", 11)
  // Twitter Follower Count
  const twitterLine = w.addText(`[🐥] Twitter: ${data.twitter}`)
  twitterLine.textColor = new Color("#1DA1F2")
  twitterLine.font = new Font("Menlo", 11)
  
 return w
}

async function fetchData(source, key) {
  const url = `https://api.swo.moe/stats/${source}/${key}`
  const request = new Request(url)
  const res = await request.loadJSON()
  return res.count
}

function renderBattery() {
  const batteryLevel = Device.batteryLevel()
  const juice = "#".repeat(Math.floor(batteryLevel * 8))
  const used = ".".repeat(8 - juice.length)
  const batteryAscii = `${juice}${used} ${Math.round(batteryLevel * 100)}%`
  return batteryAscii
}