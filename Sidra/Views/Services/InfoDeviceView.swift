//
//  InfoDeviceView.swift
//  Sidra
//
//  Created by AHMED ASSIRY on 13/04/1444 AH.
//

import SwiftUI

struct InfoDeviceView: View {
    
    @State var value : Int = 0
    let timer = Timer.publish(every: 0.5, on: .main, in: .common).autoconnect()
    
    @AppStorage("colorkey") var storedColor: Color = .black
    @State var showPercentSpace : Bool = true
    
    var body: some View {
        
        ScrollView(.vertical, showsIndicators: false) {
            VStack {
                
                VStack(alignment: .leading) {
                    HStack {
                        Image(systemName: "iphone.gen3")
                            .font(.system(size: 25))
                            .fontWeight(.ultraLight)
                        Text("\(DeviceInfo.name)")
                            .font(.title.bold())
                        
                    }
                    .padding(.bottom)
                    
                    Text("Operating system:")
                        .font(.footnote)
                        .foregroundColor(.gray)
                    Text("\(DeviceInfo.systemName) \(DeviceInfo.systemVersion)")
                        .padding(.bottom)
                    
                    Text("Device:")
                        .font(.footnote)
                        .foregroundColor(.gray)
                    Text("\(DeviceInfo.name)")
                        .padding(.bottom)
                    
                    Text("Last Reboot:")
                        .font(.footnote)
                        .foregroundColor(.gray)
                    Text(bootTime()?.formatted() ?? "Unknown")
                    
                }
                .foregroundColor(.primary)
                .padding()
                .frame(maxWidth: .infinity, alignment: .leading)
                .background(Color(UIColor.tertiarySystemBackground))
                .cornerRadius(16)
                .padding(.horizontal)
                
                VStack(alignment: .leading) {
                    HStack {
                        switch UIDevice.current.batteryState {
                        case .charging:
                            
                            Image(systemName: "battery.\(value)")
//                                .font(.system(size: 25))
                                .rotationEffect(.degrees(-90))
                                .fontWeight(.ultraLight)
                                .foregroundStyle(DeviceInfo.lowPowerMode ? .yellow : .green, .primary)
                            
                        case .full:
                            
                            Image(systemName: "battery.100.bolt")
                                .rotationEffect(.degrees(-90))
                                .fontWeight(.ultraLight)
                                .foregroundStyle(.white, .green)
                            
                        case .unplugged:
                            
                            Image(systemName: "battery.\(DeviceInfo.monitorBatteryImageString)")
                                .rotationEffect(.degrees(-90))
                                .fontWeight(.ultraLight)
                                .foregroundStyle(.green , .primary)
                            
                        default:
                            Text("Unknown")
                        }
                        
                        Text("Battery")
                            .font(.title.bold())
                        
                        Spacer()
                        
                        Button {
                            
                        } label: {
                            Text("\(DeviceInfo.batteryLevel)")
                                .foregroundColor(DeviceInfo.lowPowerMode ? .yellow : DeviceInfo.monitorBatteryColor)
                                .font(.title2.bold())
                                .fontWeight(.light)
                        }
                        
                    }
                    .onReceive(timer) { _ in
                        
                        if value < 100 {
                            value += 25
                        } else {
                            value = 0
                        }
                    }
                    
                    .padding(.bottom)
                    

                        
                    Text("Remaining Time:")
                        .font(.footnote)
                        .foregroundColor(.gray)
                    Text("\(DeviceInfo.systemName) \(DeviceInfo.systemVersion)")
                        .padding(.bottom)
                    
                    Text("Battery Monitoring Enabled?")
                        .font(.footnote)
                        .foregroundColor(.gray)
                    HStack {
                        Image(systemName: "checkmark.shield.fill")
                            .foregroundColor(DeviceInfo.isBatteryMonitoringEnabled ? .green : .primary)
                        Text(DeviceInfo.isBatteryMonitoringEnabled ? "True" : "False")
                    }
                    .padding(.bottom)
                    
                    Text("Battery Monitoring Enabled (After change)?")
                        .font(.footnote)
                        .foregroundColor(.gray)
                    HStack {
                        Image(systemName: "checkmark.shield.fill")
                            .foregroundColor(DeviceInfo.setBatteryMonitoring(to: true) ? .green : .primary)
                        Text(DeviceInfo.setBatteryMonitoring(to: true) ? "True" : "False")
                    }
                    .padding(.bottom)
                    
                }
                .foregroundColor(.primary)
                .padding()
                .frame(maxWidth: .infinity, alignment: .leading)
                .background(Color(UIColor.tertiarySystemBackground))
                .cornerRadius(16)
                .padding()
                
                
                VStack(alignment: .leading) {
                    HStack {
                        Image(systemName: "externaldrive")
                            
                        Text("Memory")
                            .font(.title.bold())
                            
                        
                        Spacer()

                        Text("\(Int(UIDevice.current.percentageUsedSpace * 100).formatted(.percent))")
                            .font(.title2.bold())
                            .fontWeight(.light)
                        
                    }
                    .padding(.bottom)
                    
                    HStack {
                        VStack(alignment: .leading) {
                            
                                Text("Free space:")
                                    .font(.footnote)
                                    .foregroundColor(.gray)
                                Text("\(UIDevice.current.freeDiskSpaceInGB)")
                                    .padding(.bottom)
                                
                                Text("Used space:")
                                    .font(.footnote)
                                    .foregroundColor(.gray)
                                Text("\(UIDevice.current.usedDiskSpaceInGB)")
                                    .padding(.bottom)
                            
                                Text("Total Space:")
                                    .font(.footnote)
                                    .foregroundColor(.gray)
                                Text("\(UIDevice.current.totalDiskSpaceInGB)")
                                    .padding(.bottom)
                            
                        }
                        
                            
                        ZStack {
                            if showPercentSpace {
                                CircularProgressView(progress: UIDevice.current.percentageFreeSpace, percentage: 1, BColor: storedColor)
                                    .padding(.horizontal)
                            } else {
                                CircularProgressView(progress: UIDevice.current.percentageUsedSpace, percentage: 1, BColor: storedColor)
                                    .padding(.horizontal)
                            }
                            
                            VStack(spacing: 12) {
                                Text(showPercentSpace ? "Used" : "Available")
                                    .font(.footnote)
                                    .foregroundColor(.gray)
                                Text(" \(showPercentSpace ? Int(UIDevice.current.percentageUsedSpace * 100).formatted(.percent) : Int(UIDevice.current.percentageFreeSpace * 100).formatted(.percent))")
                                    .font(.largeTitle.bold())
                            }
                            .offset(y: -10)
                            
                        }
                        .onTapGesture {
                            withAnimation(.easeInOut(duration: 0.5)) {
                                UISelectionFeedbackGenerator().selectionChanged()
                                showPercentSpace.toggle()
                            }
                        }
                    }
                    
                    
                }
                .foregroundColor(.primary)
                .padding()
                .frame(maxWidth: .infinity, alignment: .leading)
                .background(Color(UIColor.tertiarySystemBackground))
                .cornerRadius(16)
                .padding()
                
                VStack(alignment: .leading) {
                    HStack {
                        Image(systemName: "memorychip")
                            .rotationEffect(.degrees(-90))
                        Text("RAM")
                            .font(.title.bold())
                            .lineLimit(1)
                            .minimumScaleFactor(0.5)
                        
                    }
                    .padding(.bottom)
                    var taskInfo = mach_task_basic_info()
                    var count = mach_msg_type_number_t(MemoryLayout<mach_task_basic_info>.size)/4
                    let kerr: kern_return_t = withUnsafeMutablePointer(to: &taskInfo) {
                        $0.withMemoryRebound(to: integer_t.self, capacity: 1) {
                            task_info(mach_task_self_, task_flavor_t(MACH_TASK_BASIC_INFO), $0, &count)
                        }
                    }
                    
                    if kerr == KERN_SUCCESS {
                        Text("virtual memory size used in bytes: \(FileManagerUtility.convert(Int64(taskInfo.virtual_size))!) \n")
                        Text("resident memory size used in bytes: \(FileManagerUtility.convert(Int64(taskInfo.resident_size))!) \n")
                        Text("maximum resident memory size used in bytes: \(FileManagerUtility.convert(Int64(taskInfo.resident_size_max))!) \n")
//                        Text("total user run time for terminated threads: \(taskInfo.user_time) \n")
//                        Text("total system run time for terminated threads: \(taskInfo.system_time) \n")
                        Text("default policy for new threads: \(taskInfo.policy) \n")
                        Text("suspend count for task: \(taskInfo.suspend_count) \n")
                        
                    } else {
                        Text("Error with task_info(): " +
                             (String(cString: mach_error_string(kerr), encoding: String.Encoding.ascii) ?? "unknown error"))
                    }
                    
                }
                .foregroundColor(.primary)
                .padding()
                .frame(maxWidth: .infinity, alignment: .leading)
                .background(Color(UIColor.tertiarySystemBackground))
                .cornerRadius(16)
                .padding()

                
                VStack(alignment: .leading) {

                    
                    Divider().background(.white)
                    
                    if let totalNodesInBytes = FileManagerUtility.getFileSize(for: .systemNodes) {
                        /// If you want to convert into GB then call like this
                        let totalNodesInGB = FileManagerUtility.convert(totalNodesInBytes)
                        Text("Total nodes: \n \(totalNodesInBytes) bytes \n \(totalNodesInGB!)\n")
                    }
                    
                    if let freeNodesInBytes = FileManagerUtility.getFileSize(for: .systemFreeNodes) {
                        /// If you want to convert into GB then call like this
                        let freeNodesInGB = FileManagerUtility.convert(freeNodesInBytes)
                        Text("Free nodes: \n \(freeNodesInBytes) bytes \n \(freeNodesInGB!)\n")
                    }
                    
                    Divider().background(.white)
                    
                    if let totalNumberInBytes = FileManagerUtility.getFileSize(for: .systemNumber) {
                        /// If you want to convert into GB then call like this
                        let totalNumberInGB = FileManagerUtility.convert(totalNumberInBytes)
                        Text("Total Number: \n \(totalNumberInBytes) bytes \n \(totalNumberInGB!)\n")
                    }
                }
            }
        }
        .edgesIgnoringSafeArea(.bottom)
        .background(Color(UIColor.secondarySystemBackground))
    }
    
    func bootTime() -> Date? {
        var tv = timeval()
        var tvSize = MemoryLayout<timeval>.size
        let err = sysctlbyname("kern.boottime", &tv, &tvSize, nil, 0);
        guard err == 0, tvSize == MemoryLayout<timeval>.size else {
            return nil
        }
        return Date(timeIntervalSince1970: Double(tv.tv_sec) + Double(tv.tv_usec) / 1_000_000.0)
    }
    
}

struct InfoDeviceView_Previews: PreviewProvider {
    static var previews: some View {
        InfoDeviceView()
    }
}


struct FileManagerUtility {
    
    static func getFileSize(for key: FileAttributeKey) -> Int64? {
        let paths = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)
        
        guard
            let lastPath = paths.last,
            let attributeDictionary = try? FileManager.default.attributesOfFileSystem(forPath: lastPath) else { return nil }
        
        if let size = attributeDictionary[key] as? NSNumber {
            return size.int64Value
        } else {
            return nil
        }
    }
    
    static func convert(_ bytes: Int64, to units: ByteCountFormatter.Units = .useGB) -> String? {
        let formatter = ByteCountFormatter()
        formatter.allowedUnits = units
        formatter.countStyle = ByteCountFormatter.CountStyle.decimal
        formatter.includesUnit = true
        return formatter.string(fromByteCount: bytes)
    }
    
}


struct DeviceInfo {
    static var name: String {
        UIDevice.current.name
    }
    
    static var systemName: String {
        UIDevice.current.systemName
    }
    
    static var model: String {
        UIDevice.current.model
    }
    
    static var systemVersion: String {
        UIDevice.current.systemVersion
    }
    
    static var batteryState: String {
        switch UIDevice.current.batteryState {
        case .charging:
            return "Charging"
            
        case .full:
            return "Full"
            
        case .unplugged:
            return "Unplugged"
            
        default:
            return "Unknown"
        }
    }
    
    static var lowPowerMode: Bool {
        return ProcessInfo.processInfo.isLowPowerModeEnabled
    }
    
    static var isBatteryMonitoringEnabled: Bool {
        UIDevice.current.isBatteryMonitoringEnabled
    }
    
    static func setBatteryMonitoring(to value: Bool) -> Bool {
        UIDevice.current.isBatteryMonitoringEnabled = true
        return isBatteryMonitoringEnabled
    }
    
    static var batteryLevel: String {
        guard isBatteryMonitoringEnabled else { return "Unknown" }
        
        let battery = UIDevice.current.batteryLevel
        if battery == -1 {
            return "Unknown"
        }
        
        return "\(Int(battery * 100).formatted(.percent))"
    }
    
    static var monitorBatteryColor: Color {
        let battery = UIDevice.current.batteryLevel
        if battery == -1 {
            return .clear
        }
        switch UIDevice.current.batteryLevel {
        case 0..<0.2:
            return .red
            
        case 0.9...1:
            return .green
            
        default:
            return .primary
        }
    }
    
    static var monitorBatteryImageString: String {
        let battery = UIDevice.current.batteryLevel
        if battery == -1 {
            return "Unknown"
        }
        switch UIDevice.current.batteryLevel {
           
        case 0.05..<0.50:
            return "25"
            
        case 0.50..<0.75:
            return "50"
            
        case 0.75..<1:
            return "75"
            
        case 1:
            return "100"
            
        default:
            return "0"
        }
    }
}


extension UIDevice {
    
    func MBFormatter(_ bytes: Int64) -> String {
        let formatter = ByteCountFormatter()
        formatter.allowedUnits = ByteCountFormatter.Units.useMB
        formatter.countStyle = ByteCountFormatter.CountStyle.decimal
        formatter.includesUnit = false
        return formatter.string(fromByteCount: bytes) as String
    }
    
    //MARK: Get String Value
    var totalDiskSpaceInGB : String {
       return ByteCountFormatter.string(fromByteCount: totalDiskSpaceInBytes, countStyle: ByteCountFormatter.CountStyle.decimal)
    }
    
    var freeDiskSpaceInGB : String {
        return ByteCountFormatter.string(fromByteCount: freeDiskSpaceInBytes, countStyle: ByteCountFormatter.CountStyle.decimal)
    }
    
    var usedDiskSpaceInGB : String {
        return ByteCountFormatter.string(fromByteCount: usedDiskSpaceInBytes, countStyle: ByteCountFormatter.CountStyle.decimal)
    }
    
    var totalDiskSpaceInMB : String {
        return MBFormatter(totalDiskSpaceInBytes)
    }
    
    var freeDiskSpaceInMB : String {
        return MBFormatter(freeDiskSpaceInBytes)
    }
    
    var usedDiskSpaceInMB : String {
        return MBFormatter(usedDiskSpaceInBytes)
    }
    
    //MARK: Get raw value
    var totalDiskSpaceInBytes : Int64 {
        guard let systemAttributes = try? FileManager.default.attributesOfFileSystem(forPath: NSHomeDirectory() as String),
            let space = (systemAttributes[FileAttributeKey.systemSize] as? NSNumber)?.int64Value else { return 0 }
        return space
    }
    
    /*
     Total available capacity in bytes for "Important" resources, including space expected to be cleared by purging non-essential and cached resources. "Important" means something that the user or application clearly expects to be present on the local system, but is ultimately replaceable. This would include items that the user has explicitly requested via the UI, and resources that an application requires in order to provide functionality.
     Examples: A video that the user has explicitly requested to watch but has not yet finished watching or an audio file that the user has requested to download.
     This value should not be used in determining if there is room for an irreplaceable resource. In the case of irreplaceable resources, always attempt to save the resource regardless of available capacity and handle failure as gracefully as possible.
     */
    var freeDiskSpaceInBytes : Int64 {
        if #available(iOS 11.0, *) {
            if let space = try? URL(fileURLWithPath: NSHomeDirectory() as String).resourceValues(forKeys: [URLResourceKey.volumeAvailableCapacityForImportantUsageKey]).volumeAvailableCapacityForImportantUsage {
                return space
            } else {
                return 0
            }
        } else {
            if let systemAttributes = try? FileManager.default.attributesOfFileSystem(forPath: NSHomeDirectory() as String),
            let freeSpace = (systemAttributes[FileAttributeKey.systemFreeSize] as? NSNumber)?.int64Value {
                return freeSpace
            } else {
                return 0
            }
        }
    }
    
    var usedDiskSpaceInBytes : Int64 {
       return totalDiskSpaceInBytes - freeDiskSpaceInBytes
    }
    
    var percentageUsedSpace : Double {
        return Double(truncating: usedDiskSpaceInBytes as NSNumber) / Double(truncating: totalDiskSpaceInBytes as NSNumber)
    }
    
    var percentageFreeSpace : Double {
        return Double(truncating: freeDiskSpaceInBytes as NSNumber) / Double(truncating: totalDiskSpaceInBytes as NSNumber)
    }
}
