import WidgetKit
import SwiftUI

private let appGroupId = "group.com.oshimemo.oshiMemo"

struct OshiMemoEntry: TimelineEntry {
    let date: Date
    let nextEventTitle: String
    let nextEventDays: String
    let latestVideoTitle: String
    let latestOshiName: String
    let birthdayText: String
    let unreadCount: Int
}

struct OshiMemoProvider: TimelineProvider {
    func placeholder(in context: Context) -> OshiMemoEntry {
        OshiMemoEntry(
            date: Date(),
            nextEventTitle: "ライブイベント",
            nextEventDays: "あと3日",
            latestVideoTitle: "新着動画タイトル",
            latestOshiName: "推しの名前",
            birthdayText: "誕生日まで 7 日",
            unreadCount: 2
        )
    }

    func getSnapshot(in context: Context, completion: @escaping (OshiMemoEntry) -> Void) {
        completion(readEntry())
    }

    func getTimeline(in context: Context, completion: @escaping (Timeline<OshiMemoEntry>) -> Void) {
        let entry = readEntry()
        let nextUpdate = Calendar.current.date(byAdding: .minute, value: 30, to: Date())!
        completion(Timeline(entries: [entry], policy: .after(nextUpdate)))
    }

    private func readEntry() -> OshiMemoEntry {
        let defaults = UserDefaults(suiteName: appGroupId)
        return OshiMemoEntry(
            date: Date(),
            nextEventTitle: defaults?.string(forKey: "next_event_title") ?? "予定なし",
            nextEventDays: defaults?.string(forKey: "next_event_days") ?? "-",
            latestVideoTitle: defaults?.string(forKey: "latest_video_title") ?? "動画なし",
            latestOshiName: defaults?.string(forKey: "latest_oshi_name") ?? "",
            birthdayText: defaults?.string(forKey: "birthday_text") ?? "",
            unreadCount: defaults?.integer(forKey: "unread_count") ?? 0
        )
    }
}

struct OshiMemoWidgetView: View {
    var entry: OshiMemoEntry

    var body: some View {
        ZStack {
            LinearGradient(
                colors: [Color(red: 0.04, green: 0.04, blue: 0.1), Color(red: 0.1, green: 0.1, blue: 0.18)],
                startPoint: .topLeading,
                endPoint: .bottomTrailing
            )

            VStack(alignment: .leading, spacing: 8) {
                HStack {
                    Text("OshiMemo")
                        .font(.caption)
                        .fontWeight(.bold)
                        .foregroundColor(Color(red: 1, green: 0.42, blue: 0.62))
                    Spacer()
                    if entry.unreadCount > 0 {
                        Text("\(entry.unreadCount)")
                            .font(.caption2)
                            .fontWeight(.bold)
                            .padding(.horizontal, 6)
                            .padding(.vertical, 2)
                            .background(Color(red: 1, green: 0.18, blue: 0.47))
                            .clipShape(Capsule())
                            .foregroundColor(.white)
                    }
                }

                VStack(alignment: .leading, spacing: 2) {
                    Text("次のイベント")
                        .font(.caption2)
                        .foregroundColor(.white.opacity(0.6))
                    Text(entry.nextEventTitle)
                        .font(.subheadline)
                        .fontWeight(.semibold)
                        .foregroundColor(.white)
                        .lineLimit(1)
                    Text(entry.nextEventDays)
                        .font(.caption)
                        .foregroundColor(Color(red: 0.42, green: 0.31, blue: 1))
                }

                if !entry.birthdayText.isEmpty {
                    Text(entry.birthdayText)
                        .font(.caption2)
                        .foregroundColor(Color(red: 1, green: 0.42, blue: 0.62))
                        .lineLimit(1)
                }

                Divider().background(Color.white.opacity(0.2))

                VStack(alignment: .leading, spacing: 2) {
                    Text("新着動画")
                        .font(.caption2)
                        .foregroundColor(.white.opacity(0.6))
                    Text(entry.latestVideoTitle)
                        .font(.caption)
                        .foregroundColor(.white)
                        .lineLimit(2)
                    if !entry.latestOshiName.isEmpty {
                        Text(entry.latestOshiName)
                            .font(.caption2)
                            .foregroundColor(Color(red: 1, green: 0.42, blue: 0.62))
                    }
                }
            }
            .padding()
        }
    }
}

struct OshiMemoWidget: Widget {
    let kind: String = "OshiMemoWidget"

    var body: some WidgetConfiguration {
        StaticConfiguration(kind: kind, provider: OshiMemoProvider()) { entry in
            OshiMemoWidgetView(entry: entry)
                .containerBackground(for: .widget) {
                    Color(red: 0.04, green: 0.04, blue: 0.1)
                }
        }
        .configurationDisplayName("OshiMemo")
        .description("次のイベント・新着動画・誕生日を表示")
        .supportedFamilies([.systemSmall, .systemMedium])
    }
}

@main
struct OshiMemoWidgetBundle: WidgetBundle {
    var body: some Widget {
        OshiMemoWidget()
    }
}
