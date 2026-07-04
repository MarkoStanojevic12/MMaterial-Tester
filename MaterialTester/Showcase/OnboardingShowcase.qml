import QtQuick
import QtQuick.Layouts

import MMaterial.UI as UI
import MMaterial.Controls as Controls
import MMaterial.Controls.Inputs as Inputs
import MMaterial.Media as Media
import MMaterial.Onboarding as Onboarding

Item {
	id: root

	objectName: "Onboarding.Tour"

	function log(message) {
		eventLog.insert(0, { "line": message })
		if (eventLog.count > 7)
			eventLog.remove(7, eventLog.count - 7)
	}

	ListModel { id: eventLog }

	Onboarding.Tour {
		id: demoTour

		dismissOnOverlayClick: dismissSwitch.checked
		dimOpacity: dimSlider.value

		onStarted: root.log(qsTr("started()"))
		onFinished: root.log(qsTr("finished() — persist a 'seen' flag here"))
		onSkipped: (stepIndex) => root.log(qsTr("skipped(%1) — user dismissed").arg(stepIndex))
		onAborted: root.log(qsTr("aborted() — target lost, nothing persisted"))
		onCurrentStepChanged: {
			if (demoTour.currentStep)
				root.log(qsTr("entered: %1").arg(demoTour.currentStep.title))
		}

		Onboarding.TourStep {
			centered: true
			title: qsTr("Welcome to Wanderlust Travel")
			description: qsTr("A centered step needs no target — ideal for greetings. Every outcome fires its own signal: finishing, dismissing with X or Esc, or losing a target. Watch the event log as you go.")
			skipButtonText: qsTr("Skip demo")

			onSkipClicked: demoTour.stop()
		}

		Onboarding.TourStep {
			target: profileAvatar
			unionTarget: profileColumn
			title: qsTr("Union spotlight")
			description: qsTr("One step, two items — unionTarget merges the avatar and the text block into a single cutout.")
		}

		Onboarding.TourStep {
			id: bookClickStep

			target: bookButton
			title: qsTr("Forced interaction")
			description: qsTr("No Next button here — the tour waits until you actually click Book trip. Any signal can drive next().")
			allowInteraction: true
			nextButtonVisible: false
		}

		Onboarding.TourStep {
			target: bookingsTabButton
			title: qsTr("Steps drive the app")
			description: qsTr("This step's entered() switched the agency to the Bookings tab before the spotlight settled.")

			onEntered: mockContent.currentIndex = 1
		}

		Onboarding.TourStep {
			enabled: conditionalSwitch.checked
			target: conditionalRow
			title: qsTr("Conditional step")
			description: qsTr("This step only exists while its switch is on — disabled steps are skipped silently and the counter adjusts.")
		}

		Onboarding.TourStep {
			target: travelerField
			title: qsTr("Type freely")
			description: qsTr("allowInteraction lets you use the spotlit control while everything else stays blocked. Next when you are done.")
			allowInteraction: true

			onEntered: mockContent.currentIndex = 0
		}

		Onboarding.TourStep {
			target: deepListRow
			title: qsTr("Auto-scroll")
			description: qsTr("This destination was below the fold — the tour found the enclosing Flickable and scrolled just enough to reveal it.")

			onEntered: mockContent.currentIndex = 0
		}

		Onboarding.TourStep {
			target: statsCard
			padding: UI.Size.pixel24
			radius: UI.Size.pixel40
			title: qsTr("Custom stage")
			description: qsTr("Per-step padding and corner radius override the tour defaults for this cutout.")

			onEntered: mockContent.currentIndex = 0
		}

		Onboarding.TourStep {
			target: actionBar
			side: Onboarding.TourStep.Side.Top
			backButtonVisible: false
			title: qsTr("Placement hints")
			description: qsTr("Placement is automatic, but side can force it — this popover was told to sit on top. Back is hidden here, too.")
		}

		Onboarding.TourStep {
			centered: true
			title: qsTr("That's the tour")
			description: qsTr("Restart any time, try the one-off Highlight, or flip the switches in the control panel and run it again.")
		}
	}

	Onboarding.Highlight {
		id: quickHighlight

		target: statsCard
		title: qsTr("One-off highlight")
		description: qsTr("Highlight wraps a single-step tour — show() and hide() are all you need for a quick callout.")

		onFinished: root.log(qsTr("highlight finished()"))
		onSkipped: root.log(qsTr("highlight skipped()"))
	}

	RowLayout {
		anchors.fill: parent
		spacing: UI.Size.pixel24

		ColumnLayout {
			Layout.preferredWidth: 300 * UI.Size.scale
			Layout.maximumWidth: 340 * UI.Size.scale
			Layout.fillHeight: true
			spacing: UI.Size.pixel16

			UI.H6 { text: qsTr("Control panel") }

			Controls.MButton {
				Layout.fillWidth: true
				implicitHeight: UI.Size.pixel48
				text: qsTr("Start full tour")

				onClicked: demoTour.start()
			}

			Controls.MButton {
				Layout.fillWidth: true
				implicitHeight: UI.Size.pixel48
				type: Controls.MButton.Type.Outlined
				text: qsTr("Quick highlight")

				onClicked: {
					mockContent.currentIndex = 0
					quickHighlight.show()
				}
			}

			RowLayout {
				spacing: UI.Size.pixel12

				Controls.MSwitch {
					id: conditionalSwitch

					checked: true
				}

				UI.B2 {
					Layout.fillWidth: true
					text: qsTr("Conditional step (%1 of the tour)").arg(conditionalSwitch.checked ? qsTr("part") : qsTr("not part"))
					wrapMode: Text.Wrap
				}
			}

			RowLayout {
				spacing: UI.Size.pixel12

				Controls.MSwitch {
					id: dismissSwitch

					checked: false
				}

				UI.B2 {
					Layout.fillWidth: true
					text: qsTr("Dismiss on dim click")
					wrapMode: Text.Wrap
				}
			}

			ColumnLayout {
				Layout.fillWidth: true
				spacing: UI.Size.pixel4

				UI.Caption {
					text: qsTr("Dim opacity: %1").arg(dimSlider.value.toFixed(2))
					color: UI.Theme.text.secondary
				}

				Controls.MSlider {
					id: dimSlider

					Layout.fillWidth: true
					from: 0.3
					to: 0.9
					value: 0.65
				}
			}

			UI.H6 {
				Layout.topMargin: UI.Size.pixel8
				text: qsTr("Event log")
			}

			Rectangle {
				Layout.fillWidth: true
				Layout.fillHeight: true

				radius: UI.Size.pixel8
				color: UI.Theme.background.paper

				ColumnLayout {
					anchors {
						fill: parent
						margins: UI.Size.pixel12
					}
					spacing: UI.Size.pixel4

					Repeater {
						model: eventLog

						UI.Caption {
							required property string line
							required property int index

							Layout.fillWidth: true
							text: line
							elide: Text.ElideRight
							opacity: 1.0 - index * 0.12
							color: index === 0 ? UI.Theme.text.primary : UI.Theme.text.secondary
						}
					}

					Item { Layout.fillHeight: true }
				}
			}
		}

		Rectangle {
			id: mockApp

			readonly property bool tourActive: demoTour.running || quickHighlight.running

			Layout.fillWidth: true
			Layout.fillHeight: true

			radius: UI.Size.pixel16
			color: UI.Theme.background.paper

			ColumnLayout {
				anchors {
					fill: parent
					margins: UI.Size.pixel20
				}
				spacing: UI.Size.pixel16

				opacity: mockApp.tourActive ? 1 : 0.35
				enabled: mockApp.tourActive

				Behavior on opacity {
					NumberAnimation {
						duration: 250
						easing.type: Easing.InOutQuad
					}
				}

				RowLayout {
					Layout.fillWidth: true
					spacing: UI.Size.pixel12

					Controls.Avatar {
						id: profileAvatar

						size: UI.Size.pixel44
						title: "Mia Torres"
					}

					ColumnLayout {
						id: profileColumn

						spacing: UI.Size.pixel2

						UI.Subtitle2 { text: "Mia Torres" }

						UI.Caption {
							text: qsTr("Senior travel consultant")
							color: UI.Theme.text.secondary
						}
					}

					Item { Layout.fillWidth: true }

					Controls.Chip {
						text: qsTr("Wanderlust Travel")
						accent: UI.Theme.passive
						xButton.visible: false
					}

					Controls.MButton {
						id: bookButton

						implicitHeight: UI.Size.pixel40
						text: qsTr("Book trip")

						onClicked: {
							root.log(qsTr("Book trip clicked"))
							if (demoTour.currentStep === bookClickStep)
								demoTour.next()
						}
					}
				}

				RowLayout {
					spacing: UI.Size.pixel8

					Controls.MButton {
						id: destinationsTabButton

						text: qsTr("Destinations")
						size: UI.Size.Grade.S
						type: mockContent.currentIndex === 0 ? Controls.MButton.Type.Soft : Controls.MButton.Type.Text
						accent: mockContent.currentIndex === 0 ? UI.Theme.primary : UI.Theme.passive

						onClicked: mockContent.currentIndex = 0
					}

					Controls.MButton {
						id: bookingsTabButton

						text: qsTr("Bookings")
						size: UI.Size.Grade.S
						type: mockContent.currentIndex === 1 ? Controls.MButton.Type.Soft : Controls.MButton.Type.Text
						accent: mockContent.currentIndex === 1 ? UI.Theme.primary : UI.Theme.passive

						onClicked: mockContent.currentIndex = 1
					}

					Item { Layout.fillWidth: true }

					RowLayout {
						id: conditionalRow

						spacing: UI.Size.pixel8

						Media.Icon {
							iconData: Media.Icons.heavy.info
							size: UI.Size.pixel18
							color: UI.Theme.text.secondary.toString()
						}

						UI.Caption {
							text: qsTr("I am a conditional target")
							color: UI.Theme.text.secondary
						}
					}
				}

				StackLayout {
					id: mockContent

					Layout.fillWidth: true
					Layout.fillHeight: true
					currentIndex: 0

					ColumnLayout {
						spacing: UI.Size.pixel16

						RowLayout {
							Layout.fillWidth: true
							spacing: UI.Size.pixel16

							Rectangle {
								id: statsCard

								Layout.fillWidth: true
								Layout.preferredHeight: 110 * UI.Size.scale

								radius: UI.Size.pixel12
								color: UI.Theme.background.main

								ColumnLayout {
									anchors {
										fill: parent
										margins: UI.Size.pixel16
									}
									spacing: UI.Size.pixel8

									UI.Caption {
										text: qsTr("Trips booked this year")
										color: UI.Theme.text.secondary
									}

									UI.H6 { text: "1,284" }

									Controls.MProgressBar {
										Layout.fillWidth: true
										progress: 72
									}
								}
							}

							Rectangle {
								Layout.fillWidth: true
								Layout.preferredHeight: 110 * UI.Size.scale

								radius: UI.Size.pixel12
								color: UI.Theme.background.main

								ColumnLayout {
									anchors {
										fill: parent
										margins: UI.Size.pixel16
									}
									spacing: UI.Size.pixel8

									UI.Caption {
										text: qsTr("Traveler satisfaction")
										color: UI.Theme.text.secondary
									}

									UI.H6 { text: "4.9 / 5" }

									Controls.MProgressBar {
										Layout.fillWidth: true
										progress: 98
									}
								}
							}
						}

						Inputs.TextField {
							id: travelerField

							Layout.fillWidth: true

							implicitHeight: UI.Size.pixel48
							placeholderText: qsTr("Traveler name — type during the tour")
							type: Inputs.TextField.Type.Outlined
						}

						Flickable {
							id: destinationsList

							Layout.fillWidth: true
							Layout.fillHeight: true

							contentHeight: destinationsColumn.implicitHeight
							clip: true

							ColumnLayout {
								id: destinationsColumn

								width: destinationsList.width
								spacing: UI.Size.pixel8

								Repeater {
									model: [qsTr("Bali, Indonesia"), qsTr("Kyoto, Japan"), qsTr("Lisbon, Portugal"), qsTr("Marrakesh, Morocco"), qsTr("Reykjavik, Iceland"), qsTr("Cusco, Peru"), qsTr("Queenstown, New Zealand"), qsTr("Amalfi Coast, Italy")]

									Rectangle {
										id: destinationRow

										required property string modelData

										Layout.fillWidth: true
										Layout.preferredHeight: UI.Size.pixel40

										radius: UI.Size.pixel8
										color: UI.Theme.background.main

										UI.B2 {
											anchors {
												verticalCenter: parent.verticalCenter
												left: parent.left
												leftMargin: UI.Size.pixel12
											}
											text: destinationRow.modelData
											color: UI.Theme.text.secondary
										}
									}
								}

								Rectangle {
									id: deepListRow

									Layout.fillWidth: true
									Layout.preferredHeight: UI.Size.pixel40

									radius: UI.Size.pixel8
									color: UI.Theme.primary.transparent.p8

									UI.B2 {
										anchors {
											verticalCenter: parent.verticalCenter
											left: parent.left
											leftMargin: UI.Size.pixel12
										}
										text: qsTr("Santorini, Greece — the tour scrolls me into view")
									}
								}

								Repeater {
									model: [qsTr("Banff, Canada"), qsTr("Petra, Jordan"), qsTr("Hoi An, Vietnam"), qsTr("Valparaiso, Chile")]

									Rectangle {
										id: tailDestinationRow

										required property string modelData

										Layout.fillWidth: true
										Layout.preferredHeight: UI.Size.pixel40

										radius: UI.Size.pixel8
										color: UI.Theme.background.main

										UI.B2 {
											anchors {
												verticalCenter: parent.verticalCenter
												left: parent.left
												leftMargin: UI.Size.pixel12
											}
											text: tailDestinationRow.modelData
											color: UI.Theme.text.secondary
										}
									}
								}
							}
						}
					}

					ColumnLayout {
						spacing: UI.Size.pixel8

						Repeater {
							model: [qsTr("Flight confirmed for the Rossi family"), qsTr("Hotel booked in Kyoto — 4 nights"), qsTr("Island-hopping itinerary sent to M. Chen"), qsTr("Payment received for the Iceland tour")]

							RowLayout {
								id: activityRow

								required property string modelData

								Layout.fillWidth: true
								spacing: UI.Size.pixel8

								Controls.BadgeDot { pixelSize: UI.Size.pixel10 }

								UI.B2 {
									Layout.fillWidth: true
									text: activityRow.modelData
									color: UI.Theme.text.secondary
								}
							}
						}

						Item { Layout.fillHeight: true }
					}
				}

				Rectangle {
					id: actionBar

					Layout.alignment: Qt.AlignHCenter
					Layout.preferredWidth: actionBarRow.implicitWidth + UI.Size.pixel32
					Layout.preferredHeight: UI.Size.pixel48

					radius: UI.Size.pixel12
					color: UI.Theme.background.main

					RowLayout {
						id: actionBarRow

						anchors.centerIn: parent
						spacing: UI.Size.pixel8

						Repeater {
							model: [qsTr("Search"), qsTr("Quote"), qsTr("Itinerary"), qsTr("Share"), qsTr("Support")]

							Controls.MButton {
								id: actionButton

								required property string modelData

								text: actionButton.modelData
								size: UI.Size.Grade.S
								type: Controls.MButton.Type.Text
								accent: UI.Theme.passive

								onClicked: root.log(qsTr("%1 clicked").arg(actionButton.modelData))
							}
						}
					}
				}
			}

			Rectangle {
				anchors.centerIn: parent

				visible: !mockApp.tourActive
				width: hintLabel.implicitWidth + UI.Size.pixel32
				height: hintLabel.implicitHeight + UI.Size.pixel16
				radius: height / 2
				color: UI.Theme.background.main

				UI.Subtitle2 {
					id: hintLabel

					anchors.centerIn: parent
					text: qsTr("Start the tour or the highlight to bring this demo to life")
					color: UI.Theme.text.secondary
				}
			}
		}
	}
}
