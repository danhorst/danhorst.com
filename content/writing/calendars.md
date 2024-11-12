---
title: "Calendars"
date: 2024-11-07T17:54:03-05:00
---

I am a recovering productivity nerd with a keen sense of my own mortality that spends time with computer systems professionally.
Because of this, I've accumulated opinions about dates and calendars.

- Dates should be written in [ISO 8601 format][1] e.g. 2024-12-31.
	- The `year-month-day` order eliminates any ambiguity between `month/day/year` and `day/month/year`.
	- `year-month-day` strings are sorted the same both alphabetically and chronologically; n.b. prefixing filenames with dates is a great way to help organize data.
- Weeks are the most useful unit of time.[^1] Months are too long to go without a recap. Days are too short to identify any trends. The _week number_ helps anchor it in context; I track two:
	- The current year e.g. 2024 WK 45
		- This can be displayed in calendaring software:
			- MacOS Calendar: Settings > Advanced > Show week numbers
			- Google Calendar: Gear Menu > Settings > General > Language and region > View options > Show week numbers
			- Outlook (Mac): Outlook Settings > Other: Calendar > Calendar Options: Show week numbers
			- Fantastical (iOS): Settings > Calendar Views > Calendar Weeks
	- The week of my life e.g. 2167 (of [about 4000][2]). I was born on a Friday so I increment my "death clock" week number at the end of the workweek.
- Weeks start on _Monday_.
	- This best reflects the rhythms of school, 9–5 office work, and similar job schedules.
	- It keeps the days of the weekend together on the right hand side of a 7-day calendar view making it easier to plan your weekend as a contiguous chunk of time. This reduces context switching when toggling between 5-day (work) and 7-day (personal) week views.
	- There is wide support for starting the week on Monday in modern computer and phone operating systems.
		- MacOS: System Settings > Language & Region > First day of the week
		- iOS: Settings > General > Language & Region > First day of the week
		- Google Calendar: Gear Menu > Settings > General > Language and region > View options > Start week on
		- Outlook (Mac): Outlook Settings > Other: Calendar > Work Schedule: First day of week
		- Fantastical (iOS): Settings > Calendar Views > Start Week On
	- You can configure the [Periodic Notes plugin][3] for [Obsidian][4] to support creating notes like this by setting the Format for Weekly Notes to `YYYY/MM/YYYY [WK]ww`.
- Months are not long enough for long-term planning. If you need to execute a strategy or manage a long-running project, use a [one-page year-long compact calendar][5].
	- There is an Excel template that does the heavy lifting. I customize mine to include both types my week numbers and work-specific times e.g. quarters or [program increments][6].
- Calendaring, like note-taking, benefits from being _physically tangible_. You don't have to [draw your calendars from scratch][7] (although that can be satisfying); printing out a [compact calendar][5] and annotating it by hand works well.
	- Even though it doesn't employ my preferred calendaring conventions, I have a soft spot for the [Field Notes 15-Month Work Station Calendar][8].
	- If your _days_ are extremely busy, then I've had good results using the [Emergent Task Planner][9] (sadly out of print; you can print your own).

I'll leave thoughts on _time_ and _task management_ for another day.

[^1]: For time management anyway; the most useful unit of time for _doing_ is [20 minutes][10].

[1]: https://en.wikipedia.org/wiki/ISO_8601
[2]: https://www.oliverburkeman.com/fourthousandweeks
[3]: https://github.com/liamcain/obsidian-periodic-notes
[4]: https://obsidian.md/
[5]: https://davidseah.com/node/compact-calendar/
[6]: https://v5.scaledagileframework.com/program-increment/
[7]: https://uxdesign.cc/drawing-the-calendar-2bfc9612bb04
[8]: https://fieldnotesbrand.com/products/workstation-wall-calendar
[9]: https://davidseah.com/node/the-emergent-task-planner/
[10]: https://en.wikipedia.org/wiki/Pomodoro_Technique
