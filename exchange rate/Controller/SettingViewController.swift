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
    turnOnDeviceAppearance(isOn: false)
    if darkModeLabel.isOn{
      let darkModeEnabled = true
      configureStyle(for: darkModeEnabled)
    }else{
      let darkModeEnabled = false
      configureStyle(for: darkModeEnabled)
    }
    defaults.set(false, forKey: "deviceAppearanceSelected")
  }
  
  override func viewDidAppear(_ animated: Bool) {
    super.viewDidAppear(animated)
        let deviceAppearance = defaults.bool(forKey: "deviceAppearanceSelected")
        print(deviceAppearance)
        guard deviceAppearance else {
          let darkModeEnabled = defaults.bool(forKey: "darkModeEnabled")
          switch darkModeEnabled {
          case true:
            darkModeLabel.isOn = true
          case false:
            darkModeLabel.isOn = false
          }
          return
        }
        turnOnDeviceAppearance(isOn: true)
    
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
  
  private func turnOnDeviceAppearance(isOn: Bool){
    let cell = tableView.cellForRow(at: IndexPath(row: 1, section: 1))
    if isOn == true{
      cell?.accessoryType = .checkmark
      view.window?.overrideUserInterfaceStyle = .unspecified
    }else{
      cell?.accessoryType = .none
    }
  }
  
  override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    darkModeLabel.isOn = false
    if indexPath.row == 1{
      defaults.set(true, forKey: "deviceAppearanceSelected")
      turnOnDeviceAppearance(isOn: true)
    }
    tableView.deselectRow(at: indexPath, animated: true)
  }
}
