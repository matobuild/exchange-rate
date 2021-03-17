//
//  SettingViewController.swift
//  exchange rate
//
//  Created by kittawat phuangsombat on 2020/12/31.
//

import UIKit

class SettingViewController: UITableViewController {
  var defaults = UserDefaults.standard
  
  @IBOutlet weak var darkModeLabel: UISwitch!
  @IBAction func darkModeSwitch(_ sender: Any) {
    if darkModeLabel.isOn{
      let darkModeEnabled = true
      configureStyle(for: darkModeEnabled)
    }else{
      let darkModeEnabled = false
      configureStyle(for: darkModeEnabled)
    }
  }
  
  override func viewDidLoad() {
    super.viewDidLoad()
    let darkModeEnabled = defaults.bool(forKey: "darkModeEnabled")
    switch darkModeEnabled {
    case true:
      darkModeLabel.isOn = true
    case false:
      darkModeLabel.isOn = false
    }
  }

private func configureStyle(for setting: Bool) {
  defaults.set(setting, forKey: "darkModeEnabled")
  switch setting {
  case true:
    view.window?.overrideUserInterfaceStyle = .dark
  case false:
    view.window?.overrideUserInterfaceStyle = .light
  }
}
  override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    if indexPath.row == 1{
      let cell = tableView.cellForRow(at: IndexPath(row: 1, section: 1))
      cell?.accessoryType = .checkmark
      view.window?.overrideUserInterfaceStyle = .unspecified
    }
    tableView.deselectRow(at: indexPath, animated: true)
  }

}
